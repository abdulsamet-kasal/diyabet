import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../domain/education_article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final EducationArticle article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.titleTr),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Draft Banner
            if (article.isDraft)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  border: Border.all(color: AppTheme.accentAmber, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.warning_amber_rounded, color: AppTheme.accentAmber, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'TASLAK İÇERİK: Bu makale henüz bağımsız bir hekim/klinisyen heyeti tarafından onaylanmamıştır. Kişisel tedavi planınız için mutlaka hekiminize veya diyabet eğitim hemşirenize danışınız.',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),

            // Title and summary
            Text(
              article.titleTr,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              article.summaryTr,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700, fontStyle: FontStyle.italic),
            ),
            const Divider(height: 32),

            // Content
            _buildFormattedContent(article.contentMarkdown),
            const Divider(height: 36),

            // Sources / References Section
            const Text(
              'Tıbbi Kaynaklar ve Rehberler',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...article.sources.map(
              (source) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.bookmark_border, size: 16, color: AppTheme.primaryTeal),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        source,
                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                      ),
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

  Widget _buildFormattedContent(String markdown) {
    final lines = markdown.split('\n');
    final widgets = <Widget>[];

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        widgets.add(const SizedBox(height: 8));
      } else if (trimmed.startsWith('### ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 14.0, bottom: 6.0),
            child: Text(
              trimmed.substring(4),
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppTheme.primaryTeal),
            ),
          ),
        );
      } else if (trimmed.startsWith('* ') || trimmed.startsWith('- ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Expanded(
                  child: Text(
                    trimmed.substring(2).replaceAll('**', ''),
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (RegExp(r'^\d+\.\s').hasMatch(trimmed)) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
            child: Text(
              trimmed.replaceAll('**', ''),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4),
            ),
          ),
        );
      } else {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              trimmed.replaceAll('**', ''),
              style: const TextStyle(fontSize: 14, height: 1.45),
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
