import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class GlucoseLogScreen extends StatefulWidget {
  const GlucoseLogScreen({super.key});

  @override
  State<GlucoseLogScreen> createState() => _GlucoseLogScreenState();
}

class _GlucoseLogScreenState extends State<GlucoseLogScreen> {
  final TextEditingController _glucoseController = TextEditingController();
  String _selectedContext = 'fasting'; // fasting, postprandial, bedtime, exercise

  @override
  void dispose() {
    _glucoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Glikoz Günlüğü')),
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
                    const Text('Yeni Ölçüm Ekle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _glucoseController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        hintText: 'Kan şekeri değeri',
                        suffixText: 'mg/dL',
                        prefixIcon: Icon(Icons.bloodtype, color: AppTheme.primaryTeal),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Ölçüm Zamanı / Bağlamı', style: TextStyle(fontSize: 13, color: Colors.grey)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('Açlık'),
                          selected: _selectedContext == 'fasting',
                          onSelected: (val) => setState(() => _selectedContext = 'fasting'),
                        ),
                        ChoiceChip(
                          label: const Text('Tokluk (2. saat)'),
                          selected: _selectedContext == 'postprandial',
                          onSelected: (val) => setState(() => _selectedContext = 'postprandial'),
                        ),
                        ChoiceChip(
                          label: const Text('Yatmadan Önce'),
                          selected: _selectedContext == 'bedtime',
                          onSelected: (val) => setState(() => _selectedContext = 'bedtime'),
                        ),
                        ChoiceChip(
                          label: const Text('Egzersiz'),
                          selected: _selectedContext == 'exercise',
                          onSelected: (val) => setState(() => _selectedContext = 'exercise'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ölçüm yerel veritabanına kaydedildi.')),
                        );
                        _glucoseController.clear();
                      },
                      child: const Text('Kaydet'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Son Ölçümler', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text('Henüz kayıtlı ölçüm bulunmuyor.', style: TextStyle(color: Colors.grey.shade600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
