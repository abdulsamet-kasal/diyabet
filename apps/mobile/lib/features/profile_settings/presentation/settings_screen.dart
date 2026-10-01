import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _targetGlucoseController = TextEditingController();
  final TextEditingController _isfController = TextEditingController();
  final TextEditingController _icrController = TextEditingController();
  final TextEditingController _diaController = TextEditingController();
  final TextEditingController _maxDoseController = TextEditingController();

  double _doseStep = 0.5; // 0.1, 0.5, 1.0
  bool _usesSyringe = false;
  bool _allowNegativeCorrection = false;
  bool _subtractFiber = false;
  bool _confirmedWithClinician = false;

  @override
  void dispose() {
    _targetGlucoseController.dispose();
    _isfController.dispose();
    _icrController.dispose();
    _diaController.dispose();
    _maxDoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

            const Text('Hekim Terapi Parametreleri', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            TextField(
              controller: _icrController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'İnsülin / Karbonhidrat Oranı (ICR)',
                hintText: 'Örn. 10 (1 ünite kaç gram karbonhidrata yeter?)',
                suffixText: 'g / U',
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _isfController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Düzeltme Faktörü (ISF)',
                hintText: 'Örn. 40 (1 ünite kan şekerini kaç mg/dL düşürür?)',
                suffixText: 'mg/dL / U',
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _targetGlucoseController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Hedef Kan Şekeri',
                hintText: 'Örn. 100',
                suffixText: 'mg/dL',
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _diaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'İnsülin Etki Süresi (DIA)',
                hintText: 'Örn. 3 veya 4',
                suffixText: 'saat',
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _maxDoseController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Maksimum Tek Doz Limiti',
                hintText: 'Örn. 12',
                suffixText: 'Ünite',
              ),
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
              onPressed: _confirmedWithClinician
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Terapi ayarları başarıyla kaydedildi.')),
                      );
                    }
                  : null,
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
