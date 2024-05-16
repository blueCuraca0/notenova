import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/to_do/data/services/firebase_service.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';
import 'package:notenova/features/to_do/presentation/cubits/task_cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskFirestoreService _taskService;

  TaskCubit(this._taskService) : super(TaskInitial());

  Future<void> loadTasks() async {
    emit(TaskLoading());
    try {
      final tasks = await _taskService.getTasks().first;
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError('Failed to load tasks $e.'));
    }
  }

  Future<void> addTask(Task task) async {
    try {
      emit(TaskLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      await _taskService.addTask(task);
      emit(TaskLoading());
      loadTasks();
    } catch (e) {
      emit(TaskError('Failed to add task.'));
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      emit(TaskLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      await _taskService.updateTask(task);
      emit(TaskLoading());
      loadTasks();
    } catch (e) {
      emit(TaskError('Failed to update task.'));
    }
  }

  Future<void> updateTaskCheckBox(Task task) async {
    try {
      await _taskService.updateTask(task);
    } catch (e) {
      emit(TaskError('Failed to update task.'));
    }
  }

  Future<void> deleteTask(String task) async {
    try {
      emit(TaskLoading());
      await _taskService.deleteTask(task);
      emit(TaskLoading());
      loadTasks();
    } catch (e) {
      emit(TaskError('task to delete todo.'));
    }
  }
}
