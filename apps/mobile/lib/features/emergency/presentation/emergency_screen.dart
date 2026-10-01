import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/clinical_constants.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  Timer? _timer;
  int _secondsRemaining = ClinicalConstants.hypoWaitTimeMinutes * 60;
  bool _timerActive = false;

  String? _emergencyContactName;
  String? _emergencyContactPhone;

  @override
  void initState() {
    super.initState();
    _loadEmergencyContact();
  }

  Future<void> _loadEmergencyContact() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emergencyContactName = prefs.getString('emergency_contact_name');
      _emergencyContactPhone = prefs.getString('emergency_contact_phone');
    });
  }

  Future<void> _saveEmergencyContact(String name, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emergency_contact_name', name);
    await prefs.setString('emergency_contact_phone', phone);
    setState(() {
      _emergencyContactName = name;
      _emergencyContactPhone = phone;
    });
  }

  void _startTimer() {
    HapticFeedback.mediumImpact();
    setState(() {
      _timerActive = true;
      _secondsRemaining = ClinicalConstants.hypoWaitTimeMinutes * 60;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timer?.cancel();
        setState(() => _timerActive = false);
        HapticFeedback.heavyImpact();
      }
    });
  }

  void _resetTimer() {
    HapticFeedback.lightImpact();
    _timer?.cancel();
    setState(() {
      _timerActive = false;
      _secondsRemaining = ClinicalConstants.hypoWaitTimeMinutes * 60;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _callPhone(String number) async {
    HapticFeedback.heavyImpact();
    final cleanNumber = number.replaceAll(RegExp(r'\s+'), '');
    final uri = Uri.parse('tel:$cleanNumber');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Arama başlatılamadı. Lütfen $number numarasını doğrudan tuşlayın.')),
          );
        }
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Arama hatası. Lütfen $number numarasını elle arayınız.')),
        );
      }
    }
  }

  void _showEditContactDialog() {
    final nameCtrl = TextEditingController(text: _emergencyContactName);
    final phoneCtrl = TextEditingController(text: _emergencyContactPhone);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Acil Durum Yakını Tanımla'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Kişi Adı (Örn: Annem, Eşim, Dr. Ahmet)',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Telefon Numarası',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (phoneCtrl.text.trim().isNotEmpty) {
                _saveEmergencyContact(
                  nameCtrl.text.trim().isEmpty ? 'Acil Kişi' : nameCtrl.text.trim(),
                  phoneCtrl.text.trim(),
                );
              }
              Navigator.of(ctx).pop();
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hipoglisemi Acil Yardım (15-15)'),
        backgroundColor: AppTheme.glucoseLow,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Severe Warning Alert
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border.all(color: AppTheme.glucoseLow, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.report_problem, color: AppTheme.glucoseLow, size: 36),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'BİLİNÇ BULANIKLIĞI VEYA YUTMA GÜÇLÜĞÜ VARSA AĞIZDAN HİÇBİR ŞEY VERMEYİNİZ! DERHAL 112\'Yİ ARAYINIZ VEYA GLUKAGON UYGULAYINIZ.',
                      style: TextStyle(
                        color: AppTheme.glucoseLow,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Call 112 Emergency Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.glucoseSevere,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.phone_in_talk, color: Colors.white, size: 28),
              label: const Text(
                'ACİL ÇAĞRI: 112\'Yİ ARA',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () => _callPhone('112'),
            ),
            const SizedBox(height: 12),

            // User Defined Emergency Contact
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppTheme.primaryTeal,
                      child: Icon(Icons.contact_phone, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _emergencyContactName ?? 'Acil Yakını Tanımlanmadı',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            _emergencyContactPhone ?? 'Hızlı arama için bir telefon ekleyin',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    if (_emergencyContactPhone != null)
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.green, size: 28),
                        onPressed: () => _callPhone(_emergencyContactPhone!),
                      ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: _showEditContactDialog,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 15-15 Rule Steps
            const Text(
              '15-15 Kuralı Nasıl Uygulanır?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildStepCard(
              step: '1',
              title: '15 Gram Hızlı Etkili Karbonhidrat Alın',
              detail: '• 4-5 adet kesme şeker (suyla) veya\n• 150 ml (1 çay bardağı) meyve suyu veya\n• 1 tüp hazır glukoz jeli\n(Yağlı tatlılar veya çikolata yemeyin, yağ emilimi geciktirir!)',
            ),
            _buildStepCard(
              step: '2',
              title: '15 Dakika Dinlenin ve Bekleyin',
              detail: 'Fiziksel aktiviteyi derhal bırakın, oturun veya uzanın.',
            ),
            _buildStepCard(
              step: '3',
              title: 'Kan Şekerinizi Tekrar Ölçün',
              detail: 'Değer hala < 70 mg/dL ise adımları tekrarlayın. Düzelmediyse acil destek çağırın.',
            ),
            const SizedBox(height: 16),

            // 15-Minute Timer Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      '15 Dakika Geri Sayım Sayacı',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatTime(_secondsRemaining),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: _timerActive ? AppTheme.glucoseLow : Colors.black87,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _timerActive ? Colors.grey : AppTheme.primaryTeal,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            icon: const Icon(Icons.play_arrow),
                            label: Text(_timerActive ? 'Sayaç Çalışıyor...' : 'Sayacı Başlat (15 dk)'),
                            onPressed: _timerActive ? null : _startTimer,
                          ),
                        ),
                        if (_timerActive) ...[
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: _resetTimer,
                            child: const Text('Sıfırla'),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Glucagon & Unconsciousness Advisory
            Card(
              color: Colors.amber.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: AppTheme.accentAmber),
                        SizedBox(width: 8),
                        Text(
                          'Bilinç Kaybı / Glukagon Talimatı (Yakınlar İçin)',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. Hastayı sol yanına yatırın (koma pozisyonu) ve solunum yolunu açık tutun.\n'
                      '2. Hastanın yanında reçeteli Glukagon kiti (iğne veya burun spreyi) varsa gecikmeden uygulayın.\n'
                      '3. Asla ağızdan su, şeker veya yiyecek vermeyin (akciğere kaçma tehlikesi!).\n'
                      '4. 112 Acil Ambulans servisine durumun diyabet hipoglisemisi olduğunu bildirin.',
                      style: TextStyle(fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard({
    required String step,
    required String title,
    required String detail,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: AppTheme.primaryTeal,
              child: Text(
                step,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(detail, style: TextStyle(color: Colors.grey.shade700, fontSize: 12, height: 1.3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
