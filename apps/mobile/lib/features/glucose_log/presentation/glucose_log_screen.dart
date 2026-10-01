import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/numeric_field.dart';
import '../../../core/widgets/glucose_chip.dart';
import '../../../data/local/app_database.dart';
import '../../../data/providers/app_providers.dart';

class GlucoseLogScreen extends ConsumerStatefulWidget {
  const GlucoseLogScreen({super.key});

  @override
  ConsumerState<GlucoseLogScreen> createState() => _GlucoseLogScreenState();
}

class _GlucoseLogScreenState extends ConsumerState<GlucoseLogScreen> {
  final _glucoseController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedContext = 'fasting'; // fasting, postprandial, bedtime, exercise, other

  List<LocalGlucoseLog> _logs = [];
  double _tir = 0.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  void _loadLogs() async {
    setState(() => _isLoading = true);
    final repo = ref.read(glucoseRepositoryProvider);
    final logs = await repo.getRecentLogs(limit: 50);
    final tir = await repo.calculateTimeInRange();
    if (mounted) {
      setState(() {
        _logs = logs;
        _tir = tir;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _glucoseController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _saveLog() async {
    final value = NumericField.parseTurkishDouble(_glucoseController.text);
    if (value == null || value <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen geçerli bir kan şekeri değeri giriniz.')),
      );
      return;
    }

    final repo = ref.read(glucoseRepositoryProvider);
    await repo.addGlucoseLog(
      valueMgDl: value,
      context: _selectedContext,
      measuredAt: DateTime.now(),
      note: _noteController.text.trim().isNotEmpty ? _noteController.text.trim() : null,
    );

    _glucoseController.clear();
    _noteController.clear();
    _loadLogs();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kan şekeri ölçümü başarıyla kaydedildi.')),
      );
    }
  }

  String _getContextLabel(String ctx) {
    switch (ctx) {
      case 'fasting':
        return 'Açlık';
      case 'postprandial':
        return 'Tokluk (2. saat)';
      case 'bedtime':
        return 'Yatmadan Önce';
      case 'exercise':
        return 'Egzersiz';
      default:
        return 'Diğer';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM HH:mm', 'tr_TR');

    return Scaffold(
      appBar: AppBar(title: const Text('Glikoz Günlüğü')),
      body: SafeArea(
        child: Column(
          children: [
            // Top TIR Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              color: AppTheme.primaryTeal.withValues(alpha: 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hedef Aralıkta Kalma (TIR)',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        '%${(_tir * 100).toStringAsFixed(0)} Hedefte',
                        style: const TextStyle(
                          color: AppTheme.glucoseTarget,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: _tir,
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.glucoseTarget),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Hedef: 70 - 180 mg/dL (${_logs.length} ölçüm)',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            // Quick Add Glucose Section
            Card(
              margin: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: NumericField(
                            controller: _glucoseController,
                            labelText: 'Yeni Kan Şekeri Ölçümü',
                            hintText: 'Örn. 125',
                            suffixText: 'mg/dL',
                            prefixIcon: const Icon(Icons.bloodtype, color: AppTheme.primaryTeal),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _saveLog,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80, 48),
                          ),
                          child: const Text('Kaydet'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('Açlık', style: TextStyle(fontSize: 12)),
                          selected: _selectedContext == 'fasting',
                          onSelected: (_) => setState(() => _selectedContext = 'fasting'),
                        ),
                        ChoiceChip(
                          label: const Text('Tokluk', style: TextStyle(fontSize: 12)),
                          selected: _selectedContext == 'postprandial',
                          onSelected: (_) => setState(() => _selectedContext = 'postprandial'),
                        ),
                        ChoiceChip(
                          label: const Text('Yatmadan Önce', style: TextStyle(fontSize: 12)),
                          selected: _selectedContext == 'bedtime',
                          onSelected: (_) => setState(() => _selectedContext = 'bedtime'),
                        ),
                        ChoiceChip(
                          label: const Text('Egzersiz', style: TextStyle(fontSize: 12)),
                          selected: _selectedContext == 'exercise',
                          onSelected: (_) => setState(() => _selectedContext = 'exercise'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Recent Readings List
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _logs.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bloodtype_outlined, size: 56, color: Colors.grey.shade400),
                              const SizedBox(height: 10),
                              const Text('Henüz kayıtlı ölçüm yok', style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              const Text('Yukarıdaki formdan ilk kan şekeri değerinizi kaydedebilirsiniz.'),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: _logs.length,
                          itemBuilder: (context, index) {
                            final log = _logs[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: GlucoseChip(valueMgDl: log.valueMgDl),
                                title: Text(
                                  _getContextLabel(log.context),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                subtitle: log.note != null ? Text(log.note!) : null,
                                trailing: Text(
                                  dateFormat.format(log.measuredAt),
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                ),
                              ),
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
