import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Raporlar & Analiz')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hedef Aralıkta Kalma (TIR)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    const Text('70 - 180 mg/dL arası kan şekeri oranınız:'),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 0.75,
                      minHeight: 12,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.glucoseTarget),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    const SizedBox(height: 8),
                    const Text('%75 Hedefte (Son 14 gün)', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.glucoseTarget)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: AppTheme.primaryTeal, size: 36),
                title: const Text('Hekim Raporu Oluştur (PDF)', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Tüm glikoz ve doz kayıtlarını PDF formatında dışa aktarın.'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PDF raporu oluşturma hazırlanıyor...')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
