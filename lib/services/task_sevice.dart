import 'package:cloud_firestore/cloud_firestore.dart';
import 'note_service.dart';
import '../models/task.dart';

enum SortOption { title, createdAt, isCompleted }

class TaskService {
  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('tasks');
  final CollectionReference _noteCollection =
      FirebaseFirestore.instance.collection('notes');
  final NoteService _noteService = NoteService();

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

  // sort by title(a)/ createdAt(b)
  List<Task> sortTasks(List<Task> tasks, SortOption option) {
    tasks.sort((a, b) {
      if (option == SortOption.title) {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      } else if (option == SortOption.createdAt) {
        return b.createdAt.compareTo(a.createdAt);
      } else {
        return a.isCompleted == b.isCompleted ? 0 : (a.isCompleted ? 1 : -1);
      }
    });
    return tasks;
  }

  // get task title
  Future<String> getTaskTitle(String taskId) async {
    try {
      DocumentSnapshot doc = await _taskCollection.doc(taskId).get();
      if (doc.exists) {
        return doc['title'];
      } else {
        await _noteService.delNoteWithTaskID(taskId);
        return "This task has been deleted";
      }
    } catch (e) {
      return "Error loading title";
    }
  }

}
