class EducationArticle {
  final String id;
  final String slug;
  final String titleTr;
  final String summaryTr;
  final String contentMarkdown;
  final String? reviewedBy;
  final DateTime? reviewedAt;
  final List<String> sources;

  const EducationArticle({
    required this.id,
    required this.slug,
    required this.titleTr,
    required this.summaryTr,
    required this.contentMarkdown,
    this.reviewedBy,
    this.reviewedAt,
    required this.sources,
  });

  bool get isDraft => reviewedBy == null;
}
