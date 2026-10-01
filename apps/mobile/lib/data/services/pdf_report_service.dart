import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:dose_engine/dose_engine.dart';
import '../local/app_database.dart';

class PdfReportService {
  PdfReportService._();

  static Future<Uint8List> generatePhysicianReport({
    required String diabetesType,
    required GlucoseUnit unit,
    required TherapySettings? settings,
    required List<LocalGlucoseLog> glucoseLogs,
    required List<LocalDoseLog> doseLogs,
    required double tirPercentage,
  }) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    final font = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    final theme = pw.ThemeData.withFont(
      base: font,
      bold: fontBold,
    );

    pdf.addPage(
      pw.MultiPage(
        theme: theme,
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          // Header
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'GlikoRehber - Hekim Klinik Değerlendirme Raporu',
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text('Rapor Tarihi: ${dateFormat.format(DateTime.now())}'),
                ],
              ),
              pw.Text(
                'Diyabet: ${diabetesType.toUpperCase()}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
          pw.Divider(thickness: 1.5),
          pw.SizedBox(height: 10),

          // Active Therapy Parameters
          pw.Text('1. Hekim Terapi Parametreleri', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13)),
          pw.SizedBox(height: 6),
          if (settings != null)
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Parametre', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Değer', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Birim', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  ],
                ),
                pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('ICR (Karb Oranı)')),
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(settings.defaultIcr?.toStringAsFixed(1) ?? 'Dilimli')),
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('g / U')),
                ]),
                pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('ISF (Düzeltme Faktörü)')),
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(settings.isf?.toStringAsFixed(1) ?? '-')),
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('mg/dL / U')),
                ]),
                pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Hedef Glikoz')),
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(settings.targetGlucose?.toStringAsFixed(0) ?? '-')),
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('mg/dL')),
                ]),
                pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('DIA (Etki Süresi)')),
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(settings.diaHours?.toStringAsFixed(1) ?? '-')),
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Saat')),
                ]),
                pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Maksimum Tek Doz')),
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(settings.maxSingleDose.toStringAsFixed(1))),
                  pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Ünite')),
                ]),
              ],
            )
          else
            pw.Text('Tanımlı terapi ayarı bulunmuyor.', style: const pw.TextStyle(color: PdfColors.red)),

          pw.SizedBox(height: 14),

          // TIR Summary
          pw.Text('2. Hedef Aralıkta Kalma Analizi (Time in Range - TIR)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13)),
          pw.SizedBox(height: 6),
          pw.Text('Hedef Aralık (70 - 180 mg/dL): %${(tirPercentage * 100).toStringAsFixed(1)} (Toplam ${glucoseLogs.length} ölçüm üzerinden)'),
          pw.SizedBox(height: 14),

          // Glucose Logs Table
          pw.Text('3. Son Kan Şekeri Ölçümleri', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13)),
          pw.SizedBox(height: 6),
          if (glucoseLogs.isNotEmpty)
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Tarih', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Ölçüm (mg/dL)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Bağlam', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  ],
                ),
                ...glucoseLogs.take(15).map(
                  (log) => pw.TableRow(
                    children: [
                      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(dateFormat.format(log.measuredAt))),
                      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(log.valueMgDl.toStringAsFixed(0))),
                      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(log.context)),
                    ],
                  ),
                ),
              ],
            )
          else
            pw.Text('Kayıtlı ölçüm bulunamadı.'),

          pw.SizedBox(height: 14),

          // Dose Logs Table
          pw.Text('4. Son Uygulanan İnsülin Dozları', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13)),
          pw.SizedBox(height: 6),
          if (doseLogs.isNotEmpty)
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Tarih', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Uygulanan Doz', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  ],
                ),
                ...doseLogs.take(15).map(
                  (d) => pw.TableRow(
                    children: [
                      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(dateFormat.format(d.appliedAt))),
                      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('${d.appliedUnits.toStringAsFixed(1)} U')),
                    ],
                  ),
                ),
              ],
            )
          else
            pw.Text('Kayıtlı uygulanan doz bulunamadı.'),

          pw.SizedBox(height: 24),
          pw.Divider(thickness: 0.5),
          pw.Text(
            'Yasal Uyarı: Bu rapor GlikoRehber mobil asistanı tarafından hasta kayıtlarından derlenmiştir. Tıbbi teşhis içermez; hekim incelemesi esastır.',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
        ],
      ),
    );

    return pdf.save();
  }
}
