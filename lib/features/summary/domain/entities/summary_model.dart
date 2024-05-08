class Summary {
  final String id;
  final String name;
  final String description;
  final String photosUrl;
  final String category;

  Summary({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.photosUrl,
  });

  Summary copyWith({
    String? id,
    String? name,
    String? category,
    String? photosUrl,
    String? description,
  }) {
    return Summary(
      id: id ?? this.id,
      name: name ?? this.name,
      photosUrl: photosUrl ?? this.photosUrl,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }
}

final summaries = [
  Summary(
    id: '1',
    name: 'Trip to Paris',
    description: 'Visit Eiffel Tower and Louvre Museum',
    category: 'Exams',
    photosUrl: 'https://example.com/paris.jpg',
  ),
  Summary(
    id: '2',
    name: 'Beach vacation',
    description: 'Relax on the sunny beach',
    category: 'Lectures',
    photosUrl: 'https://example.com/beach.jpg',
  ),
  Summary(
    id: '3',
    name: 'Mountain hiking',
    description: 'Conquer the highest peaks',
    category: 'Lectures',
    photosUrl: 'https://example.com/mountain.jpg',
  ),
];
