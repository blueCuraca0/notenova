class Summary {
  final String id;
  final String name;
  final String description;
  final List<String> photosUrl;
  final bool isCompleted;
  final int category;

  Summary(
    this.photosUrl, {
    required this.isCompleted,
    required this.id,
    required this.name,
    required this.description,
    required this.category,
  });
}
