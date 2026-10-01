#!/usr/bin/env python3
import unittest
from food_validator import validate_food_record

class TestFoodValidator(unittest.TestCase):
    def test_valid_bread(self):
        bread = {
            'carbs_g_per_100g': 49.5,
            'protein_g_per_100g': 8.5,
            'fat_g_per_100g': 1.2,
            'sugars_g_per_100g': 2.5,
            'fiber_g_per_100g': 2.7,
            'kcal_per_100g': 250.0,
            'preparation': 'as_sold',
        }
        is_valid, reason = validate_food_record(bread)
        self.assertTrue(is_valid, reason)

    def test_sugars_exceed_carbs(self):
        invalid = {
            'carbs_g_per_100g': 10.0,
            'sugars_g_per_100g': 15.0,
            'protein_g_per_100g': 2.0,
            'fat_g_per_100g': 1.0,
            'kcal_per_100g': 57.0,
            'preparation': 'raw',
        }
        is_valid, reason = validate_food_record(invalid)
        self.assertFalse(is_valid)
        self.assertIn("Şeker", reason)

    def test_kcal_inconsistency_quarantine(self):
        # 10g carbs, 0g protein, 0g fat should be ~40 kcal, but reported as 200 kcal (> 25% deviation)
        invalid = {
            'carbs_g_per_100g': 10.0,
            'protein_g_per_100g': 0.0,
            'fat_g_per_100g': 0.0,
            'kcal_per_100g': 200.0,
            'preparation': 'as_sold',
        }
        is_valid, reason = validate_food_record(invalid)
        self.assertFalse(is_valid)
        self.assertIn("Kalori tutarsızlığı", reason)

    def test_missing_preparation(self):
        invalid = {
            'carbs_g_per_100g': 10.0,
            'protein_g_per_100g': 2.0,
            'fat_g_per_100g': 1.0,
            'kcal_per_100g': 57.0,
            'preparation': None,
        }
        is_valid, reason = validate_food_record(invalid)
        self.assertFalse(is_valid)
        self.assertIn("preparation", reason)

if __name__ == '__main__':
    unittest.main()
