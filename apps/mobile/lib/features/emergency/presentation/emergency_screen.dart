import 'dart:async';
import 'package:flutter/material.dart';
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

  void _startTimer() {
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
      }
    });
  }

  void _resetTimer() {
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
                      'BİLİNÇ BULANIKLIĞI VEYA YUTMA GÜÇLÜĞÜ VARSA AĞIZDAN HİÇBİR ŞEY VERMEYİNİZ! DERHAL 112\'Yİ ARAYINIZ.',
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

            // 15-15 Rule Steps
            const Text(
              '15-15 Kuralı Nasıl Uygulanır?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildStepCard(
              step: '1',
              title: '15 Gram Hızlı Etkili Karbonhidrat Alın',
              detail: '• 4-5 adet kesme şeker veya\n• 150 ml (1 çay bardağı) meyve suyu veya\n• 1 tüp glukoz jeli\n(Çikolata veya yağlı tatlılar tercih etmeyin, yağ emilimi geciktirir.)',
            ),
            _buildStepCard(
              step: '2',
              title: '15 Dakika Dinlenin ve Bekleyin',
              detail: 'Fiziksel aktivite yapmayın, oturun veya uzanın.',
            ),
            _buildStepCard(
              step: '3',
              title: 'Kan Şekerinizi Tekrar Ölçün',
              detail: 'Değer hala < 70 mg/dL ise adımları tekrarlayın. Düzelmediyse acil destek alın.',
            ),
            const SizedBox(height: 16),

            // 15-Minute Timer Card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      '15 Dakika Geri Sayım Sayacı',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
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
                            ),
                            icon: const Icon(Icons.play_arrow),
                            label: Text(_timerActive ? 'Sayaç Çalışıyor' : 'Sayacı Başlat (15 dk)'),
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

            // Call 112 Emergency Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.glucoseSevere,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.phone_in_talk, color: Colors.white, size: 28),
              label: const Text(
                'ACİL ÇAĞRI: 112\'Yİ ARA',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Acil durum: Lütfen telefonunuzdan 112 Acil Yardım hattını arayınız.'),
                  ),
                );
              },
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
