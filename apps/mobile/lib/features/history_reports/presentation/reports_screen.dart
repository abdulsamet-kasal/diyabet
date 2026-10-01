import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/pdf_report_service.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  double _tir = 0.0;
  int _totalGlucoseCount = 0;
  int _totalDoseCount = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  void _loadStatistics() async {
    setState(() => _isLoading = true);
    final glucoseRepo = ref.read(glucoseRepositoryProvider);
    final doseRepo = ref.read(doseRepositoryProvider);

    final tir = await glucoseRepo.calculateTimeInRange();
    final gLogs = await glucoseRepo.getRecentLogs(limit: 100);
    final dLogs = await doseRepo.getRecentDoseLogs(limit: 100);

    if (mounted) {
      setState(() {
        _tir = tir;
        _totalGlucoseCount = gLogs.length;
        _totalDoseCount = dLogs.length;
        _isLoading = false;
      });
    }
  }

  void _generateAndSharePdf() async {
    final profile = ref.read(userProfileProvider);
    final glucoseRepo = ref.read(glucoseRepositoryProvider);
    final doseRepo = ref.read(doseRepositoryProvider);

    final gLogs = await glucoseRepo.getRecentLogs(limit: 30);
    final dLogs = await doseRepo.getRecentDoseLogs(limit: 30);
    final tir = await glucoseRepo.calculateTimeInRange();

    await Printing.layoutPdf(
      onLayout: (format) async {
        return PdfReportService.generatePhysicianReport(
          diabetesType: profile.diabetesType,
          unit: profile.glucoseUnit,
          settings: profile.therapySettings,
          glucoseLogs: gLogs,
          doseLogs: dLogs,
          tirPercentage: tir,
        );
      },
      name: 'GlikoRehber_Doktor_Raporu_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Raporlar & Analiz')),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Time-in-Range Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Hedef Aralıkta Kalma (TIR)',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                '%${(_tir * 100).toStringAsFixed(1)}',
                                style: const TextStyle(
                                  color: AppTheme.glucoseTarget,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  fontFeatures: [FontFeature.tabularFigures()],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: _tir,
                              minHeight: 12,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.glucoseTarget),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Hedef: 70 - 180 mg/dL aralığı (Ulusal/Uluslararası hedef: >= %70)',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Counts Card
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              children: [
                                const Text('Toplam Ölçüm', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                const SizedBox(height: 4),
                                Text(
                                  '$_totalGlucoseCount',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryTeal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              children: [
                                const Text('Uygulanan Doz', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                const SizedBox(height: 4),
                                Text(
                                  '$_totalDoseCount',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.accentAmber),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // PDF Export Action Card
                  Card(
                    color: AppTheme.primaryTeal.withValues(alpha: 0.06),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppTheme.primaryTeal, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.picture_as_pdf, color: AppTheme.primaryTeal, size: 28),
                              SizedBox(width: 10),
                              Text(
                                'Doktor Görüşmesi İçin PDF Raporu',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Kullanılan terapi parametreleri (ICR, ISF, Hedef, DIA), Time-in-Range oranı, son kan şekeri ölçümleri ve uygulanan insülin dozlarının çıktısını PDF olarak üretir.',
                            style: TextStyle(fontSize: 12, height: 1.3),
                          ),
                          const SizedBox(height: 14),
                          ElevatedButton.icon(
                            onPressed: _generateAndSharePdf,
                            icon: const Icon(Icons.print),
                            label: const Text('PDF Raporunu Önizle / Yazdır / Paylaş'),
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
}
