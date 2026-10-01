import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _hasAcceptedDisclaimer = false;
  bool _isOver18 = true;
  String _selectedDiabetesType = 'type1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GlikoRehber Kurulum')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Hoş Geldiniz',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'GlikoRehber, karbonhidrat sayımı ve hekiminizin önerdiği oranlarla insülin dozu hesaplamanızı kolaylaştıran bir asistanıdır.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // Disclaimer Card
            Card(
              color: Colors.amber.shade50,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppTheme.accentAmber, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.shield_outlined, color: AppTheme.accentAmber),
                        const SizedBox(width: 8),
                        const Text(
                          'Önemli Tıbbi Sorumluluk Reddi',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Bu uygulama tıbbi bir cihaz veya hekim değildir. Tıbbi tanı veya kesin tedavi kararı vermez.\n'
                      '2. Hesaplanan tüm insülin dozları ÖNERİ niteliğindedir. Uygulamadan önce doktorunuzun veya eğitim hemşirenizin talimatlarıyla karşılaştırınız.\n'
                      '3. Hipoglisemi (< 70 mg/dL) durumunda doz hesaplanmaz, acil 15-15 kuralı uygulanmalıdır.\n'
                      '4. KVKK kapsamında sağlık verileriniz öncelikle cihazınızda çevrimdışı saklanır.',
                      style: TextStyle(fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: _hasAcceptedDisclaimer,
                      onChanged: (val) {
                        setState(() {
                          _hasAcceptedDisclaimer = val ?? false;
                        });
                      },
                      title: const Text(
                        'Aydınlatma metnini ve sorumluluk reddini okudum, anladım ve kabul ediyorum.',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Age Check
            const Text(
              'Yaş Uygunluğu (v1 Sürümü)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('18 yaş ve üzerindeyim'),
              subtitle: Text(
                _isOver18
                    ? 'Doz hesaplayıcı ve tüm özellikler açık.'
                    : '18 yaş altı için doz hesaplayıcı kilitlidir (yalnızca besin ve bilgi modu).',
                style: TextStyle(
                  color: _isOver18 ? Colors.green.shade700 : AppTheme.glucoseLow,
                  fontSize: 12,
                ),
              ),
              value: _isOver18,
              onChanged: (val) => setState(() => _isOver18 = val),
            ),
            const SizedBox(height: 16),

            // Diabetes Type Selection
            const Text(
              'Diyabet Tipi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildTypeCard(
              id: 'type1',
              title: 'Tip 1 Diyabet',
              subtitle: 'Öğün dozu (ICR) + Düzeltme dozu (ISF) + Aktif İnsülin (IOB)',
            ),
            _buildTypeCard(
              id: 'type2_prandial_insulin',
              title: 'Tip 2 Diyabet (Hızlı etkili öğün insülini kullanıyor)',
              subtitle: 'Öğün ve düzeltme dozu hesaplama aktif',
            ),
            _buildTypeCard(
              id: 'type2_basal_or_none',
              title: 'Tip 2 Diyabet (Sadece bazal insülin veya insülinsiz)',
              subtitle: 'Doz hesaplayıcı kapalı; karbonhidrat bütçesi ve besin takibi aktif',
            ),
            _buildTypeCard(
              id: 'other',
              title: 'Diğer (LADA, MODY, Gestasyonel vb.)',
              subtitle: 'Doktor eşliğinde bilgi modu',
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _hasAcceptedDisclaimer
                  ? () {
                      context.go('/');
                    }
                  : null,
              child: const Text('Başla ve Ayarları Yapılandır'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeCard({
    required String id,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedDiabetesType == id;
    return Card(
      elevation: isSelected ? 2 : 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isSelected ? AppTheme.primaryTeal : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => setState(() => _selectedDiabetesType = id),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: isSelected ? AppTheme.primaryTeal : Colors.grey,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(fontSize: 12)),
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
