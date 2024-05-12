class Summary {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String category;

  Summary({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.photoUrl,
  });

  Summary copyWith({
    String? id,
    String? name,
    String? category,
    String? photoUrl,
    String? description,
  }) {
    return Summary(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }
}
