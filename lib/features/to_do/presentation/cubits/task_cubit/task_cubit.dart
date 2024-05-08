import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/to_do/data/services/firebase_service.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';
import 'package:notenova/features/to_do/presentation/cubits/task_cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskFirestoreService _firestoreService;

  TaskCubit(this._firestoreService) : super(TaskInitial());

  Future<void> loadTasks() async {
    try {
      emit(TaskLoading());
      final tasks = await _firestoreService.getTasks().first;
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError('Failed to load tasks $e.'));
    }
  }

  Future<void> addTask(Task task) async {
    try {
      emit(TaskLoading());
      await _firestoreService.addTask(task);
      emit(TaskSuccess('task added successfully.'));
    } catch (e) {
      emit(TaskError('Failed to add task.'));
    }

    final tasks = await _firestoreService.getTasks().first;
    emit(TaskLoaded(tasks));
  }

  Future<void> updateTask(Task task) async {
    emit(TaskLoading());
    try {
      await _firestoreService.updateTask(task);

      emit(TaskSuccess('Task updated successfully.'));
    } catch (e) {
      emit(TaskError('Failed to update task.'));
    }

    final tasks = await _firestoreService.getTasks().first;
    emit(TaskLoaded(tasks));
  }

  Future<void> deleteTask(String task) async {
    try {
      emit(TaskLoading());
      await _firestoreService.deleteTask(task);
      emit(TaskSuccess('task deleted successfully.'));
    } catch (e) {
      emit(TaskError('task to delete todo.'));
    }
  }
}
