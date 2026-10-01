import 'package:flutter/material.dart';

class DoseCalculatorScreen extends StatefulWidget {
  const DoseCalculatorScreen({super.key});

  @override
  State<DoseCalculatorScreen> createState() => _DoseCalculatorScreenState();
}

class _DoseCalculatorScreenState extends State<DoseCalculatorScreen> {
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _glucoseController = TextEditingController();

  @override
  void dispose() {
    _carbsController.dispose();
    _glucoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doz Hesaplayıcı')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Safe reminder badge
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Bu ekran yalnızca doktorunuzun belirlediği oranlarla öneri hesaplar. Tıbbi tavsiye yerine geçmez.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Carbs Input
            const Text('Öğün Karbonhidratı (g)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: _carbsController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                hintText: 'Örn. 45',
                suffixText: 'gram',
              ),
            ),
            const SizedBox(height: 16),

            // Blood Glucose Input (Optional)
            const Text('Mevcut Kan Şekeri (mg/dL) — İsteğe Bağlı', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: _glucoseController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                hintText: 'Örn. 140 (Düzeltme dozu için)',
                suffixText: 'mg/dL',
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                // Calculation will trigger packages/dose_engine in Phase 1 / Phase 5
              },
              child: const Text('Doz Önerisini Hesapla'),
            ),
            const SizedBox(height: 16),

            // Legal footer disclaimer
            Center(
              child: Text(
                'Her zaman insülin enjeksiyonundan önce kendi durumunuzu teyit ediniz.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
