// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalFoodsTable extends LocalFoods
    with TableInfo<$LocalFoodsTable, LocalFood> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalFoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameTrMeta = const VerificationMeta('nameTr');
  @override
  late final GeneratedColumn<String> nameTr = GeneratedColumn<String>(
    'name_tr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preparationMeta = const VerificationMeta(
    'preparation',
  );
  @override
  late final GeneratedColumn<String> preparation = GeneratedColumn<String>(
    'preparation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('as_sold'),
  );
  static const VerificationMeta _carbsGPer100gMeta = const VerificationMeta(
    'carbsGPer100g',
  );
  @override
  late final GeneratedColumn<double> carbsGPer100g = GeneratedColumn<double>(
    'carbs_g_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sugarsGPer100gMeta = const VerificationMeta(
    'sugarsGPer100g',
  );
  @override
  late final GeneratedColumn<double> sugarsGPer100g = GeneratedColumn<double>(
    'sugars_g_per100g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fiberGPer100gMeta = const VerificationMeta(
    'fiberGPer100g',
  );
  @override
  late final GeneratedColumn<double> fiberGPer100g = GeneratedColumn<double>(
    'fiber_g_per100g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinGPer100gMeta = const VerificationMeta(
    'proteinGPer100g',
  );
  @override
  late final GeneratedColumn<double> proteinGPer100g = GeneratedColumn<double>(
    'protein_g_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _fatGPer100gMeta = const VerificationMeta(
    'fatGPer100g',
  );
  @override
  late final GeneratedColumn<double> fatGPer100g = GeneratedColumn<double>(
    'fat_g_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _kcalPer100gMeta = const VerificationMeta(
    'kcalPer100g',
  );
  @override
  late final GeneratedColumn<double> kcalPer100g = GeneratedColumn<double>(
    'kcal_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _giMeta = const VerificationMeta('gi');
  @override
  late final GeneratedColumn<int> gi = GeneratedColumn<int>(
    'gi',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _giSourceMeta = const VerificationMeta(
    'giSource',
  );
  @override
  late final GeneratedColumn<String> giSource = GeneratedColumn<String>(
    'gi_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _verificationMeta = const VerificationMeta(
    'verification',
  );
  @override
  late final GeneratedColumn<String> verification = GeneratedColumn<String>(
    'verification',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('community_unverified'),
  );
  static const VerificationMeta _isSampleMeta = const VerificationMeta(
    'isSample',
  );
  @override
  late final GeneratedColumn<bool> isSample = GeneratedColumn<bool>(
    'is_sample',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_sample" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameTr,
    nameEn,
    normalizedName,
    category,
    brand,
    barcode,
    preparation,
    carbsGPer100g,
    sugarsGPer100g,
    fiberGPer100g,
    proteinGPer100g,
    fatGPer100g,
    kcalPer100g,
    gi,
    giSource,
    sourceRef,
    verification,
    isSample,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_foods';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalFood> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_tr')) {
      context.handle(
        _nameTrMeta,
        nameTr.isAcceptableOrUnknown(data['name_tr']!, _nameTrMeta),
      );
    } else if (isInserting) {
      context.missing(_nameTrMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('preparation')) {
      context.handle(
        _preparationMeta,
        preparation.isAcceptableOrUnknown(
          data['preparation']!,
          _preparationMeta,
        ),
      );
    }
    if (data.containsKey('carbs_g_per100g')) {
      context.handle(
        _carbsGPer100gMeta,
        carbsGPer100g.isAcceptableOrUnknown(
          data['carbs_g_per100g']!,
          _carbsGPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbsGPer100gMeta);
    }
    if (data.containsKey('sugars_g_per100g')) {
      context.handle(
        _sugarsGPer100gMeta,
        sugarsGPer100g.isAcceptableOrUnknown(
          data['sugars_g_per100g']!,
          _sugarsGPer100gMeta,
        ),
      );
    }
    if (data.containsKey('fiber_g_per100g')) {
      context.handle(
        _fiberGPer100gMeta,
        fiberGPer100g.isAcceptableOrUnknown(
          data['fiber_g_per100g']!,
          _fiberGPer100gMeta,
        ),
      );
    }
    if (data.containsKey('protein_g_per100g')) {
      context.handle(
        _proteinGPer100gMeta,
        proteinGPer100g.isAcceptableOrUnknown(
          data['protein_g_per100g']!,
          _proteinGPer100gMeta,
        ),
      );
    }
    if (data.containsKey('fat_g_per100g')) {
      context.handle(
        _fatGPer100gMeta,
        fatGPer100g.isAcceptableOrUnknown(
          data['fat_g_per100g']!,
          _fatGPer100gMeta,
        ),
      );
    }
    if (data.containsKey('kcal_per100g')) {
      context.handle(
        _kcalPer100gMeta,
        kcalPer100g.isAcceptableOrUnknown(
          data['kcal_per100g']!,
          _kcalPer100gMeta,
        ),
      );
    }
    if (data.containsKey('gi')) {
      context.handle(_giMeta, gi.isAcceptableOrUnknown(data['gi']!, _giMeta));
    }
    if (data.containsKey('gi_source')) {
      context.handle(
        _giSourceMeta,
        giSource.isAcceptableOrUnknown(data['gi_source']!, _giSourceMeta),
      );
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('verification')) {
      context.handle(
        _verificationMeta,
        verification.isAcceptableOrUnknown(
          data['verification']!,
          _verificationMeta,
        ),
      );
    }
    if (data.containsKey('is_sample')) {
      context.handle(
        _isSampleMeta,
        isSample.isAcceptableOrUnknown(data['is_sample']!, _isSampleMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalFood map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalFood(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_tr'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      preparation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preparation'],
      )!,
      carbsGPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_g_per100g'],
      )!,
      sugarsGPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sugars_g_per100g'],
      ),
      fiberGPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber_g_per100g'],
      ),
      proteinGPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g_per100g'],
      )!,
      fatGPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_g_per100g'],
      )!,
      kcalPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_per100g'],
      )!,
      gi: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gi'],
      ),
      giSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gi_source'],
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      verification: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verification'],
      )!,
      isSample: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_sample'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocalFoodsTable createAlias(String alias) {
    return $LocalFoodsTable(attachedDatabase, alias);
  }
}

class LocalFood extends DataClass implements Insertable<LocalFood> {
  final String id;
  final String nameTr;
  final String? nameEn;
  final String normalizedName;
  final String? category;
  final String? brand;
  final String? barcode;
  final String preparation;
  final double carbsGPer100g;
  final double? sugarsGPer100g;
  final double? fiberGPer100g;
  final double proteinGPer100g;
  final double fatGPer100g;
  final double kcalPer100g;
  final int? gi;
  final String? giSource;
  final String? sourceRef;
  final String verification;
  final bool isSample;
  final DateTime updatedAt;
  const LocalFood({
    required this.id,
    required this.nameTr,
    this.nameEn,
    required this.normalizedName,
    this.category,
    this.brand,
    this.barcode,
    required this.preparation,
    required this.carbsGPer100g,
    this.sugarsGPer100g,
    this.fiberGPer100g,
    required this.proteinGPer100g,
    required this.fatGPer100g,
    required this.kcalPer100g,
    this.gi,
    this.giSource,
    this.sourceRef,
    required this.verification,
    required this.isSample,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_tr'] = Variable<String>(nameTr);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    map['normalized_name'] = Variable<String>(normalizedName);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['preparation'] = Variable<String>(preparation);
    map['carbs_g_per100g'] = Variable<double>(carbsGPer100g);
    if (!nullToAbsent || sugarsGPer100g != null) {
      map['sugars_g_per100g'] = Variable<double>(sugarsGPer100g);
    }
    if (!nullToAbsent || fiberGPer100g != null) {
      map['fiber_g_per100g'] = Variable<double>(fiberGPer100g);
    }
    map['protein_g_per100g'] = Variable<double>(proteinGPer100g);
    map['fat_g_per100g'] = Variable<double>(fatGPer100g);
    map['kcal_per100g'] = Variable<double>(kcalPer100g);
    if (!nullToAbsent || gi != null) {
      map['gi'] = Variable<int>(gi);
    }
    if (!nullToAbsent || giSource != null) {
      map['gi_source'] = Variable<String>(giSource);
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    map['verification'] = Variable<String>(verification);
    map['is_sample'] = Variable<bool>(isSample);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalFoodsCompanion toCompanion(bool nullToAbsent) {
    return LocalFoodsCompanion(
      id: Value(id),
      nameTr: Value(nameTr),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      normalizedName: Value(normalizedName),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      preparation: Value(preparation),
      carbsGPer100g: Value(carbsGPer100g),
      sugarsGPer100g: sugarsGPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(sugarsGPer100g),
      fiberGPer100g: fiberGPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(fiberGPer100g),
      proteinGPer100g: Value(proteinGPer100g),
      fatGPer100g: Value(fatGPer100g),
      kcalPer100g: Value(kcalPer100g),
      gi: gi == null && nullToAbsent ? const Value.absent() : Value(gi),
      giSource: giSource == null && nullToAbsent
          ? const Value.absent()
          : Value(giSource),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      verification: Value(verification),
      isSample: Value(isSample),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalFood.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalFood(
      id: serializer.fromJson<String>(json['id']),
      nameTr: serializer.fromJson<String>(json['nameTr']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      category: serializer.fromJson<String?>(json['category']),
      brand: serializer.fromJson<String?>(json['brand']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      preparation: serializer.fromJson<String>(json['preparation']),
      carbsGPer100g: serializer.fromJson<double>(json['carbsGPer100g']),
      sugarsGPer100g: serializer.fromJson<double?>(json['sugarsGPer100g']),
      fiberGPer100g: serializer.fromJson<double?>(json['fiberGPer100g']),
      proteinGPer100g: serializer.fromJson<double>(json['proteinGPer100g']),
      fatGPer100g: serializer.fromJson<double>(json['fatGPer100g']),
      kcalPer100g: serializer.fromJson<double>(json['kcalPer100g']),
      gi: serializer.fromJson<int?>(json['gi']),
      giSource: serializer.fromJson<String?>(json['giSource']),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      verification: serializer.fromJson<String>(json['verification']),
      isSample: serializer.fromJson<bool>(json['isSample']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameTr': serializer.toJson<String>(nameTr),
      'nameEn': serializer.toJson<String?>(nameEn),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'category': serializer.toJson<String?>(category),
      'brand': serializer.toJson<String?>(brand),
      'barcode': serializer.toJson<String?>(barcode),
      'preparation': serializer.toJson<String>(preparation),
      'carbsGPer100g': serializer.toJson<double>(carbsGPer100g),
      'sugarsGPer100g': serializer.toJson<double?>(sugarsGPer100g),
      'fiberGPer100g': serializer.toJson<double?>(fiberGPer100g),
      'proteinGPer100g': serializer.toJson<double>(proteinGPer100g),
      'fatGPer100g': serializer.toJson<double>(fatGPer100g),
      'kcalPer100g': serializer.toJson<double>(kcalPer100g),
      'gi': serializer.toJson<int?>(gi),
      'giSource': serializer.toJson<String?>(giSource),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'verification': serializer.toJson<String>(verification),
      'isSample': serializer.toJson<bool>(isSample),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalFood copyWith({
    String? id,
    String? nameTr,
    Value<String?> nameEn = const Value.absent(),
    String? normalizedName,
    Value<String?> category = const Value.absent(),
    Value<String?> brand = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    String? preparation,
    double? carbsGPer100g,
    Value<double?> sugarsGPer100g = const Value.absent(),
    Value<double?> fiberGPer100g = const Value.absent(),
    double? proteinGPer100g,
    double? fatGPer100g,
    double? kcalPer100g,
    Value<int?> gi = const Value.absent(),
    Value<String?> giSource = const Value.absent(),
    Value<String?> sourceRef = const Value.absent(),
    String? verification,
    bool? isSample,
    DateTime? updatedAt,
  }) => LocalFood(
    id: id ?? this.id,
    nameTr: nameTr ?? this.nameTr,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    normalizedName: normalizedName ?? this.normalizedName,
    category: category.present ? category.value : this.category,
    brand: brand.present ? brand.value : this.brand,
    barcode: barcode.present ? barcode.value : this.barcode,
    preparation: preparation ?? this.preparation,
    carbsGPer100g: carbsGPer100g ?? this.carbsGPer100g,
    sugarsGPer100g: sugarsGPer100g.present
        ? sugarsGPer100g.value
        : this.sugarsGPer100g,
    fiberGPer100g: fiberGPer100g.present
        ? fiberGPer100g.value
        : this.fiberGPer100g,
    proteinGPer100g: proteinGPer100g ?? this.proteinGPer100g,
    fatGPer100g: fatGPer100g ?? this.fatGPer100g,
    kcalPer100g: kcalPer100g ?? this.kcalPer100g,
    gi: gi.present ? gi.value : this.gi,
    giSource: giSource.present ? giSource.value : this.giSource,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    verification: verification ?? this.verification,
    isSample: isSample ?? this.isSample,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalFood copyWithCompanion(LocalFoodsCompanion data) {
    return LocalFood(
      id: data.id.present ? data.id.value : this.id,
      nameTr: data.nameTr.present ? data.nameTr.value : this.nameTr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      category: data.category.present ? data.category.value : this.category,
      brand: data.brand.present ? data.brand.value : this.brand,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      preparation: data.preparation.present
          ? data.preparation.value
          : this.preparation,
      carbsGPer100g: data.carbsGPer100g.present
          ? data.carbsGPer100g.value
          : this.carbsGPer100g,
      sugarsGPer100g: data.sugarsGPer100g.present
          ? data.sugarsGPer100g.value
          : this.sugarsGPer100g,
      fiberGPer100g: data.fiberGPer100g.present
          ? data.fiberGPer100g.value
          : this.fiberGPer100g,
      proteinGPer100g: data.proteinGPer100g.present
          ? data.proteinGPer100g.value
          : this.proteinGPer100g,
      fatGPer100g: data.fatGPer100g.present
          ? data.fatGPer100g.value
          : this.fatGPer100g,
      kcalPer100g: data.kcalPer100g.present
          ? data.kcalPer100g.value
          : this.kcalPer100g,
      gi: data.gi.present ? data.gi.value : this.gi,
      giSource: data.giSource.present ? data.giSource.value : this.giSource,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      verification: data.verification.present
          ? data.verification.value
          : this.verification,
      isSample: data.isSample.present ? data.isSample.value : this.isSample,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalFood(')
          ..write('id: $id, ')
          ..write('nameTr: $nameTr, ')
          ..write('nameEn: $nameEn, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('category: $category, ')
          ..write('brand: $brand, ')
          ..write('barcode: $barcode, ')
          ..write('preparation: $preparation, ')
          ..write('carbsGPer100g: $carbsGPer100g, ')
          ..write('sugarsGPer100g: $sugarsGPer100g, ')
          ..write('fiberGPer100g: $fiberGPer100g, ')
          ..write('proteinGPer100g: $proteinGPer100g, ')
          ..write('fatGPer100g: $fatGPer100g, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('gi: $gi, ')
          ..write('giSource: $giSource, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('verification: $verification, ')
          ..write('isSample: $isSample, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameTr,
    nameEn,
    normalizedName,
    category,
    brand,
    barcode,
    preparation,
    carbsGPer100g,
    sugarsGPer100g,
    fiberGPer100g,
    proteinGPer100g,
    fatGPer100g,
    kcalPer100g,
    gi,
    giSource,
    sourceRef,
    verification,
    isSample,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalFood &&
          other.id == this.id &&
          other.nameTr == this.nameTr &&
          other.nameEn == this.nameEn &&
          other.normalizedName == this.normalizedName &&
          other.category == this.category &&
          other.brand == this.brand &&
          other.barcode == this.barcode &&
          other.preparation == this.preparation &&
          other.carbsGPer100g == this.carbsGPer100g &&
          other.sugarsGPer100g == this.sugarsGPer100g &&
          other.fiberGPer100g == this.fiberGPer100g &&
          other.proteinGPer100g == this.proteinGPer100g &&
          other.fatGPer100g == this.fatGPer100g &&
          other.kcalPer100g == this.kcalPer100g &&
          other.gi == this.gi &&
          other.giSource == this.giSource &&
          other.sourceRef == this.sourceRef &&
          other.verification == this.verification &&
          other.isSample == this.isSample &&
          other.updatedAt == this.updatedAt);
}

class LocalFoodsCompanion extends UpdateCompanion<LocalFood> {
  final Value<String> id;
  final Value<String> nameTr;
  final Value<String?> nameEn;
  final Value<String> normalizedName;
  final Value<String?> category;
  final Value<String?> brand;
  final Value<String?> barcode;
  final Value<String> preparation;
  final Value<double> carbsGPer100g;
  final Value<double?> sugarsGPer100g;
  final Value<double?> fiberGPer100g;
  final Value<double> proteinGPer100g;
  final Value<double> fatGPer100g;
  final Value<double> kcalPer100g;
  final Value<int?> gi;
  final Value<String?> giSource;
  final Value<String?> sourceRef;
  final Value<String> verification;
  final Value<bool> isSample;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalFoodsCompanion({
    this.id = const Value.absent(),
    this.nameTr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.category = const Value.absent(),
    this.brand = const Value.absent(),
    this.barcode = const Value.absent(),
    this.preparation = const Value.absent(),
    this.carbsGPer100g = const Value.absent(),
    this.sugarsGPer100g = const Value.absent(),
    this.fiberGPer100g = const Value.absent(),
    this.proteinGPer100g = const Value.absent(),
    this.fatGPer100g = const Value.absent(),
    this.kcalPer100g = const Value.absent(),
    this.gi = const Value.absent(),
    this.giSource = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.verification = const Value.absent(),
    this.isSample = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalFoodsCompanion.insert({
    required String id,
    required String nameTr,
    this.nameEn = const Value.absent(),
    required String normalizedName,
    this.category = const Value.absent(),
    this.brand = const Value.absent(),
    this.barcode = const Value.absent(),
    this.preparation = const Value.absent(),
    required double carbsGPer100g,
    this.sugarsGPer100g = const Value.absent(),
    this.fiberGPer100g = const Value.absent(),
    this.proteinGPer100g = const Value.absent(),
    this.fatGPer100g = const Value.absent(),
    this.kcalPer100g = const Value.absent(),
    this.gi = const Value.absent(),
    this.giSource = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.verification = const Value.absent(),
    this.isSample = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameTr = Value(nameTr),
       normalizedName = Value(normalizedName),
       carbsGPer100g = Value(carbsGPer100g);
  static Insertable<LocalFood> custom({
    Expression<String>? id,
    Expression<String>? nameTr,
    Expression<String>? nameEn,
    Expression<String>? normalizedName,
    Expression<String>? category,
    Expression<String>? brand,
    Expression<String>? barcode,
    Expression<String>? preparation,
    Expression<double>? carbsGPer100g,
    Expression<double>? sugarsGPer100g,
    Expression<double>? fiberGPer100g,
    Expression<double>? proteinGPer100g,
    Expression<double>? fatGPer100g,
    Expression<double>? kcalPer100g,
    Expression<int>? gi,
    Expression<String>? giSource,
    Expression<String>? sourceRef,
    Expression<String>? verification,
    Expression<bool>? isSample,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameTr != null) 'name_tr': nameTr,
      if (nameEn != null) 'name_en': nameEn,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (category != null) 'category': category,
      if (brand != null) 'brand': brand,
      if (barcode != null) 'barcode': barcode,
      if (preparation != null) 'preparation': preparation,
      if (carbsGPer100g != null) 'carbs_g_per100g': carbsGPer100g,
      if (sugarsGPer100g != null) 'sugars_g_per100g': sugarsGPer100g,
      if (fiberGPer100g != null) 'fiber_g_per100g': fiberGPer100g,
      if (proteinGPer100g != null) 'protein_g_per100g': proteinGPer100g,
      if (fatGPer100g != null) 'fat_g_per100g': fatGPer100g,
      if (kcalPer100g != null) 'kcal_per100g': kcalPer100g,
      if (gi != null) 'gi': gi,
      if (giSource != null) 'gi_source': giSource,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (verification != null) 'verification': verification,
      if (isSample != null) 'is_sample': isSample,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalFoodsCompanion copyWith({
    Value<String>? id,
    Value<String>? nameTr,
    Value<String?>? nameEn,
    Value<String>? normalizedName,
    Value<String?>? category,
    Value<String?>? brand,
    Value<String?>? barcode,
    Value<String>? preparation,
    Value<double>? carbsGPer100g,
    Value<double?>? sugarsGPer100g,
    Value<double?>? fiberGPer100g,
    Value<double>? proteinGPer100g,
    Value<double>? fatGPer100g,
    Value<double>? kcalPer100g,
    Value<int?>? gi,
    Value<String?>? giSource,
    Value<String?>? sourceRef,
    Value<String>? verification,
    Value<bool>? isSample,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocalFoodsCompanion(
      id: id ?? this.id,
      nameTr: nameTr ?? this.nameTr,
      nameEn: nameEn ?? this.nameEn,
      normalizedName: normalizedName ?? this.normalizedName,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      barcode: barcode ?? this.barcode,
      preparation: preparation ?? this.preparation,
      carbsGPer100g: carbsGPer100g ?? this.carbsGPer100g,
      sugarsGPer100g: sugarsGPer100g ?? this.sugarsGPer100g,
      fiberGPer100g: fiberGPer100g ?? this.fiberGPer100g,
      proteinGPer100g: proteinGPer100g ?? this.proteinGPer100g,
      fatGPer100g: fatGPer100g ?? this.fatGPer100g,
      kcalPer100g: kcalPer100g ?? this.kcalPer100g,
      gi: gi ?? this.gi,
      giSource: giSource ?? this.giSource,
      sourceRef: sourceRef ?? this.sourceRef,
      verification: verification ?? this.verification,
      isSample: isSample ?? this.isSample,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameTr.present) {
      map['name_tr'] = Variable<String>(nameTr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (preparation.present) {
      map['preparation'] = Variable<String>(preparation.value);
    }
    if (carbsGPer100g.present) {
      map['carbs_g_per100g'] = Variable<double>(carbsGPer100g.value);
    }
    if (sugarsGPer100g.present) {
      map['sugars_g_per100g'] = Variable<double>(sugarsGPer100g.value);
    }
    if (fiberGPer100g.present) {
      map['fiber_g_per100g'] = Variable<double>(fiberGPer100g.value);
    }
    if (proteinGPer100g.present) {
      map['protein_g_per100g'] = Variable<double>(proteinGPer100g.value);
    }
    if (fatGPer100g.present) {
      map['fat_g_per100g'] = Variable<double>(fatGPer100g.value);
    }
    if (kcalPer100g.present) {
      map['kcal_per100g'] = Variable<double>(kcalPer100g.value);
    }
    if (gi.present) {
      map['gi'] = Variable<int>(gi.value);
    }
    if (giSource.present) {
      map['gi_source'] = Variable<String>(giSource.value);
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (verification.present) {
      map['verification'] = Variable<String>(verification.value);
    }
    if (isSample.present) {
      map['is_sample'] = Variable<bool>(isSample.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalFoodsCompanion(')
          ..write('id: $id, ')
          ..write('nameTr: $nameTr, ')
          ..write('nameEn: $nameEn, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('category: $category, ')
          ..write('brand: $brand, ')
          ..write('barcode: $barcode, ')
          ..write('preparation: $preparation, ')
          ..write('carbsGPer100g: $carbsGPer100g, ')
          ..write('sugarsGPer100g: $sugarsGPer100g, ')
          ..write('fiberGPer100g: $fiberGPer100g, ')
          ..write('proteinGPer100g: $proteinGPer100g, ')
          ..write('fatGPer100g: $fatGPer100g, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('gi: $gi, ')
          ..write('giSource: $giSource, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('verification: $verification, ')
          ..write('isSample: $isSample, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalFoodPortionsTable extends LocalFoodPortions
    with TableInfo<$LocalFoodPortionsTable, LocalFoodPortion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalFoodPortionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
    'food_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelTrMeta = const VerificationMeta(
    'labelTr',
  );
  @override
  late final GeneratedColumn<String> labelTr = GeneratedColumn<String>(
    'label_tr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gramsMeta = const VerificationMeta('grams');
  @override
  late final GeneratedColumn<double> grams = GeneratedColumn<double>(
    'grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, foodId, labelTr, grams, sourceRef];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_food_portions';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalFoodPortion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(
        _foodIdMeta,
        foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('label_tr')) {
      context.handle(
        _labelTrMeta,
        labelTr.isAcceptableOrUnknown(data['label_tr']!, _labelTrMeta),
      );
    } else if (isInserting) {
      context.missing(_labelTrMeta);
    }
    if (data.containsKey('grams')) {
      context.handle(
        _gramsMeta,
        grams.isAcceptableOrUnknown(data['grams']!, _gramsMeta),
      );
    } else if (isInserting) {
      context.missing(_gramsMeta);
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceRefMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalFoodPortion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalFoodPortion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      foodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_id'],
      )!,
      labelTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_tr'],
      )!,
      grams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grams'],
      )!,
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      )!,
    );
  }

  @override
  $LocalFoodPortionsTable createAlias(String alias) {
    return $LocalFoodPortionsTable(attachedDatabase, alias);
  }
}

class LocalFoodPortion extends DataClass
    implements Insertable<LocalFoodPortion> {
  final String id;
  final String foodId;
  final String labelTr;
  final double grams;
  final String sourceRef;
  const LocalFoodPortion({
    required this.id,
    required this.foodId,
    required this.labelTr,
    required this.grams,
    required this.sourceRef,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['food_id'] = Variable<String>(foodId);
    map['label_tr'] = Variable<String>(labelTr);
    map['grams'] = Variable<double>(grams);
    map['source_ref'] = Variable<String>(sourceRef);
    return map;
  }

  LocalFoodPortionsCompanion toCompanion(bool nullToAbsent) {
    return LocalFoodPortionsCompanion(
      id: Value(id),
      foodId: Value(foodId),
      labelTr: Value(labelTr),
      grams: Value(grams),
      sourceRef: Value(sourceRef),
    );
  }

  factory LocalFoodPortion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalFoodPortion(
      id: serializer.fromJson<String>(json['id']),
      foodId: serializer.fromJson<String>(json['foodId']),
      labelTr: serializer.fromJson<String>(json['labelTr']),
      grams: serializer.fromJson<double>(json['grams']),
      sourceRef: serializer.fromJson<String>(json['sourceRef']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'foodId': serializer.toJson<String>(foodId),
      'labelTr': serializer.toJson<String>(labelTr),
      'grams': serializer.toJson<double>(grams),
      'sourceRef': serializer.toJson<String>(sourceRef),
    };
  }

  LocalFoodPortion copyWith({
    String? id,
    String? foodId,
    String? labelTr,
    double? grams,
    String? sourceRef,
  }) => LocalFoodPortion(
    id: id ?? this.id,
    foodId: foodId ?? this.foodId,
    labelTr: labelTr ?? this.labelTr,
    grams: grams ?? this.grams,
    sourceRef: sourceRef ?? this.sourceRef,
  );
  LocalFoodPortion copyWithCompanion(LocalFoodPortionsCompanion data) {
    return LocalFoodPortion(
      id: data.id.present ? data.id.value : this.id,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      labelTr: data.labelTr.present ? data.labelTr.value : this.labelTr,
      grams: data.grams.present ? data.grams.value : this.grams,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalFoodPortion(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('labelTr: $labelTr, ')
          ..write('grams: $grams, ')
          ..write('sourceRef: $sourceRef')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, foodId, labelTr, grams, sourceRef);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalFoodPortion &&
          other.id == this.id &&
          other.foodId == this.foodId &&
          other.labelTr == this.labelTr &&
          other.grams == this.grams &&
          other.sourceRef == this.sourceRef);
}

class LocalFoodPortionsCompanion extends UpdateCompanion<LocalFoodPortion> {
  final Value<String> id;
  final Value<String> foodId;
  final Value<String> labelTr;
  final Value<double> grams;
  final Value<String> sourceRef;
  final Value<int> rowid;
  const LocalFoodPortionsCompanion({
    this.id = const Value.absent(),
    this.foodId = const Value.absent(),
    this.labelTr = const Value.absent(),
    this.grams = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalFoodPortionsCompanion.insert({
    required String id,
    required String foodId,
    required String labelTr,
    required double grams,
    required String sourceRef,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       foodId = Value(foodId),
       labelTr = Value(labelTr),
       grams = Value(grams),
       sourceRef = Value(sourceRef);
  static Insertable<LocalFoodPortion> custom({
    Expression<String>? id,
    Expression<String>? foodId,
    Expression<String>? labelTr,
    Expression<double>? grams,
    Expression<String>? sourceRef,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodId != null) 'food_id': foodId,
      if (labelTr != null) 'label_tr': labelTr,
      if (grams != null) 'grams': grams,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalFoodPortionsCompanion copyWith({
    Value<String>? id,
    Value<String>? foodId,
    Value<String>? labelTr,
    Value<double>? grams,
    Value<String>? sourceRef,
    Value<int>? rowid,
  }) {
    return LocalFoodPortionsCompanion(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      labelTr: labelTr ?? this.labelTr,
      grams: grams ?? this.grams,
      sourceRef: sourceRef ?? this.sourceRef,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (labelTr.present) {
      map['label_tr'] = Variable<String>(labelTr.value);
    }
    if (grams.present) {
      map['grams'] = Variable<double>(grams.value);
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalFoodPortionsCompanion(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('labelTr: $labelTr, ')
          ..write('grams: $grams, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalGlucoseLogsTable extends LocalGlucoseLogs
    with TableInfo<$LocalGlucoseLogsTable, LocalGlucoseLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalGlucoseLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMgDlMeta = const VerificationMeta(
    'valueMgDl',
  );
  @override
  late final GeneratedColumn<double> valueMgDl = GeneratedColumn<double>(
    'value_mg_dl',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contextMeta = const VerificationMeta(
    'context',
  );
  @override
  late final GeneratedColumn<String> context = GeneratedColumn<String>(
    'context',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _measuredAtMeta = const VerificationMeta(
    'measuredAt',
  );
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
    'measured_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    valueMgDl,
    context,
    measuredAt,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_glucose_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalGlucoseLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('value_mg_dl')) {
      context.handle(
        _valueMgDlMeta,
        valueMgDl.isAcceptableOrUnknown(data['value_mg_dl']!, _valueMgDlMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMgDlMeta);
    }
    if (data.containsKey('context')) {
      context.handle(
        _contextMeta,
        this.context.isAcceptableOrUnknown(data['context']!, _contextMeta),
      );
    } else if (isInserting) {
      context.missing(_contextMeta);
    }
    if (data.containsKey('measured_at')) {
      context.handle(
        _measuredAtMeta,
        measuredAt.isAcceptableOrUnknown(data['measured_at']!, _measuredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalGlucoseLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalGlucoseLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      valueMgDl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value_mg_dl'],
      )!,
      context: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context'],
      )!,
      measuredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}measured_at'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $LocalGlucoseLogsTable createAlias(String alias) {
    return $LocalGlucoseLogsTable(attachedDatabase, alias);
  }
}

class LocalGlucoseLog extends DataClass implements Insertable<LocalGlucoseLog> {
  final String id;
  final double valueMgDl;
  final String context;
  final DateTime measuredAt;
  final String? note;
  const LocalGlucoseLog({
    required this.id,
    required this.valueMgDl,
    required this.context,
    required this.measuredAt,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['value_mg_dl'] = Variable<double>(valueMgDl);
    map['context'] = Variable<String>(context);
    map['measured_at'] = Variable<DateTime>(measuredAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  LocalGlucoseLogsCompanion toCompanion(bool nullToAbsent) {
    return LocalGlucoseLogsCompanion(
      id: Value(id),
      valueMgDl: Value(valueMgDl),
      context: Value(context),
      measuredAt: Value(measuredAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory LocalGlucoseLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalGlucoseLog(
      id: serializer.fromJson<String>(json['id']),
      valueMgDl: serializer.fromJson<double>(json['valueMgDl']),
      context: serializer.fromJson<String>(json['context']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'valueMgDl': serializer.toJson<double>(valueMgDl),
      'context': serializer.toJson<String>(context),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
      'note': serializer.toJson<String?>(note),
    };
  }

  LocalGlucoseLog copyWith({
    String? id,
    double? valueMgDl,
    String? context,
    DateTime? measuredAt,
    Value<String?> note = const Value.absent(),
  }) => LocalGlucoseLog(
    id: id ?? this.id,
    valueMgDl: valueMgDl ?? this.valueMgDl,
    context: context ?? this.context,
    measuredAt: measuredAt ?? this.measuredAt,
    note: note.present ? note.value : this.note,
  );
  LocalGlucoseLog copyWithCompanion(LocalGlucoseLogsCompanion data) {
    return LocalGlucoseLog(
      id: data.id.present ? data.id.value : this.id,
      valueMgDl: data.valueMgDl.present ? data.valueMgDl.value : this.valueMgDl,
      context: data.context.present ? data.context.value : this.context,
      measuredAt: data.measuredAt.present
          ? data.measuredAt.value
          : this.measuredAt,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalGlucoseLog(')
          ..write('id: $id, ')
          ..write('valueMgDl: $valueMgDl, ')
          ..write('context: $context, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, valueMgDl, context, measuredAt, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalGlucoseLog &&
          other.id == this.id &&
          other.valueMgDl == this.valueMgDl &&
          other.context == this.context &&
          other.measuredAt == this.measuredAt &&
          other.note == this.note);
}

class LocalGlucoseLogsCompanion extends UpdateCompanion<LocalGlucoseLog> {
  final Value<String> id;
  final Value<double> valueMgDl;
  final Value<String> context;
  final Value<DateTime> measuredAt;
  final Value<String?> note;
  final Value<int> rowid;
  const LocalGlucoseLogsCompanion({
    this.id = const Value.absent(),
    this.valueMgDl = const Value.absent(),
    this.context = const Value.absent(),
    this.measuredAt = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalGlucoseLogsCompanion.insert({
    required String id,
    required double valueMgDl,
    required String context,
    required DateTime measuredAt,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       valueMgDl = Value(valueMgDl),
       context = Value(context),
       measuredAt = Value(measuredAt);
  static Insertable<LocalGlucoseLog> custom({
    Expression<String>? id,
    Expression<double>? valueMgDl,
    Expression<String>? context,
    Expression<DateTime>? measuredAt,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (valueMgDl != null) 'value_mg_dl': valueMgDl,
      if (context != null) 'context': context,
      if (measuredAt != null) 'measured_at': measuredAt,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalGlucoseLogsCompanion copyWith({
    Value<String>? id,
    Value<double>? valueMgDl,
    Value<String>? context,
    Value<DateTime>? measuredAt,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return LocalGlucoseLogsCompanion(
      id: id ?? this.id,
      valueMgDl: valueMgDl ?? this.valueMgDl,
      context: context ?? this.context,
      measuredAt: measuredAt ?? this.measuredAt,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (valueMgDl.present) {
      map['value_mg_dl'] = Variable<double>(valueMgDl.value);
    }
    if (context.present) {
      map['context'] = Variable<String>(context.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalGlucoseLogsCompanion(')
          ..write('id: $id, ')
          ..write('valueMgDl: $valueMgDl, ')
          ..write('context: $context, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalDoseLogsTable extends LocalDoseLogs
    with TableInfo<$LocalDoseLogsTable, LocalDoseLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalDoseLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appliedUnitsMeta = const VerificationMeta(
    'appliedUnits',
  );
  @override
  late final GeneratedColumn<double> appliedUnits = GeneratedColumn<double>(
    'applied_units',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appliedAtMeta = const VerificationMeta(
    'appliedAt',
  );
  @override
  late final GeneratedColumn<DateTime> appliedAt = GeneratedColumn<DateTime>(
    'applied_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inputSnapshotMeta = const VerificationMeta(
    'inputSnapshot',
  );
  @override
  late final GeneratedColumn<String> inputSnapshot = GeneratedColumn<String>(
    'input_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultSnapshotMeta = const VerificationMeta(
    'resultSnapshot',
  );
  @override
  late final GeneratedColumn<String> resultSnapshot = GeneratedColumn<String>(
    'result_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _engineVersionMeta = const VerificationMeta(
    'engineVersion',
  );
  @override
  late final GeneratedColumn<String> engineVersion = GeneratedColumn<String>(
    'engine_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('1.0.0'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    appliedUnits,
    appliedAt,
    inputSnapshot,
    resultSnapshot,
    engineVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_dose_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalDoseLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('applied_units')) {
      context.handle(
        _appliedUnitsMeta,
        appliedUnits.isAcceptableOrUnknown(
          data['applied_units']!,
          _appliedUnitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appliedUnitsMeta);
    }
    if (data.containsKey('applied_at')) {
      context.handle(
        _appliedAtMeta,
        appliedAt.isAcceptableOrUnknown(data['applied_at']!, _appliedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_appliedAtMeta);
    }
    if (data.containsKey('input_snapshot')) {
      context.handle(
        _inputSnapshotMeta,
        inputSnapshot.isAcceptableOrUnknown(
          data['input_snapshot']!,
          _inputSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inputSnapshotMeta);
    }
    if (data.containsKey('result_snapshot')) {
      context.handle(
        _resultSnapshotMeta,
        resultSnapshot.isAcceptableOrUnknown(
          data['result_snapshot']!,
          _resultSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_resultSnapshotMeta);
    }
    if (data.containsKey('engine_version')) {
      context.handle(
        _engineVersionMeta,
        engineVersion.isAcceptableOrUnknown(
          data['engine_version']!,
          _engineVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalDoseLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalDoseLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      appliedUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}applied_units'],
      )!,
      appliedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}applied_at'],
      )!,
      inputSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}input_snapshot'],
      )!,
      resultSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_snapshot'],
      )!,
      engineVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engine_version'],
      )!,
    );
  }

  @override
  $LocalDoseLogsTable createAlias(String alias) {
    return $LocalDoseLogsTable(attachedDatabase, alias);
  }
}

class LocalDoseLog extends DataClass implements Insertable<LocalDoseLog> {
  final String id;
  final double appliedUnits;
  final DateTime appliedAt;
  final String inputSnapshot;
  final String resultSnapshot;
  final String engineVersion;
  const LocalDoseLog({
    required this.id,
    required this.appliedUnits,
    required this.appliedAt,
    required this.inputSnapshot,
    required this.resultSnapshot,
    required this.engineVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['applied_units'] = Variable<double>(appliedUnits);
    map['applied_at'] = Variable<DateTime>(appliedAt);
    map['input_snapshot'] = Variable<String>(inputSnapshot);
    map['result_snapshot'] = Variable<String>(resultSnapshot);
    map['engine_version'] = Variable<String>(engineVersion);
    return map;
  }

  LocalDoseLogsCompanion toCompanion(bool nullToAbsent) {
    return LocalDoseLogsCompanion(
      id: Value(id),
      appliedUnits: Value(appliedUnits),
      appliedAt: Value(appliedAt),
      inputSnapshot: Value(inputSnapshot),
      resultSnapshot: Value(resultSnapshot),
      engineVersion: Value(engineVersion),
    );
  }

  factory LocalDoseLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalDoseLog(
      id: serializer.fromJson<String>(json['id']),
      appliedUnits: serializer.fromJson<double>(json['appliedUnits']),
      appliedAt: serializer.fromJson<DateTime>(json['appliedAt']),
      inputSnapshot: serializer.fromJson<String>(json['inputSnapshot']),
      resultSnapshot: serializer.fromJson<String>(json['resultSnapshot']),
      engineVersion: serializer.fromJson<String>(json['engineVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'appliedUnits': serializer.toJson<double>(appliedUnits),
      'appliedAt': serializer.toJson<DateTime>(appliedAt),
      'inputSnapshot': serializer.toJson<String>(inputSnapshot),
      'resultSnapshot': serializer.toJson<String>(resultSnapshot),
      'engineVersion': serializer.toJson<String>(engineVersion),
    };
  }

  LocalDoseLog copyWith({
    String? id,
    double? appliedUnits,
    DateTime? appliedAt,
    String? inputSnapshot,
    String? resultSnapshot,
    String? engineVersion,
  }) => LocalDoseLog(
    id: id ?? this.id,
    appliedUnits: appliedUnits ?? this.appliedUnits,
    appliedAt: appliedAt ?? this.appliedAt,
    inputSnapshot: inputSnapshot ?? this.inputSnapshot,
    resultSnapshot: resultSnapshot ?? this.resultSnapshot,
    engineVersion: engineVersion ?? this.engineVersion,
  );
  LocalDoseLog copyWithCompanion(LocalDoseLogsCompanion data) {
    return LocalDoseLog(
      id: data.id.present ? data.id.value : this.id,
      appliedUnits: data.appliedUnits.present
          ? data.appliedUnits.value
          : this.appliedUnits,
      appliedAt: data.appliedAt.present ? data.appliedAt.value : this.appliedAt,
      inputSnapshot: data.inputSnapshot.present
          ? data.inputSnapshot.value
          : this.inputSnapshot,
      resultSnapshot: data.resultSnapshot.present
          ? data.resultSnapshot.value
          : this.resultSnapshot,
      engineVersion: data.engineVersion.present
          ? data.engineVersion.value
          : this.engineVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalDoseLog(')
          ..write('id: $id, ')
          ..write('appliedUnits: $appliedUnits, ')
          ..write('appliedAt: $appliedAt, ')
          ..write('inputSnapshot: $inputSnapshot, ')
          ..write('resultSnapshot: $resultSnapshot, ')
          ..write('engineVersion: $engineVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    appliedUnits,
    appliedAt,
    inputSnapshot,
    resultSnapshot,
    engineVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalDoseLog &&
          other.id == this.id &&
          other.appliedUnits == this.appliedUnits &&
          other.appliedAt == this.appliedAt &&
          other.inputSnapshot == this.inputSnapshot &&
          other.resultSnapshot == this.resultSnapshot &&
          other.engineVersion == this.engineVersion);
}

class LocalDoseLogsCompanion extends UpdateCompanion<LocalDoseLog> {
  final Value<String> id;
  final Value<double> appliedUnits;
  final Value<DateTime> appliedAt;
  final Value<String> inputSnapshot;
  final Value<String> resultSnapshot;
  final Value<String> engineVersion;
  final Value<int> rowid;
  const LocalDoseLogsCompanion({
    this.id = const Value.absent(),
    this.appliedUnits = const Value.absent(),
    this.appliedAt = const Value.absent(),
    this.inputSnapshot = const Value.absent(),
    this.resultSnapshot = const Value.absent(),
    this.engineVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalDoseLogsCompanion.insert({
    required String id,
    required double appliedUnits,
    required DateTime appliedAt,
    required String inputSnapshot,
    required String resultSnapshot,
    this.engineVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       appliedUnits = Value(appliedUnits),
       appliedAt = Value(appliedAt),
       inputSnapshot = Value(inputSnapshot),
       resultSnapshot = Value(resultSnapshot);
  static Insertable<LocalDoseLog> custom({
    Expression<String>? id,
    Expression<double>? appliedUnits,
    Expression<DateTime>? appliedAt,
    Expression<String>? inputSnapshot,
    Expression<String>? resultSnapshot,
    Expression<String>? engineVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (appliedUnits != null) 'applied_units': appliedUnits,
      if (appliedAt != null) 'applied_at': appliedAt,
      if (inputSnapshot != null) 'input_snapshot': inputSnapshot,
      if (resultSnapshot != null) 'result_snapshot': resultSnapshot,
      if (engineVersion != null) 'engine_version': engineVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalDoseLogsCompanion copyWith({
    Value<String>? id,
    Value<double>? appliedUnits,
    Value<DateTime>? appliedAt,
    Value<String>? inputSnapshot,
    Value<String>? resultSnapshot,
    Value<String>? engineVersion,
    Value<int>? rowid,
  }) {
    return LocalDoseLogsCompanion(
      id: id ?? this.id,
      appliedUnits: appliedUnits ?? this.appliedUnits,
      appliedAt: appliedAt ?? this.appliedAt,
      inputSnapshot: inputSnapshot ?? this.inputSnapshot,
      resultSnapshot: resultSnapshot ?? this.resultSnapshot,
      engineVersion: engineVersion ?? this.engineVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (appliedUnits.present) {
      map['applied_units'] = Variable<double>(appliedUnits.value);
    }
    if (appliedAt.present) {
      map['applied_at'] = Variable<DateTime>(appliedAt.value);
    }
    if (inputSnapshot.present) {
      map['input_snapshot'] = Variable<String>(inputSnapshot.value);
    }
    if (resultSnapshot.present) {
      map['result_snapshot'] = Variable<String>(resultSnapshot.value);
    }
    if (engineVersion.present) {
      map['engine_version'] = Variable<String>(engineVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalDoseLogsCompanion(')
          ..write('id: $id, ')
          ..write('appliedUnits: $appliedUnits, ')
          ..write('appliedAt: $appliedAt, ')
          ..write('inputSnapshot: $inputSnapshot, ')
          ..write('resultSnapshot: $resultSnapshot, ')
          ..write('engineVersion: $engineVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalConsentLogsTable extends LocalConsentLogs
    with TableInfo<$LocalConsentLogsTable, LocalConsentLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalConsentLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textVersionMeta = const VerificationMeta(
    'textVersion',
  );
  @override
  late final GeneratedColumn<String> textVersion = GeneratedColumn<String>(
    'text_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _acceptedAtMeta = const VerificationMeta(
    'acceptedAt',
  );
  @override
  late final GeneratedColumn<DateTime> acceptedAt = GeneratedColumn<DateTime>(
    'accepted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, type, textVersion, acceptedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_consent_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalConsentLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('text_version')) {
      context.handle(
        _textVersionMeta,
        textVersion.isAcceptableOrUnknown(
          data['text_version']!,
          _textVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textVersionMeta);
    }
    if (data.containsKey('accepted_at')) {
      context.handle(
        _acceptedAtMeta,
        acceptedAt.isAcceptableOrUnknown(data['accepted_at']!, _acceptedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_acceptedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalConsentLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalConsentLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      textVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_version'],
      )!,
      acceptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}accepted_at'],
      )!,
    );
  }

  @override
  $LocalConsentLogsTable createAlias(String alias) {
    return $LocalConsentLogsTable(attachedDatabase, alias);
  }
}

class LocalConsentLog extends DataClass implements Insertable<LocalConsentLog> {
  final String id;
  final String type;
  final String textVersion;
  final DateTime acceptedAt;
  const LocalConsentLog({
    required this.id,
    required this.type,
    required this.textVersion,
    required this.acceptedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['text_version'] = Variable<String>(textVersion);
    map['accepted_at'] = Variable<DateTime>(acceptedAt);
    return map;
  }

  LocalConsentLogsCompanion toCompanion(bool nullToAbsent) {
    return LocalConsentLogsCompanion(
      id: Value(id),
      type: Value(type),
      textVersion: Value(textVersion),
      acceptedAt: Value(acceptedAt),
    );
  }

  factory LocalConsentLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalConsentLog(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      textVersion: serializer.fromJson<String>(json['textVersion']),
      acceptedAt: serializer.fromJson<DateTime>(json['acceptedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'textVersion': serializer.toJson<String>(textVersion),
      'acceptedAt': serializer.toJson<DateTime>(acceptedAt),
    };
  }

  LocalConsentLog copyWith({
    String? id,
    String? type,
    String? textVersion,
    DateTime? acceptedAt,
  }) => LocalConsentLog(
    id: id ?? this.id,
    type: type ?? this.type,
    textVersion: textVersion ?? this.textVersion,
    acceptedAt: acceptedAt ?? this.acceptedAt,
  );
  LocalConsentLog copyWithCompanion(LocalConsentLogsCompanion data) {
    return LocalConsentLog(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      textVersion: data.textVersion.present
          ? data.textVersion.value
          : this.textVersion,
      acceptedAt: data.acceptedAt.present
          ? data.acceptedAt.value
          : this.acceptedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalConsentLog(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('textVersion: $textVersion, ')
          ..write('acceptedAt: $acceptedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, textVersion, acceptedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalConsentLog &&
          other.id == this.id &&
          other.type == this.type &&
          other.textVersion == this.textVersion &&
          other.acceptedAt == this.acceptedAt);
}

class LocalConsentLogsCompanion extends UpdateCompanion<LocalConsentLog> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> textVersion;
  final Value<DateTime> acceptedAt;
  final Value<int> rowid;
  const LocalConsentLogsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.textVersion = const Value.absent(),
    this.acceptedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalConsentLogsCompanion.insert({
    required String id,
    required String type,
    required String textVersion,
    required DateTime acceptedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       textVersion = Value(textVersion),
       acceptedAt = Value(acceptedAt);
  static Insertable<LocalConsentLog> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? textVersion,
    Expression<DateTime>? acceptedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (textVersion != null) 'text_version': textVersion,
      if (acceptedAt != null) 'accepted_at': acceptedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalConsentLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? textVersion,
    Value<DateTime>? acceptedAt,
    Value<int>? rowid,
  }) {
    return LocalConsentLogsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      textVersion: textVersion ?? this.textVersion,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (textVersion.present) {
      map['text_version'] = Variable<String>(textVersion.value);
    }
    if (acceptedAt.present) {
      map['accepted_at'] = Variable<DateTime>(acceptedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalConsentLogsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('textVersion: $textVersion, ')
          ..write('acceptedAt: $acceptedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalTherapySettingsTable extends LocalTherapySettings
    with TableInfo<$LocalTherapySettingsTable, LocalTherapySetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalTherapySettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _icrBlocksJsonMeta = const VerificationMeta(
    'icrBlocksJson',
  );
  @override
  late final GeneratedColumn<String> icrBlocksJson = GeneratedColumn<String>(
    'icr_blocks_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _defaultIcrMeta = const VerificationMeta(
    'defaultIcr',
  );
  @override
  late final GeneratedColumn<double> defaultIcr = GeneratedColumn<double>(
    'default_icr',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isfMeta = const VerificationMeta('isf');
  @override
  late final GeneratedColumn<double> isf = GeneratedColumn<double>(
    'isf',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetGlucoseMeta = const VerificationMeta(
    'targetGlucose',
  );
  @override
  late final GeneratedColumn<double> targetGlucose = GeneratedColumn<double>(
    'target_glucose',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diaHoursMeta = const VerificationMeta(
    'diaHours',
  );
  @override
  late final GeneratedColumn<double> diaHours = GeneratedColumn<double>(
    'dia_hours',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doseStepMeta = const VerificationMeta(
    'doseStep',
  );
  @override
  late final GeneratedColumn<double> doseStep = GeneratedColumn<double>(
    'dose_step',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.5),
  );
  static const VerificationMeta _maxSingleDoseMeta = const VerificationMeta(
    'maxSingleDose',
  );
  @override
  late final GeneratedColumn<double> maxSingleDose = GeneratedColumn<double>(
    'max_single_dose',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(15.0),
  );
  static const VerificationMeta _allowNegativeCorrectionMeta =
      const VerificationMeta('allowNegativeCorrection');
  @override
  late final GeneratedColumn<bool> allowNegativeCorrection =
      GeneratedColumn<bool>(
        'allow_negative_correction',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_negative_correction" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _subtractFiberMeta = const VerificationMeta(
    'subtractFiber',
  );
  @override
  late final GeneratedColumn<bool> subtractFiber = GeneratedColumn<bool>(
    'subtract_fiber',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("subtract_fiber" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _confirmedWithClinicianMeta =
      const VerificationMeta('confirmedWithClinician');
  @override
  late final GeneratedColumn<bool> confirmedWithClinician =
      GeneratedColumn<bool>(
        'confirmed_with_clinician',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("confirmed_with_clinician" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    icrBlocksJson,
    defaultIcr,
    isf,
    targetGlucose,
    diaHours,
    doseStep,
    maxSingleDose,
    allowNegativeCorrection,
    subtractFiber,
    confirmedWithClinician,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_therapy_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalTherapySetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('icr_blocks_json')) {
      context.handle(
        _icrBlocksJsonMeta,
        icrBlocksJson.isAcceptableOrUnknown(
          data['icr_blocks_json']!,
          _icrBlocksJsonMeta,
        ),
      );
    }
    if (data.containsKey('default_icr')) {
      context.handle(
        _defaultIcrMeta,
        defaultIcr.isAcceptableOrUnknown(data['default_icr']!, _defaultIcrMeta),
      );
    }
    if (data.containsKey('isf')) {
      context.handle(
        _isfMeta,
        isf.isAcceptableOrUnknown(data['isf']!, _isfMeta),
      );
    }
    if (data.containsKey('target_glucose')) {
      context.handle(
        _targetGlucoseMeta,
        targetGlucose.isAcceptableOrUnknown(
          data['target_glucose']!,
          _targetGlucoseMeta,
        ),
      );
    }
    if (data.containsKey('dia_hours')) {
      context.handle(
        _diaHoursMeta,
        diaHours.isAcceptableOrUnknown(data['dia_hours']!, _diaHoursMeta),
      );
    }
    if (data.containsKey('dose_step')) {
      context.handle(
        _doseStepMeta,
        doseStep.isAcceptableOrUnknown(data['dose_step']!, _doseStepMeta),
      );
    }
    if (data.containsKey('max_single_dose')) {
      context.handle(
        _maxSingleDoseMeta,
        maxSingleDose.isAcceptableOrUnknown(
          data['max_single_dose']!,
          _maxSingleDoseMeta,
        ),
      );
    }
    if (data.containsKey('allow_negative_correction')) {
      context.handle(
        _allowNegativeCorrectionMeta,
        allowNegativeCorrection.isAcceptableOrUnknown(
          data['allow_negative_correction']!,
          _allowNegativeCorrectionMeta,
        ),
      );
    }
    if (data.containsKey('subtract_fiber')) {
      context.handle(
        _subtractFiberMeta,
        subtractFiber.isAcceptableOrUnknown(
          data['subtract_fiber']!,
          _subtractFiberMeta,
        ),
      );
    }
    if (data.containsKey('confirmed_with_clinician')) {
      context.handle(
        _confirmedWithClinicianMeta,
        confirmedWithClinician.isAcceptableOrUnknown(
          data['confirmed_with_clinician']!,
          _confirmedWithClinicianMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalTherapySetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalTherapySetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      icrBlocksJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icr_blocks_json'],
      )!,
      defaultIcr: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_icr'],
      ),
      isf: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}isf'],
      ),
      targetGlucose: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_glucose'],
      ),
      diaHours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dia_hours'],
      ),
      doseStep: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dose_step'],
      )!,
      maxSingleDose: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_single_dose'],
      )!,
      allowNegativeCorrection: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}allow_negative_correction'],
      )!,
      subtractFiber: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}subtract_fiber'],
      )!,
      confirmedWithClinician: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}confirmed_with_clinician'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocalTherapySettingsTable createAlias(String alias) {
    return $LocalTherapySettingsTable(attachedDatabase, alias);
  }
}

class LocalTherapySetting extends DataClass
    implements Insertable<LocalTherapySetting> {
  final String id;
  final String icrBlocksJson;
  final double? defaultIcr;
  final double? isf;
  final double? targetGlucose;
  final double? diaHours;
  final double doseStep;
  final double maxSingleDose;
  final bool allowNegativeCorrection;
  final bool subtractFiber;
  final bool confirmedWithClinician;
  final DateTime createdAt;
  const LocalTherapySetting({
    required this.id,
    required this.icrBlocksJson,
    this.defaultIcr,
    this.isf,
    this.targetGlucose,
    this.diaHours,
    required this.doseStep,
    required this.maxSingleDose,
    required this.allowNegativeCorrection,
    required this.subtractFiber,
    required this.confirmedWithClinician,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['icr_blocks_json'] = Variable<String>(icrBlocksJson);
    if (!nullToAbsent || defaultIcr != null) {
      map['default_icr'] = Variable<double>(defaultIcr);
    }
    if (!nullToAbsent || isf != null) {
      map['isf'] = Variable<double>(isf);
    }
    if (!nullToAbsent || targetGlucose != null) {
      map['target_glucose'] = Variable<double>(targetGlucose);
    }
    if (!nullToAbsent || diaHours != null) {
      map['dia_hours'] = Variable<double>(diaHours);
    }
    map['dose_step'] = Variable<double>(doseStep);
    map['max_single_dose'] = Variable<double>(maxSingleDose);
    map['allow_negative_correction'] = Variable<bool>(allowNegativeCorrection);
    map['subtract_fiber'] = Variable<bool>(subtractFiber);
    map['confirmed_with_clinician'] = Variable<bool>(confirmedWithClinician);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalTherapySettingsCompanion toCompanion(bool nullToAbsent) {
    return LocalTherapySettingsCompanion(
      id: Value(id),
      icrBlocksJson: Value(icrBlocksJson),
      defaultIcr: defaultIcr == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultIcr),
      isf: isf == null && nullToAbsent ? const Value.absent() : Value(isf),
      targetGlucose: targetGlucose == null && nullToAbsent
          ? const Value.absent()
          : Value(targetGlucose),
      diaHours: diaHours == null && nullToAbsent
          ? const Value.absent()
          : Value(diaHours),
      doseStep: Value(doseStep),
      maxSingleDose: Value(maxSingleDose),
      allowNegativeCorrection: Value(allowNegativeCorrection),
      subtractFiber: Value(subtractFiber),
      confirmedWithClinician: Value(confirmedWithClinician),
      createdAt: Value(createdAt),
    );
  }

  factory LocalTherapySetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalTherapySetting(
      id: serializer.fromJson<String>(json['id']),
      icrBlocksJson: serializer.fromJson<String>(json['icrBlocksJson']),
      defaultIcr: serializer.fromJson<double?>(json['defaultIcr']),
      isf: serializer.fromJson<double?>(json['isf']),
      targetGlucose: serializer.fromJson<double?>(json['targetGlucose']),
      diaHours: serializer.fromJson<double?>(json['diaHours']),
      doseStep: serializer.fromJson<double>(json['doseStep']),
      maxSingleDose: serializer.fromJson<double>(json['maxSingleDose']),
      allowNegativeCorrection: serializer.fromJson<bool>(
        json['allowNegativeCorrection'],
      ),
      subtractFiber: serializer.fromJson<bool>(json['subtractFiber']),
      confirmedWithClinician: serializer.fromJson<bool>(
        json['confirmedWithClinician'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'icrBlocksJson': serializer.toJson<String>(icrBlocksJson),
      'defaultIcr': serializer.toJson<double?>(defaultIcr),
      'isf': serializer.toJson<double?>(isf),
      'targetGlucose': serializer.toJson<double?>(targetGlucose),
      'diaHours': serializer.toJson<double?>(diaHours),
      'doseStep': serializer.toJson<double>(doseStep),
      'maxSingleDose': serializer.toJson<double>(maxSingleDose),
      'allowNegativeCorrection': serializer.toJson<bool>(
        allowNegativeCorrection,
      ),
      'subtractFiber': serializer.toJson<bool>(subtractFiber),
      'confirmedWithClinician': serializer.toJson<bool>(confirmedWithClinician),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalTherapySetting copyWith({
    String? id,
    String? icrBlocksJson,
    Value<double?> defaultIcr = const Value.absent(),
    Value<double?> isf = const Value.absent(),
    Value<double?> targetGlucose = const Value.absent(),
    Value<double?> diaHours = const Value.absent(),
    double? doseStep,
    double? maxSingleDose,
    bool? allowNegativeCorrection,
    bool? subtractFiber,
    bool? confirmedWithClinician,
    DateTime? createdAt,
  }) => LocalTherapySetting(
    id: id ?? this.id,
    icrBlocksJson: icrBlocksJson ?? this.icrBlocksJson,
    defaultIcr: defaultIcr.present ? defaultIcr.value : this.defaultIcr,
    isf: isf.present ? isf.value : this.isf,
    targetGlucose: targetGlucose.present
        ? targetGlucose.value
        : this.targetGlucose,
    diaHours: diaHours.present ? diaHours.value : this.diaHours,
    doseStep: doseStep ?? this.doseStep,
    maxSingleDose: maxSingleDose ?? this.maxSingleDose,
    allowNegativeCorrection:
        allowNegativeCorrection ?? this.allowNegativeCorrection,
    subtractFiber: subtractFiber ?? this.subtractFiber,
    confirmedWithClinician:
        confirmedWithClinician ?? this.confirmedWithClinician,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalTherapySetting copyWithCompanion(LocalTherapySettingsCompanion data) {
    return LocalTherapySetting(
      id: data.id.present ? data.id.value : this.id,
      icrBlocksJson: data.icrBlocksJson.present
          ? data.icrBlocksJson.value
          : this.icrBlocksJson,
      defaultIcr: data.defaultIcr.present
          ? data.defaultIcr.value
          : this.defaultIcr,
      isf: data.isf.present ? data.isf.value : this.isf,
      targetGlucose: data.targetGlucose.present
          ? data.targetGlucose.value
          : this.targetGlucose,
      diaHours: data.diaHours.present ? data.diaHours.value : this.diaHours,
      doseStep: data.doseStep.present ? data.doseStep.value : this.doseStep,
      maxSingleDose: data.maxSingleDose.present
          ? data.maxSingleDose.value
          : this.maxSingleDose,
      allowNegativeCorrection: data.allowNegativeCorrection.present
          ? data.allowNegativeCorrection.value
          : this.allowNegativeCorrection,
      subtractFiber: data.subtractFiber.present
          ? data.subtractFiber.value
          : this.subtractFiber,
      confirmedWithClinician: data.confirmedWithClinician.present
          ? data.confirmedWithClinician.value
          : this.confirmedWithClinician,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalTherapySetting(')
          ..write('id: $id, ')
          ..write('icrBlocksJson: $icrBlocksJson, ')
          ..write('defaultIcr: $defaultIcr, ')
          ..write('isf: $isf, ')
          ..write('targetGlucose: $targetGlucose, ')
          ..write('diaHours: $diaHours, ')
          ..write('doseStep: $doseStep, ')
          ..write('maxSingleDose: $maxSingleDose, ')
          ..write('allowNegativeCorrection: $allowNegativeCorrection, ')
          ..write('subtractFiber: $subtractFiber, ')
          ..write('confirmedWithClinician: $confirmedWithClinician, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    icrBlocksJson,
    defaultIcr,
    isf,
    targetGlucose,
    diaHours,
    doseStep,
    maxSingleDose,
    allowNegativeCorrection,
    subtractFiber,
    confirmedWithClinician,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTherapySetting &&
          other.id == this.id &&
          other.icrBlocksJson == this.icrBlocksJson &&
          other.defaultIcr == this.defaultIcr &&
          other.isf == this.isf &&
          other.targetGlucose == this.targetGlucose &&
          other.diaHours == this.diaHours &&
          other.doseStep == this.doseStep &&
          other.maxSingleDose == this.maxSingleDose &&
          other.allowNegativeCorrection == this.allowNegativeCorrection &&
          other.subtractFiber == this.subtractFiber &&
          other.confirmedWithClinician == this.confirmedWithClinician &&
          other.createdAt == this.createdAt);
}

class LocalTherapySettingsCompanion
    extends UpdateCompanion<LocalTherapySetting> {
  final Value<String> id;
  final Value<String> icrBlocksJson;
  final Value<double?> defaultIcr;
  final Value<double?> isf;
  final Value<double?> targetGlucose;
  final Value<double?> diaHours;
  final Value<double> doseStep;
  final Value<double> maxSingleDose;
  final Value<bool> allowNegativeCorrection;
  final Value<bool> subtractFiber;
  final Value<bool> confirmedWithClinician;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalTherapySettingsCompanion({
    this.id = const Value.absent(),
    this.icrBlocksJson = const Value.absent(),
    this.defaultIcr = const Value.absent(),
    this.isf = const Value.absent(),
    this.targetGlucose = const Value.absent(),
    this.diaHours = const Value.absent(),
    this.doseStep = const Value.absent(),
    this.maxSingleDose = const Value.absent(),
    this.allowNegativeCorrection = const Value.absent(),
    this.subtractFiber = const Value.absent(),
    this.confirmedWithClinician = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalTherapySettingsCompanion.insert({
    required String id,
    this.icrBlocksJson = const Value.absent(),
    this.defaultIcr = const Value.absent(),
    this.isf = const Value.absent(),
    this.targetGlucose = const Value.absent(),
    this.diaHours = const Value.absent(),
    this.doseStep = const Value.absent(),
    this.maxSingleDose = const Value.absent(),
    this.allowNegativeCorrection = const Value.absent(),
    this.subtractFiber = const Value.absent(),
    this.confirmedWithClinician = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<LocalTherapySetting> custom({
    Expression<String>? id,
    Expression<String>? icrBlocksJson,
    Expression<double>? defaultIcr,
    Expression<double>? isf,
    Expression<double>? targetGlucose,
    Expression<double>? diaHours,
    Expression<double>? doseStep,
    Expression<double>? maxSingleDose,
    Expression<bool>? allowNegativeCorrection,
    Expression<bool>? subtractFiber,
    Expression<bool>? confirmedWithClinician,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (icrBlocksJson != null) 'icr_blocks_json': icrBlocksJson,
      if (defaultIcr != null) 'default_icr': defaultIcr,
      if (isf != null) 'isf': isf,
      if (targetGlucose != null) 'target_glucose': targetGlucose,
      if (diaHours != null) 'dia_hours': diaHours,
      if (doseStep != null) 'dose_step': doseStep,
      if (maxSingleDose != null) 'max_single_dose': maxSingleDose,
      if (allowNegativeCorrection != null)
        'allow_negative_correction': allowNegativeCorrection,
      if (subtractFiber != null) 'subtract_fiber': subtractFiber,
      if (confirmedWithClinician != null)
        'confirmed_with_clinician': confirmedWithClinician,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalTherapySettingsCompanion copyWith({
    Value<String>? id,
    Value<String>? icrBlocksJson,
    Value<double?>? defaultIcr,
    Value<double?>? isf,
    Value<double?>? targetGlucose,
    Value<double?>? diaHours,
    Value<double>? doseStep,
    Value<double>? maxSingleDose,
    Value<bool>? allowNegativeCorrection,
    Value<bool>? subtractFiber,
    Value<bool>? confirmedWithClinician,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LocalTherapySettingsCompanion(
      id: id ?? this.id,
      icrBlocksJson: icrBlocksJson ?? this.icrBlocksJson,
      defaultIcr: defaultIcr ?? this.defaultIcr,
      isf: isf ?? this.isf,
      targetGlucose: targetGlucose ?? this.targetGlucose,
      diaHours: diaHours ?? this.diaHours,
      doseStep: doseStep ?? this.doseStep,
      maxSingleDose: maxSingleDose ?? this.maxSingleDose,
      allowNegativeCorrection:
          allowNegativeCorrection ?? this.allowNegativeCorrection,
      subtractFiber: subtractFiber ?? this.subtractFiber,
      confirmedWithClinician:
          confirmedWithClinician ?? this.confirmedWithClinician,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (icrBlocksJson.present) {
      map['icr_blocks_json'] = Variable<String>(icrBlocksJson.value);
    }
    if (defaultIcr.present) {
      map['default_icr'] = Variable<double>(defaultIcr.value);
    }
    if (isf.present) {
      map['isf'] = Variable<double>(isf.value);
    }
    if (targetGlucose.present) {
      map['target_glucose'] = Variable<double>(targetGlucose.value);
    }
    if (diaHours.present) {
      map['dia_hours'] = Variable<double>(diaHours.value);
    }
    if (doseStep.present) {
      map['dose_step'] = Variable<double>(doseStep.value);
    }
    if (maxSingleDose.present) {
      map['max_single_dose'] = Variable<double>(maxSingleDose.value);
    }
    if (allowNegativeCorrection.present) {
      map['allow_negative_correction'] = Variable<bool>(
        allowNegativeCorrection.value,
      );
    }
    if (subtractFiber.present) {
      map['subtract_fiber'] = Variable<bool>(subtractFiber.value);
    }
    if (confirmedWithClinician.present) {
      map['confirmed_with_clinician'] = Variable<bool>(
        confirmedWithClinician.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalTherapySettingsCompanion(')
          ..write('id: $id, ')
          ..write('icrBlocksJson: $icrBlocksJson, ')
          ..write('defaultIcr: $defaultIcr, ')
          ..write('isf: $isf, ')
          ..write('targetGlucose: $targetGlucose, ')
          ..write('diaHours: $diaHours, ')
          ..write('doseStep: $doseStep, ')
          ..write('maxSingleDose: $maxSingleDose, ')
          ..write('allowNegativeCorrection: $allowNegativeCorrection, ')
          ..write('subtractFiber: $subtractFiber, ')
          ..write('confirmedWithClinician: $confirmedWithClinician, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalFoodsTable localFoods = $LocalFoodsTable(this);
  late final $LocalFoodPortionsTable localFoodPortions =
      $LocalFoodPortionsTable(this);
  late final $LocalGlucoseLogsTable localGlucoseLogs = $LocalGlucoseLogsTable(
    this,
  );
  late final $LocalDoseLogsTable localDoseLogs = $LocalDoseLogsTable(this);
  late final $LocalConsentLogsTable localConsentLogs = $LocalConsentLogsTable(
    this,
  );
  late final $LocalTherapySettingsTable localTherapySettings =
      $LocalTherapySettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localFoods,
    localFoodPortions,
    localGlucoseLogs,
    localDoseLogs,
    localConsentLogs,
    localTherapySettings,
  ];
}

typedef $$LocalFoodsTableCreateCompanionBuilder = LocalFoodsCompanion Function({
  required String id,
  required String nameTr,
  Value<String?> nameEn,
  required String normalizedName,
  Value<String?> category,
  Value<String?> brand,
  Value<String?> barcode,
  Value<String> preparation,
  required double carbsGPer100g,
  Value<double?> sugarsGPer100g,
  Value<double?> fiberGPer100g,
  Value<double> proteinGPer100g,
  Value<double> fatGPer100g,
  Value<double> kcalPer100g,
  Value<int?> gi,
  Value<String?> giSource,
  Value<String?> sourceRef,
  Value<String> verification,
  Value<bool> isSample,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalFoodsTableUpdateCompanionBuilder = LocalFoodsCompanion Function({
  Value<String> id,
  Value<String> nameTr,
  Value<String?> nameEn,
  Value<String> normalizedName,
  Value<String?> category,
  Value<String?> brand,
  Value<String?> barcode,
  Value<String> preparation,
  Value<double> carbsGPer100g,
  Value<double?> sugarsGPer100g,
  Value<double?> fiberGPer100g,
  Value<double> proteinGPer100g,
  Value<double> fatGPer100g,
  Value<double> kcalPer100g,
  Value<int?> gi,
  Value<String?> giSource,
  Value<String?> sourceRef,
  Value<String> verification,
  Value<bool> isSample,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$LocalFoodsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalFoodsTable> {
  $$LocalFoodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameTr => $composableBuilder(
    column: $table.nameTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preparation => $composableBuilder(
    column: $table.preparation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsGPer100g => $composableBuilder(
    column: $table.carbsGPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sugarsGPer100g => $composableBuilder(
    column: $table.sugarsGPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiberGPer100g => $composableBuilder(
    column: $table.fiberGPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinGPer100g => $composableBuilder(
    column: $table.proteinGPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatGPer100g => $composableBuilder(
    column: $table.fatGPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gi => $composableBuilder(
    column: $table.gi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get giSource => $composableBuilder(
    column: $table.giSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verification => $composableBuilder(
    column: $table.verification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSample => $composableBuilder(
    column: $table.isSample,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalFoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalFoodsTable> {
  $$LocalFoodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameTr => $composableBuilder(
    column: $table.nameTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preparation => $composableBuilder(
    column: $table.preparation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsGPer100g => $composableBuilder(
    column: $table.carbsGPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sugarsGPer100g => $composableBuilder(
    column: $table.sugarsGPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiberGPer100g => $composableBuilder(
    column: $table.fiberGPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinGPer100g => $composableBuilder(
    column: $table.proteinGPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatGPer100g => $composableBuilder(
    column: $table.fatGPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gi => $composableBuilder(
    column: $table.gi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get giSource => $composableBuilder(
    column: $table.giSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verification => $composableBuilder(
    column: $table.verification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSample => $composableBuilder(
    column: $table.isSample,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalFoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalFoodsTable> {
  $$LocalFoodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameTr =>
      $composableBuilder(column: $table.nameTr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get preparation => $composableBuilder(
    column: $table.preparation,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsGPer100g => $composableBuilder(
    column: $table.carbsGPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sugarsGPer100g => $composableBuilder(
    column: $table.sugarsGPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fiberGPer100g => $composableBuilder(
    column: $table.fiberGPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinGPer100g => $composableBuilder(
    column: $table.proteinGPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatGPer100g => $composableBuilder(
    column: $table.fatGPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<int> get gi =>
      $composableBuilder(column: $table.gi, builder: (column) => column);

  GeneratedColumn<String> get giSource =>
      $composableBuilder(column: $table.giSource, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<String> get verification => $composableBuilder(
    column: $table.verification,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSample =>
      $composableBuilder(column: $table.isSample, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalFoodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalFoodsTable,
          LocalFood,
          $$LocalFoodsTableFilterComposer,
          $$LocalFoodsTableOrderingComposer,
          $$LocalFoodsTableAnnotationComposer,
          $$LocalFoodsTableCreateCompanionBuilder,
          $$LocalFoodsTableUpdateCompanionBuilder,
          (
            LocalFood,
            BaseReferences<_$AppDatabase, $LocalFoodsTable, LocalFood>,
          ),
          LocalFood,
          PrefetchHooks Function()
        > {
  $$LocalFoodsTableTableManager(_$AppDatabase db, $LocalFoodsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalFoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalFoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalFoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameTr = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String> preparation = const Value.absent(),
                Value<double> carbsGPer100g = const Value.absent(),
                Value<double?> sugarsGPer100g = const Value.absent(),
                Value<double?> fiberGPer100g = const Value.absent(),
                Value<double> proteinGPer100g = const Value.absent(),
                Value<double> fatGPer100g = const Value.absent(),
                Value<double> kcalPer100g = const Value.absent(),
                Value<int?> gi = const Value.absent(),
                Value<String?> giSource = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<String> verification = const Value.absent(),
                Value<bool> isSample = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalFoodsCompanion(
                id: id,
                nameTr: nameTr,
                nameEn: nameEn,
                normalizedName: normalizedName,
                category: category,
                brand: brand,
                barcode: barcode,
                preparation: preparation,
                carbsGPer100g: carbsGPer100g,
                sugarsGPer100g: sugarsGPer100g,
                fiberGPer100g: fiberGPer100g,
                proteinGPer100g: proteinGPer100g,
                fatGPer100g: fatGPer100g,
                kcalPer100g: kcalPer100g,
                gi: gi,
                giSource: giSource,
                sourceRef: sourceRef,
                verification: verification,
                isSample: isSample,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameTr,
                Value<String?> nameEn = const Value.absent(),
                required String normalizedName,
                Value<String?> category = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String> preparation = const Value.absent(),
                required double carbsGPer100g,
                Value<double?> sugarsGPer100g = const Value.absent(),
                Value<double?> fiberGPer100g = const Value.absent(),
                Value<double> proteinGPer100g = const Value.absent(),
                Value<double> fatGPer100g = const Value.absent(),
                Value<double> kcalPer100g = const Value.absent(),
                Value<int?> gi = const Value.absent(),
                Value<String?> giSource = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<String> verification = const Value.absent(),
                Value<bool> isSample = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalFoodsCompanion.insert(
                id: id,
                nameTr: nameTr,
                nameEn: nameEn,
                normalizedName: normalizedName,
                category: category,
                brand: brand,
                barcode: barcode,
                preparation: preparation,
                carbsGPer100g: carbsGPer100g,
                sugarsGPer100g: sugarsGPer100g,
                fiberGPer100g: fiberGPer100g,
                proteinGPer100g: proteinGPer100g,
                fatGPer100g: fatGPer100g,
                kcalPer100g: kcalPer100g,
                gi: gi,
                giSource: giSource,
                sourceRef: sourceRef,
                verification: verification,
                isSample: isSample,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalFoodsTable, LocalFood>(table),
                  BaseReferences<_$AppDatabase, $LocalFoodsTable, LocalFood>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalFoodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalFoodsTable,
      LocalFood,
      $$LocalFoodsTableFilterComposer,
      $$LocalFoodsTableOrderingComposer,
      $$LocalFoodsTableAnnotationComposer,
      $$LocalFoodsTableCreateCompanionBuilder,
      $$LocalFoodsTableUpdateCompanionBuilder,
      (LocalFood, BaseReferences<_$AppDatabase, $LocalFoodsTable, LocalFood>),
      LocalFood,
      PrefetchHooks Function()
    >;
typedef $$LocalFoodPortionsTableCreateCompanionBuilder =
    LocalFoodPortionsCompanion Function({
      required String id,
      required String foodId,
      required String labelTr,
      required double grams,
      required String sourceRef,
      Value<int> rowid,
    });
typedef $$LocalFoodPortionsTableUpdateCompanionBuilder =
    LocalFoodPortionsCompanion Function({
      Value<String> id,
      Value<String> foodId,
      Value<String> labelTr,
      Value<double> grams,
      Value<String> sourceRef,
      Value<int> rowid,
    });

class $$LocalFoodPortionsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalFoodPortionsTable> {
  $$LocalFoodPortionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foodId => $composableBuilder(
    column: $table.foodId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelTr => $composableBuilder(
    column: $table.labelTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalFoodPortionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalFoodPortionsTable> {
  $$LocalFoodPortionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foodId => $composableBuilder(
    column: $table.foodId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelTr => $composableBuilder(
    column: $table.labelTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalFoodPortionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalFoodPortionsTable> {
  $$LocalFoodPortionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get foodId =>
      $composableBuilder(column: $table.foodId, builder: (column) => column);

  GeneratedColumn<String> get labelTr =>
      $composableBuilder(column: $table.labelTr, builder: (column) => column);

  GeneratedColumn<double> get grams =>
      $composableBuilder(column: $table.grams, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);
}

class $$LocalFoodPortionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalFoodPortionsTable,
          LocalFoodPortion,
          $$LocalFoodPortionsTableFilterComposer,
          $$LocalFoodPortionsTableOrderingComposer,
          $$LocalFoodPortionsTableAnnotationComposer,
          $$LocalFoodPortionsTableCreateCompanionBuilder,
          $$LocalFoodPortionsTableUpdateCompanionBuilder,
          (
            LocalFoodPortion,
            BaseReferences<
              _$AppDatabase,
              $LocalFoodPortionsTable,
              LocalFoodPortion
            >,
          ),
          LocalFoodPortion,
          PrefetchHooks Function()
        > {
  $$LocalFoodPortionsTableTableManager(
    _$AppDatabase db,
    $LocalFoodPortionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalFoodPortionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalFoodPortionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalFoodPortionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> foodId = const Value.absent(),
                Value<String> labelTr = const Value.absent(),
                Value<double> grams = const Value.absent(),
                Value<String> sourceRef = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalFoodPortionsCompanion(
                id: id,
                foodId: foodId,
                labelTr: labelTr,
                grams: grams,
                sourceRef: sourceRef,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String foodId,
                required String labelTr,
                required double grams,
                required String sourceRef,
                Value<int> rowid = const Value.absent(),
              }) => LocalFoodPortionsCompanion.insert(
                id: id,
                foodId: foodId,
                labelTr: labelTr,
                grams: grams,
                sourceRef: sourceRef,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalFoodPortionsTable, LocalFoodPortion>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LocalFoodPortionsTable,
                    LocalFoodPortion
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalFoodPortionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalFoodPortionsTable,
      LocalFoodPortion,
      $$LocalFoodPortionsTableFilterComposer,
      $$LocalFoodPortionsTableOrderingComposer,
      $$LocalFoodPortionsTableAnnotationComposer,
      $$LocalFoodPortionsTableCreateCompanionBuilder,
      $$LocalFoodPortionsTableUpdateCompanionBuilder,
      (
        LocalFoodPortion,
        BaseReferences<
          _$AppDatabase,
          $LocalFoodPortionsTable,
          LocalFoodPortion
        >,
      ),
      LocalFoodPortion,
      PrefetchHooks Function()
    >;
typedef $$LocalGlucoseLogsTableCreateCompanionBuilder =
    LocalGlucoseLogsCompanion Function({
      required String id,
      required double valueMgDl,
      required String context,
      required DateTime measuredAt,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$LocalGlucoseLogsTableUpdateCompanionBuilder =
    LocalGlucoseLogsCompanion Function({
      Value<String> id,
      Value<double> valueMgDl,
      Value<String> context,
      Value<DateTime> measuredAt,
      Value<String?> note,
      Value<int> rowid,
    });

class $$LocalGlucoseLogsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalGlucoseLogsTable> {
  $$LocalGlucoseLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get valueMgDl => $composableBuilder(
    column: $table.valueMgDl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get context => $composableBuilder(
    column: $table.context,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalGlucoseLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalGlucoseLogsTable> {
  $$LocalGlucoseLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get valueMgDl => $composableBuilder(
    column: $table.valueMgDl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get context => $composableBuilder(
    column: $table.context,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalGlucoseLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalGlucoseLogsTable> {
  $$LocalGlucoseLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get valueMgDl =>
      $composableBuilder(column: $table.valueMgDl, builder: (column) => column);

  GeneratedColumn<String> get context =>
      $composableBuilder(column: $table.context, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$LocalGlucoseLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalGlucoseLogsTable,
          LocalGlucoseLog,
          $$LocalGlucoseLogsTableFilterComposer,
          $$LocalGlucoseLogsTableOrderingComposer,
          $$LocalGlucoseLogsTableAnnotationComposer,
          $$LocalGlucoseLogsTableCreateCompanionBuilder,
          $$LocalGlucoseLogsTableUpdateCompanionBuilder,
          (
            LocalGlucoseLog,
            BaseReferences<
              _$AppDatabase,
              $LocalGlucoseLogsTable,
              LocalGlucoseLog
            >,
          ),
          LocalGlucoseLog,
          PrefetchHooks Function()
        > {
  $$LocalGlucoseLogsTableTableManager(
    _$AppDatabase db,
    $LocalGlucoseLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalGlucoseLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalGlucoseLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalGlucoseLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double> valueMgDl = const Value.absent(),
                Value<String> context = const Value.absent(),
                Value<DateTime> measuredAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalGlucoseLogsCompanion(
                id: id,
                valueMgDl: valueMgDl,
                context: context,
                measuredAt: measuredAt,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required double valueMgDl,
                required String context,
                required DateTime measuredAt,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalGlucoseLogsCompanion.insert(
                id: id,
                valueMgDl: valueMgDl,
                context: context,
                measuredAt: measuredAt,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalGlucoseLogsTable, LocalGlucoseLog>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LocalGlucoseLogsTable,
                    LocalGlucoseLog
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalGlucoseLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalGlucoseLogsTable,
      LocalGlucoseLog,
      $$LocalGlucoseLogsTableFilterComposer,
      $$LocalGlucoseLogsTableOrderingComposer,
      $$LocalGlucoseLogsTableAnnotationComposer,
      $$LocalGlucoseLogsTableCreateCompanionBuilder,
      $$LocalGlucoseLogsTableUpdateCompanionBuilder,
      (
        LocalGlucoseLog,
        BaseReferences<_$AppDatabase, $LocalGlucoseLogsTable, LocalGlucoseLog>,
      ),
      LocalGlucoseLog,
      PrefetchHooks Function()
    >;
typedef $$LocalDoseLogsTableCreateCompanionBuilder =
    LocalDoseLogsCompanion Function({
      required String id,
      required double appliedUnits,
      required DateTime appliedAt,
      required String inputSnapshot,
      required String resultSnapshot,
      Value<String> engineVersion,
      Value<int> rowid,
    });
typedef $$LocalDoseLogsTableUpdateCompanionBuilder =
    LocalDoseLogsCompanion Function({
      Value<String> id,
      Value<double> appliedUnits,
      Value<DateTime> appliedAt,
      Value<String> inputSnapshot,
      Value<String> resultSnapshot,
      Value<String> engineVersion,
      Value<int> rowid,
    });

class $$LocalDoseLogsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalDoseLogsTable> {
  $$LocalDoseLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get appliedUnits => $composableBuilder(
    column: $table.appliedUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get appliedAt => $composableBuilder(
    column: $table.appliedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inputSnapshot => $composableBuilder(
    column: $table.inputSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resultSnapshot => $composableBuilder(
    column: $table.resultSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get engineVersion => $composableBuilder(
    column: $table.engineVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalDoseLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalDoseLogsTable> {
  $$LocalDoseLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get appliedUnits => $composableBuilder(
    column: $table.appliedUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get appliedAt => $composableBuilder(
    column: $table.appliedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inputSnapshot => $composableBuilder(
    column: $table.inputSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultSnapshot => $composableBuilder(
    column: $table.resultSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get engineVersion => $composableBuilder(
    column: $table.engineVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalDoseLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalDoseLogsTable> {
  $$LocalDoseLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get appliedUnits => $composableBuilder(
    column: $table.appliedUnits,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get appliedAt =>
      $composableBuilder(column: $table.appliedAt, builder: (column) => column);

  GeneratedColumn<String> get inputSnapshot => $composableBuilder(
    column: $table.inputSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resultSnapshot => $composableBuilder(
    column: $table.resultSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get engineVersion => $composableBuilder(
    column: $table.engineVersion,
    builder: (column) => column,
  );
}

class $$LocalDoseLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalDoseLogsTable,
          LocalDoseLog,
          $$LocalDoseLogsTableFilterComposer,
          $$LocalDoseLogsTableOrderingComposer,
          $$LocalDoseLogsTableAnnotationComposer,
          $$LocalDoseLogsTableCreateCompanionBuilder,
          $$LocalDoseLogsTableUpdateCompanionBuilder,
          (
            LocalDoseLog,
            BaseReferences<_$AppDatabase, $LocalDoseLogsTable, LocalDoseLog>,
          ),
          LocalDoseLog,
          PrefetchHooks Function()
        > {
  $$LocalDoseLogsTableTableManager(_$AppDatabase db, $LocalDoseLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalDoseLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalDoseLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalDoseLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double> appliedUnits = const Value.absent(),
                Value<DateTime> appliedAt = const Value.absent(),
                Value<String> inputSnapshot = const Value.absent(),
                Value<String> resultSnapshot = const Value.absent(),
                Value<String> engineVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalDoseLogsCompanion(
                id: id,
                appliedUnits: appliedUnits,
                appliedAt: appliedAt,
                inputSnapshot: inputSnapshot,
                resultSnapshot: resultSnapshot,
                engineVersion: engineVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required double appliedUnits,
                required DateTime appliedAt,
                required String inputSnapshot,
                required String resultSnapshot,
                Value<String> engineVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalDoseLogsCompanion.insert(
                id: id,
                appliedUnits: appliedUnits,
                appliedAt: appliedAt,
                inputSnapshot: inputSnapshot,
                resultSnapshot: resultSnapshot,
                engineVersion: engineVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalDoseLogsTable, LocalDoseLog>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LocalDoseLogsTable,
                    LocalDoseLog
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalDoseLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalDoseLogsTable,
      LocalDoseLog,
      $$LocalDoseLogsTableFilterComposer,
      $$LocalDoseLogsTableOrderingComposer,
      $$LocalDoseLogsTableAnnotationComposer,
      $$LocalDoseLogsTableCreateCompanionBuilder,
      $$LocalDoseLogsTableUpdateCompanionBuilder,
      (
        LocalDoseLog,
        BaseReferences<_$AppDatabase, $LocalDoseLogsTable, LocalDoseLog>,
      ),
      LocalDoseLog,
      PrefetchHooks Function()
    >;
typedef $$LocalConsentLogsTableCreateCompanionBuilder =
    LocalConsentLogsCompanion Function({
      required String id,
      required String type,
      required String textVersion,
      required DateTime acceptedAt,
      Value<int> rowid,
    });
typedef $$LocalConsentLogsTableUpdateCompanionBuilder =
    LocalConsentLogsCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String> textVersion,
      Value<DateTime> acceptedAt,
      Value<int> rowid,
    });

class $$LocalConsentLogsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalConsentLogsTable> {
  $$LocalConsentLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textVersion => $composableBuilder(
    column: $table.textVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acceptedAt => $composableBuilder(
    column: $table.acceptedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalConsentLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalConsentLogsTable> {
  $$LocalConsentLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textVersion => $composableBuilder(
    column: $table.textVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acceptedAt => $composableBuilder(
    column: $table.acceptedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalConsentLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalConsentLogsTable> {
  $$LocalConsentLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get textVersion => $composableBuilder(
    column: $table.textVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get acceptedAt => $composableBuilder(
    column: $table.acceptedAt,
    builder: (column) => column,
  );
}

class $$LocalConsentLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalConsentLogsTable,
          LocalConsentLog,
          $$LocalConsentLogsTableFilterComposer,
          $$LocalConsentLogsTableOrderingComposer,
          $$LocalConsentLogsTableAnnotationComposer,
          $$LocalConsentLogsTableCreateCompanionBuilder,
          $$LocalConsentLogsTableUpdateCompanionBuilder,
          (
            LocalConsentLog,
            BaseReferences<
              _$AppDatabase,
              $LocalConsentLogsTable,
              LocalConsentLog
            >,
          ),
          LocalConsentLog,
          PrefetchHooks Function()
        > {
  $$LocalConsentLogsTableTableManager(
    _$AppDatabase db,
    $LocalConsentLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalConsentLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalConsentLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalConsentLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> textVersion = const Value.absent(),
                Value<DateTime> acceptedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalConsentLogsCompanion(
                id: id,
                type: type,
                textVersion: textVersion,
                acceptedAt: acceptedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String textVersion,
                required DateTime acceptedAt,
                Value<int> rowid = const Value.absent(),
              }) => LocalConsentLogsCompanion.insert(
                id: id,
                type: type,
                textVersion: textVersion,
                acceptedAt: acceptedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalConsentLogsTable, LocalConsentLog>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LocalConsentLogsTable,
                    LocalConsentLog
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalConsentLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalConsentLogsTable,
      LocalConsentLog,
      $$LocalConsentLogsTableFilterComposer,
      $$LocalConsentLogsTableOrderingComposer,
      $$LocalConsentLogsTableAnnotationComposer,
      $$LocalConsentLogsTableCreateCompanionBuilder,
      $$LocalConsentLogsTableUpdateCompanionBuilder,
      (
        LocalConsentLog,
        BaseReferences<_$AppDatabase, $LocalConsentLogsTable, LocalConsentLog>,
      ),
      LocalConsentLog,
      PrefetchHooks Function()
    >;
typedef $$LocalTherapySettingsTableCreateCompanionBuilder =
    LocalTherapySettingsCompanion Function({
      required String id,
      Value<String> icrBlocksJson,
      Value<double?> defaultIcr,
      Value<double?> isf,
      Value<double?> targetGlucose,
      Value<double?> diaHours,
      Value<double> doseStep,
      Value<double> maxSingleDose,
      Value<bool> allowNegativeCorrection,
      Value<bool> subtractFiber,
      Value<bool> confirmedWithClinician,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$LocalTherapySettingsTableUpdateCompanionBuilder =
    LocalTherapySettingsCompanion Function({
      Value<String> id,
      Value<String> icrBlocksJson,
      Value<double?> defaultIcr,
      Value<double?> isf,
      Value<double?> targetGlucose,
      Value<double?> diaHours,
      Value<double> doseStep,
      Value<double> maxSingleDose,
      Value<bool> allowNegativeCorrection,
      Value<bool> subtractFiber,
      Value<bool> confirmedWithClinician,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$LocalTherapySettingsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalTherapySettingsTable> {
  $$LocalTherapySettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icrBlocksJson => $composableBuilder(
    column: $table.icrBlocksJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultIcr => $composableBuilder(
    column: $table.defaultIcr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get isf => $composableBuilder(
    column: $table.isf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetGlucose => $composableBuilder(
    column: $table.targetGlucose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get diaHours => $composableBuilder(
    column: $table.diaHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get doseStep => $composableBuilder(
    column: $table.doseStep,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxSingleDose => $composableBuilder(
    column: $table.maxSingleDose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allowNegativeCorrection => $composableBuilder(
    column: $table.allowNegativeCorrection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get subtractFiber => $composableBuilder(
    column: $table.subtractFiber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get confirmedWithClinician => $composableBuilder(
    column: $table.confirmedWithClinician,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalTherapySettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalTherapySettingsTable> {
  $$LocalTherapySettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icrBlocksJson => $composableBuilder(
    column: $table.icrBlocksJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultIcr => $composableBuilder(
    column: $table.defaultIcr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get isf => $composableBuilder(
    column: $table.isf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetGlucose => $composableBuilder(
    column: $table.targetGlucose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get diaHours => $composableBuilder(
    column: $table.diaHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get doseStep => $composableBuilder(
    column: $table.doseStep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxSingleDose => $composableBuilder(
    column: $table.maxSingleDose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allowNegativeCorrection => $composableBuilder(
    column: $table.allowNegativeCorrection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get subtractFiber => $composableBuilder(
    column: $table.subtractFiber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get confirmedWithClinician => $composableBuilder(
    column: $table.confirmedWithClinician,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalTherapySettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalTherapySettingsTable> {
  $$LocalTherapySettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get icrBlocksJson => $composableBuilder(
    column: $table.icrBlocksJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultIcr => $composableBuilder(
    column: $table.defaultIcr,
    builder: (column) => column,
  );

  GeneratedColumn<double> get isf =>
      $composableBuilder(column: $table.isf, builder: (column) => column);

  GeneratedColumn<double> get targetGlucose => $composableBuilder(
    column: $table.targetGlucose,
    builder: (column) => column,
  );

  GeneratedColumn<double> get diaHours =>
      $composableBuilder(column: $table.diaHours, builder: (column) => column);

  GeneratedColumn<double> get doseStep =>
      $composableBuilder(column: $table.doseStep, builder: (column) => column);

  GeneratedColumn<double> get maxSingleDose => $composableBuilder(
    column: $table.maxSingleDose,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get allowNegativeCorrection => $composableBuilder(
    column: $table.allowNegativeCorrection,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get subtractFiber => $composableBuilder(
    column: $table.subtractFiber,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get confirmedWithClinician => $composableBuilder(
    column: $table.confirmedWithClinician,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LocalTherapySettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalTherapySettingsTable,
          LocalTherapySetting,
          $$LocalTherapySettingsTableFilterComposer,
          $$LocalTherapySettingsTableOrderingComposer,
          $$LocalTherapySettingsTableAnnotationComposer,
          $$LocalTherapySettingsTableCreateCompanionBuilder,
          $$LocalTherapySettingsTableUpdateCompanionBuilder,
          (
            LocalTherapySetting,
            BaseReferences<
              _$AppDatabase,
              $LocalTherapySettingsTable,
              LocalTherapySetting
            >,
          ),
          LocalTherapySetting,
          PrefetchHooks Function()
        > {
  $$LocalTherapySettingsTableTableManager(
    _$AppDatabase db,
    $LocalTherapySettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalTherapySettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalTherapySettingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalTherapySettingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> icrBlocksJson = const Value.absent(),
                Value<double?> defaultIcr = const Value.absent(),
                Value<double?> isf = const Value.absent(),
                Value<double?> targetGlucose = const Value.absent(),
                Value<double?> diaHours = const Value.absent(),
                Value<double> doseStep = const Value.absent(),
                Value<double> maxSingleDose = const Value.absent(),
                Value<bool> allowNegativeCorrection = const Value.absent(),
                Value<bool> subtractFiber = const Value.absent(),
                Value<bool> confirmedWithClinician = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalTherapySettingsCompanion(
                id: id,
                icrBlocksJson: icrBlocksJson,
                defaultIcr: defaultIcr,
                isf: isf,
                targetGlucose: targetGlucose,
                diaHours: diaHours,
                doseStep: doseStep,
                maxSingleDose: maxSingleDose,
                allowNegativeCorrection: allowNegativeCorrection,
                subtractFiber: subtractFiber,
                confirmedWithClinician: confirmedWithClinician,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> icrBlocksJson = const Value.absent(),
                Value<double?> defaultIcr = const Value.absent(),
                Value<double?> isf = const Value.absent(),
                Value<double?> targetGlucose = const Value.absent(),
                Value<double?> diaHours = const Value.absent(),
                Value<double> doseStep = const Value.absent(),
                Value<double> maxSingleDose = const Value.absent(),
                Value<bool> allowNegativeCorrection = const Value.absent(),
                Value<bool> subtractFiber = const Value.absent(),
                Value<bool> confirmedWithClinician = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalTherapySettingsCompanion.insert(
                id: id,
                icrBlocksJson: icrBlocksJson,
                defaultIcr: defaultIcr,
                isf: isf,
                targetGlucose: targetGlucose,
                diaHours: diaHours,
                doseStep: doseStep,
                maxSingleDose: maxSingleDose,
                allowNegativeCorrection: allowNegativeCorrection,
                subtractFiber: subtractFiber,
                confirmedWithClinician: confirmedWithClinician,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalTherapySettingsTable, LocalTherapySetting>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $LocalTherapySettingsTable,
                    LocalTherapySetting
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalTherapySettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalTherapySettingsTable,
      LocalTherapySetting,
      $$LocalTherapySettingsTableFilterComposer,
      $$LocalTherapySettingsTableOrderingComposer,
      $$LocalTherapySettingsTableAnnotationComposer,
      $$LocalTherapySettingsTableCreateCompanionBuilder,
      $$LocalTherapySettingsTableUpdateCompanionBuilder,
      (
        LocalTherapySetting,
        BaseReferences<
          _$AppDatabase,
          $LocalTherapySettingsTable,
          LocalTherapySetting
        >,
      ),
      LocalTherapySetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalFoodsTableTableManager get localFoods =>
      $$LocalFoodsTableTableManager(_db, _db.localFoods);
  $$LocalFoodPortionsTableTableManager get localFoodPortions =>
      $$LocalFoodPortionsTableTableManager(_db, _db.localFoodPortions);
  $$LocalGlucoseLogsTableTableManager get localGlucoseLogs =>
      $$LocalGlucoseLogsTableTableManager(_db, _db.localGlucoseLogs);
  $$LocalDoseLogsTableTableManager get localDoseLogs =>
      $$LocalDoseLogsTableTableManager(_db, _db.localDoseLogs);
  $$LocalConsentLogsTableTableManager get localConsentLogs =>
      $$LocalConsentLogsTableTableManager(_db, _db.localConsentLogs);
  $$LocalTherapySettingsTableTableManager get localTherapySettings =>
      $$LocalTherapySettingsTableTableManager(_db, _db.localTherapySettings);
}
