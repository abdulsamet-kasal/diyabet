/// Pure Dart insulin dose calculation engine for GlikoRehber.
///
/// Implements clinical safety invariants:
/// - Hypoglycemia blocking (< 70 mg/dL)
/// - Maximum single dose safeguards
/// - Transparent formula breakdown
/// - Conservative half-down dose step rounding
/// - IOB calculation and deduction strictly from correction
library dose_engine;

export 'src/models/enums.dart';
export 'src/models/therapy_settings.dart';
export 'src/models/dose_log_entry.dart';
export 'src/models/dose_input.dart';
export 'src/models/dose_result.dart';
export 'src/calculator/rounding.dart';
export 'src/calculator/iob_calculator.dart';
export 'src/calculator/dose_calculator.dart';
