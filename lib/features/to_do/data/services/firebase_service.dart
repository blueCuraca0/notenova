import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';

class TaskFirestoreService {
  String get currentUserId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'default';

  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Stream<List<Task>> getTasks() {
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
      print(currentUserId);
    } catch (e) {
      print('$e');
    }
  }

  Future<void> updateTask(Task task) {
    return _tasksCollection.doc(task.id).update({
      'userId': currentUserId,
      'name': task.name,
      'isCompleted': task.isCompleted,
      'description': task.description,
      'category': task.category,
      'finalDate': task.finalDate,
    });
  }

  Future<void> deleteTask(String taskId) {
    return _tasksCollection.doc(taskId).delete();
  }
}
