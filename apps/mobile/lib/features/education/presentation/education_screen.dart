import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diyabet Eğitim Rehberi')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Draft review disclaimer
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                border: Border.all(color: AppTheme.accentAmber),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info, color: AppTheme.accentAmber),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tüm eğitim makaleleri klinik hekim incelemesi tamamlanana kadar TASLAK rozetiyle sunulmaktadır.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildArticleItem(
              title: '15-15 Kuralı ile Hipoglisemi Yönetimi',
              summary: 'Kan şekeri 70 mg/dL altına düştüğünde yapılacak ilk yardım adımları.',
              reviewedBy: null,
            ),
            _buildArticleItem(
              title: 'Karbonhidrat Sayımı Temelleri',
              summary: 'Gram hesabı, porsiyonlama ve Türkiye standart değişim birimi (15g).',
              reviewedBy: null,
            ),
            _buildArticleItem(
              title: 'İnsülin Saklama ve Enjeksiyon Bölge Rotasyonu',
              summary: 'Lipohipertrofiyi önleme ve oda sıcaklığında insülin stabilitesi.',
              reviewedBy: null,
            ),
            _buildArticleItem(
              title: 'Hasta Günleri Rehberi (Sick-Day Management)',
              summary: 'Enfeksiyon veya ateş durumunda insülin ihtiyacı ve keton kontrolü.',
              reviewedBy: null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleItem({
    required String title,
    required String summary,
    required String? reviewedBy,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: reviewedBy != null ? Colors.green.shade100 : Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    reviewedBy != null ? 'ONAYLI' : 'TASLAK',
                    style: TextStyle(
                      color: reviewedBy != null ? Colors.green.shade800 : Colors.amber.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(summary, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
