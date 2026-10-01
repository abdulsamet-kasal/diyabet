import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dose_engine/dose_engine.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/numeric_field.dart';
import '../../../core/widgets/dose_result_card.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/providers/plate_provider.dart';

class DoseCalculatorScreen extends ConsumerStatefulWidget {
  const DoseCalculatorScreen({super.key});

  @override
  ConsumerState<DoseCalculatorScreen> createState() => _DoseCalculatorScreenState();
}

class _DoseCalculatorScreenState extends ConsumerState<DoseCalculatorScreen> {
  final _carbsController = TextEditingController();
  final _glucoseController = TextEditingController();

  DoseResult? _calculationResult;
  bool _hasConfirmedUnverifiedFood = false;
  bool _isCalculating = false;

  @override
  void initState() {
    super.initState();
    // Pre-populate carbs from plate if plate has items
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final plate = ref.read(plateProvider);
      if (plate.totalCarbsG > 0) {
        _carbsController.text = plate.totalCarbsG.toStringAsFixed(1);
      }
    });
  }

  @override
  void dispose() {
    _carbsController.dispose();
    _glucoseController.dispose();
    super.dispose();
  }

  void _calculateDose() async {
    final profile = ref.read(userProfileProvider);
    final settings = profile.therapySettings;

    if (settings == null) {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Eksik Terapi Ayarları'),
          content: const Text(
            'Doz hesaplayabilmek için hekiminizin reçete ettiği oranları (ICR, ISF vb.) Ayarlar sayfasından girmeniz gerekmektedir.',
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Kapat')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.push('/settings');
              },
              child: const Text('Ayarlara Git'),
            ),
          ],
        ),
      );
      return;
    }

    final carbs = NumericField.parseTurkishDouble(_carbsController.text) ?? 0.0;
    final glucose = NumericField.parseTurkishDouble(_glucoseController.text);

    setState(() => _isCalculating = true);

    // Query recent doses for IOB
    final now = DateTime.now();
    final doseRepo = ref.read(doseRepositoryProvider);
    final recentDoses = await doseRepo.getRecentDosesForIob(
      now: now,
      maxDiaHours: settings.diaHours ?? 4.0,
    );

    final plate = ref.read(plateProvider);
    final minConfidence = plate.lowestVerificationStatus == 'community_unverified' ||
            plate.lowestVerificationStatus == 'user_entered'
        ? DataConfidence.communityUnverified
        : DataConfidence.officialVerified;

    final input = DoseInput(
      totalCarbsG: carbs,
      currentGlucose: glucose,
      glucoseUnit: profile.glucoseUnit,
      settings: settings,
      recentDoses: recentDoses,
      now: now,
      minFoodConfidence: minConfidence,
    );

    final result = DoseCalculator.calculate(input);

    setState(() {
      _calculationResult = result;
      _isCalculating = false;
    });
  }

  void _applyDose() async {
    if (_calculationResult == null || _calculationResult!.roundedUnits == null) return;

    final doseRepo = ref.read(doseRepositoryProvider);
    final now = DateTime.now();

    await doseRepo.logAppliedDose(
      appliedUnits: _calculationResult!.roundedUnits!,
      appliedAt: now,
      inputSnapshot: {
        'totalCarbsG': NumericField.parseTurkishDouble(_carbsController.text) ?? 0.0,
        'currentGlucose': NumericField.parseTurkishDouble(_glucoseController.text),
      },
      resultSnapshot: {
        'roundedUnits': _calculationResult!.roundedUnits,
        'mealUnits': _calculationResult!.mealUnits,
        'correctionUnits': _calculationResult!.correctionUnits,
        'iobDeducted': _calculationResult!.iobDeducted,
      },
    );

    // Clear plate upon application
    ref.read(plateProvider.notifier).clearPlate();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${_calculationResult!.roundedUnits} Ünite doz başarıyla uygulandı ve kütüğe kaydedildi.',
          ),
          backgroundColor: AppTheme.glucoseTarget,
        ),
      );
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(userProfileProvider);

    // Safety guard: Dose calculator disallowed for non-insulin profiles or minors
    if (!profile.isDoseCalculatorAllowed) {
      return Scaffold(
        appBar: AppBar(title: const Text('Doz Hesaplayıcı')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_clock, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  'Doz Hesaplayıcı Kilitli',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  !profile.isOver18
                      ? '18 yaş altı kullanıcılar için v1 sürümünde doz hesaplama özelliği devre dışıdır.'
                      : 'Seçili diyabet profiliniz hızlı etkili öğün insülini içermediğinden bu mod kapalıdır. Besin cetvelini ve karbonhidrat takibini kullanabilirsiniz.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Ana Sayfaya Dön'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Doz Hesaplayıcı')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Safe reminder banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppTheme.primaryTeal),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Bu ekran yalnızca hekiminizin reçete ettiği oranlarla öneri dozu hesaplar.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Carbs Input
            NumericField(
              controller: _carbsController,
              labelText: 'Öğün Karbonhidratı *',
              hintText: 'Örn. 45',
              suffixText: 'gram (g)',
              prefixIcon: const Icon(Icons.bakery_dining, color: AppTheme.primaryTeal),
            ),
            const SizedBox(height: 14),

            // Blood Glucose Input
            NumericField(
              controller: _glucoseController,
              labelText: 'Mevcut Kan Şekeri (Opsiyonel)',
              hintText: 'Örn. 140 (Düzeltme dozu için)',
              suffixText: profile.glucoseUnit.name == 'mgdl' ? 'mg/dL' : 'mmol/L',
              prefixIcon: const Icon(Icons.bloodtype, color: AppTheme.primaryTeal),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _isCalculating ? null : _calculateDose,
              icon: _isCalculating
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.calculate),
              label: const Text('Doz Önerisini Hesapla'),
            ),
            const SizedBox(height: 20),

            // Calculation Result Card
            if (_calculationResult != null)
              DoseResultCard(
                result: _calculationResult!,
                usesSyringe: profile.usesSyringe,
                hasConfirmedUnverifiedFood: _hasConfirmedUnverifiedFood,
                onToggleUnverifiedConfirmation: (val) {
                  setState(() => _hasConfirmedUnverifiedFood = val);
                },
                onApplyDose: _applyDose,
              ),
          ],
        ),
      ),
    );
  }
}
