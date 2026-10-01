import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dose_engine/dose_engine.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/numeric_field.dart';
import '../../../data/providers/app_providers.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _currentStep = 0;

  // Step 1: Legal disclaimer
  bool _hasAcceptedDisclaimer = false;

  // Step 2: Age and profile
  bool _isOver18 = true;
  String _selectedDiabetesType = 'type1';
  GlucoseUnit _selectedGlucoseUnit = GlucoseUnit.mgdl;
  bool _usesSyringe = false;

  // Step 3: Therapy settings wizard
  final _icrController = TextEditingController();
  final _isfController = TextEditingController();
  final _targetGlucoseController = TextEditingController();
  final _diaController = TextEditingController();
  final _maxDoseController = TextEditingController();
  double _doseStep = 0.5;
  bool _confirmedWithClinician = false;

  @override
  void dispose() {
    _icrController.dispose();
    _isfController.dispose();
    _targetGlucoseController.dispose();
    _diaController.dispose();
    _maxDoseController.dispose();
    super.dispose();
  }

  void _onComplete() async {
    final notifier = ref.read(userProfileProvider.notifier);
    notifier.acceptDisclaimer();
    notifier.setAgeOver18(_isOver18);
    notifier.setDiabetesType(_selectedDiabetesType);
    notifier.setGlucoseUnit(_selectedGlucoseUnit);
    notifier.setUsesSyringe(_usesSyringe);

    // Save therapy settings if provided
    final icr = NumericField.parseTurkishDouble(_icrController.text);
    final isf = NumericField.parseTurkishDouble(_isfController.text);
    final target = NumericField.parseTurkishDouble(_targetGlucoseController.text);
    final dia = NumericField.parseTurkishDouble(_diaController.text);
    final maxDose = NumericField.parseTurkishDouble(_maxDoseController.text);

    if (icr != null && maxDose != null) {
      final settings = TherapySettings(
        defaultIcr: icr,
        isf: isf,
        targetGlucose: target,
        diaHours: dia,
        doseStep: _doseStep,
        maxSingleDose: maxDose,
        confirmedWithClinician: _confirmedWithClinician,
      );
      await notifier.updateTherapySettings(settings);
    }

    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GlikoRehber Kurulum')),
      body: SafeArea(
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep == 0 && !_hasAcceptedDisclaimer) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Lütfen sorumluluk reddi ve aydınlatma metnini onaylayınız.')),
              );
              return;
            }
            if (_currentStep < 2) {
              setState(() => _currentStep++);
            } else {
              _onComplete();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            }
          },
          steps: [
            // Step 1: Legal Disclaimer & Consent
            Step(
              title: const Text('Sorumluluk Reddi & Onay'),
              isActive: _currentStep >= 0,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.amber.shade50,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppTheme.accentAmber, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.shield_outlined, color: AppTheme.accentAmber),
                              SizedBox(width: 8),
                              Text(
                                'Önemli Tıbbi Bilgilendirme',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '1. GlikoRehber bir tıbbi cihaz veya hekim değildir. Hesaplamalar tamamen ÖNERİ niteliğindedir.\n'
                            '2. Dozu enjekte etmeden önce daima hekiminizin reçetesine göre kontrol ediniz.\n'
                            '3. Kan şekeri < 70 mg/dL ise doz hesaplanmaz, acil 15-15 kuralı uygulanmalıdır.\n'
                            '4. KVKK gereğince sağlık verileriniz öncelikle cihazınızda çevrimdışı saklanır.',
                            style: TextStyle(fontSize: 13, height: 1.4),
                          ),
                          const SizedBox(height: 10),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: _hasAcceptedDisclaimer,
                            onChanged: (val) => setState(() => _hasAcceptedDisclaimer = val ?? false),
                            title: const Text(
                              'Aydınlatma metnini okudum, anladım ve kabul ediyorum.',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Step 2: Profile & Diabetes Type
            Step(
              title: const Text('Diyabet Profili'),
              isActive: _currentStep >= 1,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('18 yaş ve üzerindeyim'),
                    subtitle: Text(
                      _isOver18
                          ? 'Doz hesaplayıcı ve tüm özellikler açık.'
                          : '18 yaş altı için v1 sürümünde doz hesaplayıcı kilitlidir.',
                      style: TextStyle(
                        fontSize: 12,
                        color: _isOver18 ? Colors.green.shade700 : AppTheme.glucoseLow,
                      ),
                    ),
                    value: _isOver18,
                    onChanged: (val) => setState(() => _isOver18 = val),
                  ),
                  const SizedBox(height: 12),
                  const Text('Diyabet Tipiniz:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  _buildTypeOption('type1', 'Tip 1 Diyabet', 'ICR + ISF + IOB tam özellik'),
                  _buildTypeOption('type2_prandial_insulin', 'Tip 2 (Hızlı Etkili İnsülin)', 'Öğün ve düzeltme dozu aktif'),
                  _buildTypeOption('type2_basal_or_none', 'Tip 2 (Sadece Bazal / İnsülinsiz)', 'Doz kapalı; karbonhidrat sayımı aktif'),
                  _buildTypeOption('other', 'Diğer (LADA / Gestasyonel / MODY)', 'Bilgi modu'),
                  const SizedBox(height: 12),
                  const Text('Kan Şekeri Birimi:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  SegmentedButton<GlucoseUnit>(
                    segments: const [
                      ButtonSegment(value: GlucoseUnit.mgdl, label: Text('mg/dL (Türkiye)')),
                      ButtonSegment(value: GlucoseUnit.mmoll, label: Text('mmol/L')),
                    ],
                    selected: {_selectedGlucoseUnit},
                    onSelectionChanged: (set) => setState(() => _selectedGlucoseUnit = set.first),
                  ),
                ],
              ),
            ),

            // Step 3: Clinician Therapy Settings
            Step(
              title: const Text('Terapi Değerleri'),
              isActive: _currentStep >= 2,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: const Text(
                      'Varsayılan klinik değer yoktur. Değerleri doktorunuzun reçete ettiği şekilde giriniz.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  NumericField(
                    controller: _icrController,
                    labelText: 'İnsülin / Karbonhidrat Oranı (ICR)',
                    hintText: 'Örn. 10 (1 ünite kaç g karb?)',
                    suffixText: 'g / U',
                  ),
                  const SizedBox(height: 10),
                  NumericField(
                    controller: _isfController,
                    labelText: 'Düzeltme Faktörü (ISF)',
                    hintText: 'Örn. 40 (1 ünite kaç mg/dL düşürür?)',
                    suffixText: 'mg/dL / U',
                  ),
                  const SizedBox(height: 10),
                  NumericField(
                    controller: _targetGlucoseController,
                    labelText: 'Hedef Kan Şekeri',
                    hintText: 'Örn. 100',
                    suffixText: 'mg/dL',
                  ),
                  const SizedBox(height: 10),
                  NumericField(
                    controller: _diaController,
                    labelText: 'İnsülin Etki Süresi (DIA)',
                    hintText: 'Örn. 3 veya 4',
                    suffixText: 'saat',
                  ),
                  const SizedBox(height: 10),
                  NumericField(
                    controller: _maxDoseController,
                    labelText: 'Maksimum Tek Doz Limiti',
                    hintText: 'Örn. 12',
                    suffixText: 'Ünite',
                  ),
                  const SizedBox(height: 12),
                  const Text('Doz Adımı:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  SegmentedButton<double>(
                    segments: const [
                      ButtonSegment(value: 0.1, label: Text('0.1 U')),
                      ButtonSegment(value: 0.5, label: Text('0.5 U')),
                      ButtonSegment(value: 1.0, label: Text('1.0 U')),
                    ],
                    selected: {_doseStep},
                    onSelectionChanged: (set) => setState(() => _doseStep = set.first),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Şırınga Kullanıyorum (U-100 mL)'),
                    value: _usesSyringe,
                    onChanged: (val) => setState(() => _usesSyringe = val),
                  ),
                  const SizedBox(height: 6),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _confirmedWithClinician,
                    onChanged: (val) => setState(() => _confirmedWithClinician = val ?? false),
                    title: const Text(
                      'Bu değerleri doktorumla teyit ettim.',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeOption(String id, String title, String subtitle) {
    final isSelected = _selectedDiabetesType == id;
    return Card(
      elevation: isSelected ? 2 : 0,
      margin: const EdgeInsets.only(bottom: 6),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isSelected ? AppTheme.primaryTeal : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => setState(() => _selectedDiabetesType = id),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: isSelected ? AppTheme.primaryTeal : Colors.grey,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
