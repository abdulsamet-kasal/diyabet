import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  bool _biometricLockEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initValues());
  }

  Future<void> _initValues() async {
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
    final security = ref.read(securityServiceProvider);
    final bioEnabled = await security.isBiometricLockEnabled();
    if (mounted) {
      setState(() {
        _biometricLockEnabled = bioEnabled;
      });
    }
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

  Future<void> _toggleBiometricLock(bool value) async {
    final security = ref.read(securityServiceProvider);
    if (value) {
      final authenticated = await security.authenticate(
        reason: 'Biyometrik kilidi aktif etmek için doğrulayınız.',
      );
      if (!authenticated) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kimlik doğrulanamadı. Biyometrik kilit açılmadı.')),
          );
        }
        return;
      }
    }
    await security.setBiometricLockEnabled(value);
    setState(() => _biometricLockEnabled = value);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value
              ? 'Biyometrik kilit koruması aktif edildi.'
              : 'Biyometrik kilit devre dışı bırakıldı.'),
        ),
      );
    }
  }

  Future<void> _exportData() async {
    final profile = ref.read(userProfileProvider);
    final exportService = ref.read(dataExportServiceProvider);

    final jsonStr = await exportService.exportToJsonString(
      diabetesType: profile.diabetesType,
      glucoseUnit: profile.glucoseUnit.name,
      usesSyringe: profile.usesSyringe,
    );

    if (!mounted) return;

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('KVKK / GDPR Veri Paketi (JSON)'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tüm profil, ölçüm ve doz kütükleriniz yapılandırılmış JSON biçiminde hazırlandı:',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    jsonStr,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: jsonStr));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Veri paketi panoya kopyalandı.')),
              );
            },
            child: const Text('Panoya Kopyala'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  Future<void> _syncCloud() async {
    final db = ref.read(databaseProvider);
    final syncService = ref.read(syncServiceProvider);

    final res = await syncService.syncAll(db: db);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res.message),
        backgroundColor: res.isSuccess ? AppTheme.glucoseTarget : Colors.orange.shade800,
      ),
    );
  }

  Future<void> _hardDeleteAccountAndData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tüm Verileri ve Hesabı Kalıcı Olarak Sil?'),
        content: const Text(
          'DİKKAT: Bu işlem tüm glikoz ölçümlerinizi, insülin doz kütüklerinizi, hekim ayarlarınızı ve cihazdaki güvenlik anahtarlarını GERİ DÖNÜŞSÜZ olarak siler.\n\nEmin misiniz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Vazgeç'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.glucoseSevere),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('EVET, KALICI OLARAK SİL', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final notifier = ref.read(userProfileProvider.notifier);
      await notifier.hardDeleteAllUserData();

      final security = ref.read(securityServiceProvider);
      await security.clearAllSecureData();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tüm kişisel verileriniz ve ayarlarınız başarıyla sıfırlandı.'),
          ),
        );
        context.go('/onboarding');
      }
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

            // Security & Biometric Lock Section
            const Text('Güvenlik ve Biyometrik Koruma', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Biyometrik Kilit (Parmak İzi / Yüz Tanıma)'),
              subtitle: const Text('Hassas sağlık ve insülin doz verilerinizi korumak için doğrulama zorunlu kılınsın.'),
              value: _biometricLockEnabled,
              onChanged: _toggleBiometricLock,
            ),
            const Divider(height: 28),

            // Supabase Cloud Sync Section
            const Text('Bulut Senkronizasyonu (Supabase)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: AppTheme.primaryTeal,
                child: Icon(Icons.cloud_sync, color: Colors.white),
              ),
              title: const Text('Çevrimdışı Öncelikli Senkronizasyon'),
              subtitle: const Text('Ölçüm ve doz kayıtlarınızı güvenli bulut sunucusuna senkronize edin.'),
              trailing: OutlinedButton(
                onPressed: _syncCloud,
                child: const Text('Eşitle'),
              ),
            ),
            const Divider(height: 28),

            // KVKK & Privacy actions
            const Text('Gizlilik ve Veri Yönetimi (KVKK / GDPR)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.file_download_outlined, color: AppTheme.primaryTeal),
              title: const Text('Tüm Verilerimi Dışa Aktar (JSON)'),
              subtitle: const Text('KVKK Madde 11 uyarınca profil, ayar, glikoz ve doz kütüklerinizi indirin.'),
              onTap: _exportData,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.delete_forever, color: AppTheme.glucoseSevere),
              title: const Text('Tüm Verilerimi ve Hesabımı Kalıcı Olarak Sil', style: TextStyle(color: AppTheme.glucoseSevere)),
              subtitle: const Text('Unutulma hakkı: Tüm yerel SQLite verilerini ve ayarları temizler.'),
              onTap: _hardDeleteAccountAndData,
            ),
          ],
        ),
      ),
    );
  }
}
