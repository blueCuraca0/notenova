import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';

class TaskFirestoreService {
  String get currentUserId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'default';

  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Stream<List<Task>> getTasks() {
    try {
      return _tasksCollection
          .where('userId', isEqualTo: currentUserId)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Task(
            id: doc.id,
            name: data['name'],
            isCompleted: data['isCompleted'],
            finalDate: data['finalDate'].toDate(),
            description: data['description'],
            category: data['category'],
          );
        }).toList();
      });
    } catch (e) {
      debugPrint('Error fetching tasks: $e');
      rethrow;
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _tasksCollection.add({
        'userId': currentUserId,
        'name': task.name,
        'isCompleted': task.isCompleted,
        'description': task.description,
        'category': task.category,
        'finalDate': task.finalDate,
      });
    } catch (e) {
      debugPrint('Error adding task: $e');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _tasksCollection.doc(task.id).update({
        'userId': currentUserId,
        'name': task.name,
        'isCompleted': task.isCompleted,
        'description': task.description,
        'category': task.category,
        'finalDate': task.finalDate,
      });
    } catch (e) {
      debugPrint('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
    } catch (e) {
      debugPrint('Error deleting task: $e');
    }
  }
}
