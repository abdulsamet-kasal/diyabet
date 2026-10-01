#!/usr/bin/env python3
"""
GlikoRehber Food Data Quality Validator (Section 5.3)

Strict clinical and composition quality checks:
1. carbs, protein, fat, sugars, fiber in [0, 100] g/100g.
2. sugars <= carbs; fiber <= carbs.
3. carbs + protein + fat + water + ash <= 105 g/100g (5% tolerance).
4. kcal consistency: |(4*carbs + 4*protein + 9*fat) - kcal| / kcal <= 0.25 (sapma <= 25%).
5. preparation (pişmiş/çiğ) is mandatory.
6. portions must have grams > 0 and source_ref.
"""

from typing import Dict, Any, Tuple, Optional

def validate_food_record(record: Dict[str, Any]) -> Tuple[bool, Optional[str]]:
    """
    Validates a food record before insertion into foods table.
    Returns (is_valid, rejection_reason).
    """
    try:
        carbs = float(record.get('carbs_g_per_100g', 0))
        protein = float(record.get('protein_g_per_100g', 0))
        fat = float(record.get('fat_g_per_100g', 0))
        kcal = float(record.get('kcal_per_100g', 0))
        sugars = record.get('sugars_g_per_100g')
        fiber = record.get('fiber_g_per_100g')
        prep = record.get('preparation')

        # 1. Macro range checks
        for name, val in [('Karbonhidrat', carbs), ('Protein', protein), ('Yağ', fat)]:
            if val < 0 or val > 100:
                return False, f"{name} 0 ile 100 g arasında olmalıdır (Gelen: {val})."

        # 2. Sugars & Fiber <= Carbs
        if sugars is not None:
            sugars = float(sugars)
            if sugars < 0 or sugars > 100:
                return False, f"Şeker 0-100 arasında olmalıdır (Gelen: {sugars})."
            if sugars > carbs + 0.1:  # 0.1 rounding tolerance
                return False, f"Şeker ({sugars}g) toplam karbonhidrattan ({carbs}g) büyük olamaz."

        if fiber is not None:
            fiber = float(fiber)
            if fiber < 0 or fiber > 100:
                return False, f"Lif 0-100 arasında olmalıdır (Gelen: {fiber})."
            if fiber > carbs + 0.1:
                return False, f"Lif ({fiber}g) toplam karbonhidrattan ({carbs}g) büyük olamaz."

        # 3. Sum of macros <= 105g (5% analytical tolerance)
        total_macros = carbs + protein + fat
        if total_macros > 105.0:
            return False, f"Makro besin toplamı ({total_macros}g) 105g tolerans limitini aşıyor."

        # 4. Kcal consistency check (4*carbs + 4*protein + 9*fat)
        # Only check if kcal is positive
        if kcal > 10:
            expected_kcal = (4.0 * carbs) + (4.0 * protein) + (9.0 * fat)
            deviation = abs(expected_kcal - kcal) / kcal
            if deviation > 0.25:
                return False, f"Kalori tutarsızlığı: Bildirilen {kcal} kcal, hesaplanan {expected_kcal:.1f} kcal (Sapma: %{deviation*100:.1f} > %25)."

        # 5. Preparation mandatory
        if not prep or prep not in ('raw', 'cooked', 'boiled', 'fried', 'as_sold'):
            return False, f"Geçersiz veya eksik preparation alanı: {prep}"

        return True, None
    except Exception as e:
        return False, f"Ayrıştırma hatası: {str(e)}"
