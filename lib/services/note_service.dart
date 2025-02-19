import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class NoteService {
  final CollectionReference _noteCollection =
      FirebaseFirestore.instance.collection('notes');

  // get notes by taskId
  Stream<List<Note>> getNotesByTask(String taskId) {
    return _noteCollection
        .where('taskId', isEqualTo: taskId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList());
  }

  // get all notes
  Stream<List<Note>> getNotes() {
    return _noteCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
    });
  }

  // add a note
  Future<void> addNote(Note note) async {
    await _noteCollection.add(note.toMap());
  }

  // update a note
  Future<void> updateNote(String id, String newTitle, String newContent) async {
    await _noteCollection.doc(id).update({
      'title': newTitle,
      'content': newContent,
    });
  }

  // delete a note
  Future<void> deleteNote(String id) async {
    await _noteCollection.doc(id).delete();
  }

  // delete a note have notes.taskId == task.id;
  Future<void> delNoteWithTaskID(String id) async {
    QuerySnapshot querySnapshot =
        await _noteCollection.where('taskId', isEqualTo: id).get();

    for (var doc in querySnapshot.docs) {
      await _noteCollection.doc(doc.id).delete();
    }
  }
}
