-- ====================================================================
-- GlikoRehber Supabase Initial Schema & RLS Policies
-- ====================================================================

-- 1. ENUM TYPES
create type diabetes_type as enum (
  'type1',
  'type2_prandial_insulin',
  'type2_basal_or_none',
  'other'
);

create type verification_status as enum (
  'official_verified',
  'label_verified',
  'community_unverified',
  'user_entered',
  'sample_only'
);

-- 2. FOOD SOURCES
create table food_sources (
  id uuid primary key default gen_random_uuid(),
  name text not null, -- TürKomp, USDA FDC, Open Food Facts
  url text,
  license text,
  attribution_text text,
  version text,
  created_at timestamptz default now()
);

-- 3. FOODS TABLE
create table foods (
  id uuid primary key default gen_random_uuid(),
  name_tr text not null,
  name_en text,
  normalized_name text not null,
  category text,
  brand text,
  barcode text unique,
  preparation text not null default 'as_sold', -- raw / cooked / boiled / fried / as_sold
  carbs_g_per_100g numeric(6,2) not null check (carbs_g_per_100g between 0 and 100),
  sugars_g_per_100g numeric(6,2) check (sugars_g_per_100g between 0 and 100),
  fiber_g_per_100g numeric(6,2) check (fiber_g_per_100g between 0 and 100),
  protein_g_per_100g numeric(6,2) not null default 0 check (protein_g_per_100g between 0 and 100),
  fat_g_per_100g numeric(6,2) not null default 0 check (fat_g_per_100g between 0 and 100),
  kcal_per_100g numeric(6,1) not null default 0 check (kcal_per_100g >= 0),
  gi smallint check (gi between 0 and 110),
  gi_source text,
  source_id uuid references food_sources(id) on delete set null,
  source_ref text,
  data_date date,
  verification verification_status not null default 'community_unverified',
  verified_by uuid,
  verified_at timestamptz,
  is_sample boolean not null default false,
  version int not null default 1,
  updated_at timestamptz default now(),

  -- Quality constraints
  constraint sugars_le_carbs check (sugars_g_per_100g is null or sugars_g_per_100g <= carbs_g_per_100g),
  constraint fiber_le_carbs check (fiber_g_per_100g is null or fiber_g_per_100g <= carbs_g_per_100g),
  constraint macros_sum check ((carbs_g_per_100g + protein_g_per_100g + fat_g_per_100g) <= 105.0)
);

-- Index for Turkish text search
create index idx_foods_normalized_name on foods(normalized_name);
create index idx_foods_barcode on foods(barcode);
create index idx_foods_is_sample on foods(is_sample);

-- 4. FOOD PORTIONS
create table food_portions (
  id uuid primary key default gen_random_uuid(),
  food_id uuid not null references foods(id) on delete cascade,
  label_tr text not null,
  grams numeric(7,2) not null check (grams > 0),
  source_ref text not null
);

create index idx_food_portions_food_id on food_portions(food_id);

-- 5. AUDIT & QUARANTINE TABLES
create table food_audit_log (
  id uuid primary key default gen_random_uuid(),
  food_id uuid not null references foods(id) on delete cascade,
  changed_by uuid,
  field_name text not null,
  old_value text,
  new_value text,
  changed_at timestamptz default now()
);

create table import_quarantine (
  id uuid primary key default gen_random_uuid(),
  source_id uuid references food_sources(id),
  raw_data jsonb not null,
  rejection_reason text not null,
  quarantined_at timestamptz default now()
);

-- 6. USER PROFILES
create table profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  birth_year int check (birth_year > 1900 and birth_year <= extract(year from current_date)),
  diabetes_type diabetes_type not null default 'type1',
  glucose_unit text not null default 'mgdl' check (glucose_unit in ('mgdl', 'mmoll')),
  uses_syringe boolean not null default false,
  insulin_concentration smallint not null default 100 check (insulin_concentration in (100, 200, 300, 500)),
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 7. THERAPY SETTINGS (Versioned - historical records preserved)
create table therapy_settings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  icr_blocks jsonb not null, -- [{from:"06:00",to:"11:00",gPerUnit:10}, ...]
  isf_mgdl_per_unit numeric check (isf_mgdl_per_unit > 0),
  target_mgdl numeric check (target_mgdl > 0),
  dia_hours numeric check (dia_hours between 2 and 8),
  dose_step numeric not null check (dose_step in (0.1, 0.5, 1.0)),
  max_single_dose numeric not null check (max_single_dose > 0),
  allow_negative_correction boolean not null default false,
  subtract_fiber boolean not null default false,
  confirmed_with_clinician boolean not null default false,
  created_at timestamptz default now()
);

create index idx_therapy_settings_user_id on therapy_settings(user_id, created_at desc);

-- 8. GLUCOSE LOGS
create table glucose_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  value_mgdl numeric not null check (value_mgdl between 20 and 600),
  context text not null check (context in ('fasting', 'postprandial', 'bedtime', 'exercise', 'other')),
  measured_at timestamptz not null default now(),
  note text
);

create index idx_glucose_logs_user_measured on glucose_logs(user_id, measured_at desc);

-- 9. MEAL LOGS
create table meal_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  items jsonb not null, -- [{food_id, food_name, grams, carbs_g, verification}]
  total_carbs_g numeric not null check (total_carbs_g >= 0),
  created_at timestamptz not null default now()
);

-- 10. DOSE LOGS (Strictly APPEND-ONLY - Safety and Legal Audit)
create table dose_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  meal_log_id uuid references meal_logs(id) on delete set null,
  input_snapshot jsonb not null,
  result_snapshot jsonb not null,
  engine_version text not null default '1.0.0',
  applied_units numeric not null check (applied_units >= 0),
  applied_at timestamptz not null default now()
);

create index idx_dose_logs_user_applied on dose_logs(user_id, applied_at desc);

-- 11. CONSENT LOGS (Strictly APPEND-ONLY)
create table consent_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  type text not null, -- 'medical_disclaimer', 'gdpr_kvkk', 'data_sync'
  text_version text not null,
  accepted_at timestamptz not null default now()
);

-- 12. EDUCATION ARTICLES
create table education_articles (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  title_tr text not null,
  body_md text not null,
  reviewed_by text,
  reviewed_at date,
  sources jsonb default '[]'::jsonb,
  created_at timestamptz default now()
);

-- ====================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ====================================================================

-- Enable RLS on all tables
alter table food_sources enable row level security;
alter table foods enable row level security;
alter table food_portions enable row level security;
alter table food_audit_log enable row level security;
alter table import_quarantine enable row level security;
alter table profiles enable row level security;
alter table therapy_settings enable row level security;
alter table glucose_logs enable row level security;
alter table meal_logs enable row level security;
alter table dose_logs enable row level security;
alter table consent_logs enable row level security;
alter table education_articles enable row level security;

-- Food and Education tables are public readable
create policy "Foods are viewable by all users"
  on foods for select using (true);

create policy "Food portions are viewable by all users"
  on food_portions for select using (true);

create policy "Food sources are viewable by all users"
  on food_sources for select using (true);

create policy "Education articles are viewable by all users"
  on education_articles for select using (true);

-- User-specific tables: full access to own records
create policy "Users can view own profile"
  on profiles for select using (auth.uid() = user_id);
create policy "Users can update own profile"
  on profiles for update using (auth.uid() = user_id);
create policy "Users can insert own profile"
  on profiles for insert with check (auth.uid() = user_id);

create policy "Users can manage own therapy settings"
  on therapy_settings for all using (auth.uid() = user_id);

create policy "Users can manage own glucose logs"
  on glucose_logs for all using (auth.uid() = user_id);

create policy "Users can manage own meal logs"
  on meal_logs for all using (auth.uid() = user_id);

-- DOSE LOGS: APPEND-ONLY (Select and Insert allowed; Update and Delete strictly forbidden!)
create policy "Users can view own dose logs"
  on dose_logs for select using (auth.uid() = user_id);
create policy "Users can insert own dose logs"
  on dose_logs for insert with check (auth.uid() = user_id);
-- No UPDATE or DELETE policies created for dose_logs!

-- CONSENT LOGS: APPEND-ONLY (Select and Insert allowed; Update and Delete strictly forbidden!)
create policy "Users can view own consent logs"
  on consent_logs for select using (auth.uid() = user_id);
create policy "Users can insert own consent logs"
  on consent_logs for insert with check (auth.uid() = user_id);
-- No UPDATE or DELETE policies created for consent_logs!
