import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String taskId;
  String title;
  String content;
  Timestamp createdAt;

  Note({
    required this.id,
    required this.taskId,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  // convert Firestore document -> Note object
  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      taskId: data['taskId'] ?? '',
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  // convert Note object -> Map -> save to Firestore
  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'title': title,
      'content': content,
      'createdAt': createdAt,
    };
  }
}
