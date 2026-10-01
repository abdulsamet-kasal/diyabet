import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../data/education_articles_data.dart';
import '../domain/education_article.dart';
import 'article_detail_screen.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredArticles = EducationArticlesData.articles.where((article) {
      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      return article.titleTr.toLowerCase().contains(query) ||
          article.summaryTr.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diyabet Eğitim Rehberi'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Draft review disclaimer
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                border: Border.all(color: AppTheme.accentAmber),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppTheme.accentAmber),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tüm eğitim makaleleri klinik hekim incelemesi tamamlanana kadar "TASLAK" rozetiyle sunulmaktadır. Hekiminizin talimatları her zaman önceliklidir.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Makalelerde ara (hipoglisemi, keton, etiket...)',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() => _searchQuery = ''),
                        )
                      : null,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (val) => setState(() => _searchQuery = val),
              ),
            ),
            const SizedBox(height: 12),

            // Article List
            Expanded(
              child: filteredArticles.isEmpty
                  ? const Center(child: Text('Aradığınız kriterlere uygun makale bulunamadı.'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: filteredArticles.length,
                      itemBuilder: (context, index) {
                        final article = filteredArticles[index];
                        return _buildArticleCard(context, article);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, EducationArticle article) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ArticleDetailScreen(article: article),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      article.titleTr,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: article.isDraft ? Colors.amber.shade100 : Colors.green.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      article.isDraft ? 'TASLAK' : 'ONAYLI',
                      style: TextStyle(
                        color: article.isDraft ? Colors.amber.shade900 : Colors.green.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                article.summaryTr,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13, height: 1.3),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${article.sources.length} kaynak rehber',
                    style: const TextStyle(fontSize: 11, color: AppTheme.primaryTeal, fontWeight: FontWeight.w600),
                  ),
                  const Row(
                    children: [
                      Text('Oku', style: TextStyle(fontSize: 13, color: AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 14, color: AppTheme.primaryTeal),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
