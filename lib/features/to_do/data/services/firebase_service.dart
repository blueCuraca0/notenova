import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';

class TaskFirestoreService {
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Stream<List<Task>> getTasks() {
    // _tasksCollection.where('user_id', isEqualTo: userId)
    //                      .snapshots()
    //                      .map((snapshot)
    return _tasksCollection.snapshots().map((snapshot) {
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

  Future<void> addTask(Task task) {
    return _tasksCollection.add({
      'name': task.name,
      'isCompleted': task.isCompleted,
      'description': task.description,
      'category': task.category,
      'finalDate': task.finalDate,
    });
  }

  Future<void> updateTask(Task task) {
    return _tasksCollection.doc(task.id).update({
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
