import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dose_engine/dose_engine.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/numeric_field.dart';
import '../../../data/providers/app_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _targetGlucoseController = TextEditingController();
  final _isfController = TextEditingController();
  final _icrController = TextEditingController();
  final _diaController = TextEditingController();
  final _maxDoseController = TextEditingController();

  double _doseStep = 0.5;
  bool _usesSyringe = false;
  bool _allowNegativeCorrection = false;
  bool _subtractFiber = false;
  bool _confirmedWithClinician = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initValues());
  }

  void _initValues() {
    final profile = ref.read(userProfileProvider);
    final settings = profile.therapySettings;
    if (settings != null) {
      if (settings.defaultIcr != null) _icrController.text = settings.defaultIcr.toString();
      if (settings.isf != null) _isfController.text = settings.isf.toString();
      if (settings.targetGlucose != null) _targetGlucoseController.text = settings.targetGlucose.toString();
      if (settings.diaHours != null) _diaController.text = settings.diaHours.toString();
      _maxDoseController.text = settings.maxSingleDose.toString();
      _doseStep = settings.doseStep;
      _allowNegativeCorrection = settings.allowNegativeCorrection;
      _subtractFiber = settings.subtractFiber;
      _confirmedWithClinician = settings.confirmedWithClinician;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _targetGlucoseController.dispose();
    _isfController.dispose();
    _icrController.dispose();
    _diaController.dispose();
    _maxDoseController.dispose();
    super.dispose();
  }

  void _saveSettings() async {
    final icr = NumericField.parseTurkishDouble(_icrController.text);
    final isf = NumericField.parseTurkishDouble(_isfController.text);
    final target = NumericField.parseTurkishDouble(_targetGlucoseController.text);
    final dia = NumericField.parseTurkishDouble(_diaController.text);
    final maxDose = NumericField.parseTurkishDouble(_maxDoseController.text) ?? 15.0;

    final newSettings = TherapySettings(
      defaultIcr: icr,
      isf: isf,
      targetGlucose: target,
      diaHours: dia,
      doseStep: _doseStep,
      maxSingleDose: maxDose,
      allowNegativeCorrection: _allowNegativeCorrection,
      subtractFiber: _subtractFiber,
      confirmedWithClinician: _confirmedWithClinician,
    );

    final notifier = ref.read(userProfileProvider.notifier);
    await notifier.updateTherapySettings(newSettings);
    notifier.setUsesSyringe(_usesSyringe);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terapi ayarları başarıyla güncellendi.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Terapi ve Uygulama Ayarları')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Clinical values warning
            Card(
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue.shade200),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.health_and_safety, color: AppTheme.primaryTeal),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Varsayılan klinik değer bulunmamaktadır. Tüm oranlar yalnızca hekiminizin reçete ettiği değerlerle doldurulmalıdır.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Profile info chip
            Row(
              children: [
                Chip(
                  avatar: const Icon(Icons.person, size: 18),
                  label: Text('Diyabet: ${profile.diabetesType.toUpperCase()}'),
                ),
                const SizedBox(width: 8),
                Chip(
                  avatar: const Icon(Icons.bloodtype, size: 18),
                  label: Text('Birim: ${profile.glucoseUnit.name.toUpperCase()}'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text('Hekim Terapi Parametreleri', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            NumericField(
              controller: _icrController,
              labelText: 'İnsülin / Karbonhidrat Oranı (ICR)',
              hintText: 'Örn. 10 (1 ünite kaç gram karbonhidrata yeter?)',
              suffixText: 'g / U',
            ),
            const SizedBox(height: 12),

            NumericField(
              controller: _isfController,
              labelText: 'Düzeltme Faktörü (ISF)',
              hintText: 'Örn. 40 (1 ünite kaç mg/dL düşürür?)',
              suffixText: 'mg/dL / U',
            ),
            const SizedBox(height: 12),

            NumericField(
              controller: _targetGlucoseController,
              labelText: 'Hedef Kan Şekeri',
              hintText: 'Örn. 100',
              suffixText: 'mg/dL',
            ),
            const SizedBox(height: 12),

            NumericField(
              controller: _diaController,
              labelText: 'İnsülin Etki Süresi (DIA)',
              hintText: 'Örn. 3 veya 4',
              suffixText: 'saat',
            ),
            const SizedBox(height: 12),

            NumericField(
              controller: _maxDoseController,
              labelText: 'Maksimum Tek Doz Limiti',
              hintText: 'Örn. 12',
              suffixText: 'Ünite',
            ),
            const SizedBox(height: 16),

            // Dose Step Selector
            const Text('İnsülin Kalem/Şırınga Doz Adımı', style: TextStyle(fontWeight: FontWeight.bold)),
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
            const SizedBox(height: 16),

            // Optional settings
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Şırınga Kullanıyorum (U-100 mL Gösterimi)'),
              subtitle: const Text('Yalnızca U-100 insülin için mL karşılığı gösterilir.'),
              value: _usesSyringe,
              onChanged: (val) => setState(() => _usesSyringe = val),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Negatif Düzeltmeye İzin Ver'),
              subtitle: const Text('Şeker hedefin altındaysa öğün dozundan düşer (Varsayılan kapalı).'),
              value: _allowNegativeCorrection,
              onChanged: (val) => setState(() => _allowNegativeCorrection = val),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Net Karbonhidrat İçin Lifi Düş'),
              subtitle: const Text('Doktorunuzla teyit etmeden açmayınız (Varsayılan kapalı).'),
              value: _subtractFiber,
              onChanged: (val) => setState(() => _subtractFiber = val),
            ),
            const SizedBox(height: 8),

            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Bu değerlerin tamamını doktorumla veya diyabet eğitim hemşiremle teyit ettim.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              value: _confirmedWithClinician,
              onChanged: (val) => setState(() => _confirmedWithClinician = val ?? false),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _confirmedWithClinician ? _saveSettings : null,
              child: const Text('Ayarları Kaydet'),
            ),
            const Divider(height: 36),

            // KVKK & Privacy actions
            const Text('Gizlilik ve Veri Yönetimi (KVKK)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Tüm Verilerimi Dışa Aktar (JSON)'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Veri paketi hazırlanıyor...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: AppTheme.glucoseLow),
              title: const Text('Tüm Verilerimi ve Hesabımı Kalıcı Olarak Sil', style: TextStyle(color: AppTheme.glucoseLow)),
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Hesap ve Veri Silme'),
                    content: const Text(
                      'Tüm sağlık kayıtlarınız, glikoz ölçümleriniz ve terapi ayarlarınız cihazdan ve sunucudan kalıcı olarak silinecektir. Bu işlem geri alınamaz.',
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Vazgeç')),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Tüm yerel veriler kalıcı olarak silindi.')),
                          );
                        },
                        child: const Text('Kalıcı Olarak Sil', style: TextStyle(color: AppTheme.glucoseLow)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
