class Task {
  final String id;
  final String name;
  final String description;
  final DateTime finalDate;
  late final bool isCompleted;
  final String category;

  Task({
    required this.isCompleted,
    required this.id,
    required this.name,
    required this.finalDate,
    required this.description,
    required this.category,
  });

  Task copyWith({
    String? id,
    DateTime? finalDate,
    String? name,
    bool? isCompleted,
    String? description,
    String? category,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
      description: description ?? this.description,
      category: category ?? this.category,
      finalDate: finalDate ?? this.finalDate,
    );
  }
}
