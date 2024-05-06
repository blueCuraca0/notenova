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
}

List<Task> tasks = [
  Task(
    id: '1',
    name: 'Прибрати квартиру',
    description: 'Прибрати кімнату та ванну кімнату',
    finalDate: DateTime(2024, 5, 11, 18, 0),
    isCompleted: false,
    category: 'Study',
  ),
  Task(
    id: '1',
    name: 'Прибрати квартиру',
    description: 'Прибрати кімнату та ванну кімнату',
    finalDate: DateTime(2024, 5, 10, 18, 0),
    isCompleted: false,
    category: 'Study',
  ),
  Task(
    id: '1',
    name: 'Прибрати квартиру',
    description: 'Прибрати кімнату та ванну кімнату',
    finalDate: DateTime(2024, 5, 9, 18, 0),
    isCompleted: false,
    category: 'Study',
  ),
  Task(
    id: '2',
    name: 'Подивитися відеоурок Flutter',
    description: 'Подивитися відеоурок по створенню списків в Flutter',
    finalDate: DateTime(2024, 5, 6, 20, 0),
    isCompleted: true,
    category: 'Life',
  ),
  Task(
    id: '2',
    name: 'Подивитися відеоурок Flutter',
    description:
        'Подивитися відеоурок по створенню списків в Flutter Подивитися відеоурок по створенню списків в Flutter Подивитися відеоурок по створенню списків в Flutter Подивитися відеоурок по створенню списків в Flutter Подивитися відеоурок по створенню списків в Flutter',
    finalDate: DateTime(2024, 5, 6, 20, 0),
    isCompleted: false,
    category: 'Productive',
  ),
];
