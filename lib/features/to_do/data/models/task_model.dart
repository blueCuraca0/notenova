class Task {
  final String id;
  final String name;
  final String description;
  final DateTime finalDate;
  final bool isCompleted;
  final int category;

  Task({
    required this.isCompleted,
    required this.id,
    required this.name,
    required this.finalDate,
    required this.description,
    required this.category,
  });
}

List<Task> tasks = [
  Task(
    id: '1',
    name: 'Прибрати квартиру',
    description: 'Прибрати кімнату та ванну кімнату',
    finalDate: DateTime(2024, 5, 5, 18, 0),
    isCompleted: false,
    category: 1,
  ),
  Task(
    id: '2',
    name: 'Подивитися відеоурок Flutter',
    description: 'Подивитися відеоурок по створенню списків в Flutter',
    finalDate: DateTime(2024, 5, 6, 20, 0),
    isCompleted: false,
    category: 2,
  ),
  Task(
    id: '3',
    name: 'Підготуватися до зустрічі',
    description: 'Підготуватися до презентації та зустрічі з клієнтом',
    finalDate: DateTime(2024, 5, 7, 10, 0),
    isCompleted: false,
    category: 3,
  ),
  Task(
    id: '3',
    name: 'Підготуватися до зустрічі',
    description: 'Підготуватися до презентації та зустрічі з клієнтом',
    finalDate: DateTime(2024, 5, 7, 10, 0),
    isCompleted: false,
    category: 3,
  ),
  Task(
    id: '4',
    name: 'Підготуватися до зустрічі',
    description: 'Підготуватися до презентації та зустрічі з клієнтом',
    finalDate: DateTime(2024, 6, 8, 12, 0),
    isCompleted: false,
    category: 3,
  ),
];
