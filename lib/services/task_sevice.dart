import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class TaskService {
  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  // get task list
  Stream<List<Task>> getTasks() {
    return _taskCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
    });
  }

  // create a new task
  Future<void> addTask(Task task) async {
    await _taskCollection.add(task.toMap());
  }

  // update task
  Future<void> updateTask(
      String id, String newTitle, String newDescription) async {
    await _taskCollection.doc(id).update({
      'title': newTitle,
      'description': newDescription,
      'updatedAt': Timestamp.now(),
    });
  }

  // update task status
  Future<void> toggleTaskCompletion(String id, bool currentStatus) async {
    await _taskCollection.doc(id).update({
      'isCompleted': !currentStatus,
      'updatedAt': Timestamp.now(),
    });
  }

  // delete a task
  Future<void> deleteTask(String id) async {
    await _taskCollection.doc(id).delete();
  }
}
