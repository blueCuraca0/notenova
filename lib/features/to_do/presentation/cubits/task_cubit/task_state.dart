import 'package:notenova/features/to_do/domain/entities/task_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded(this.tasks);
}

class TaskSuccess extends TaskState {
  final String message;

  TaskSuccess(this.message);
}

class TaskError extends TaskState {
  final String errorMessage;

  TaskError(this.errorMessage);
}
