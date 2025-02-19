import 'package:flutter/material.dart';
import '../services/note_service.dart';
import '../models/note.dart';
import '../services/task_sevice.dart';

class NotesPage extends StatelessWidget {
  final NoteService _noteService = NoteService();
  final TaskService _taskService = TaskService();

  NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            'Notes',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF87CEFA),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<List<Note>>(
        stream: _noteService.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No notes available.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          List<Note> notes = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                Note note = notes[index];

                return GestureDetector(
                  onTap: () => _editNote(context, note),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                note.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editNote(context, note),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _confirmDelete(context, note.id),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        FutureBuilder<String>(
                          future: _taskService.getTaskTitle(note.taskId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text(
                                "Loading...",
                                style: TextStyle(fontSize: 12, color: Colors.black38),
                              );
                            }
                            if (snapshot.hasError) {
                              return const Text(
                                "Error fetching task",
                                style: TextStyle(fontSize: 12, color: Colors.red),
                              );
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text(
                                "This task has been deleted",
                                style: TextStyle(fontSize: 12, color: Colors.black38),
                              );
                            }
                            return RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 12, color: Colors.black87),
                                children: [
                                  const TextSpan(text: 'For Task: '),
                                  TextSpan(
                                    text: '${snapshot.data}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            );

                          },
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            note.content,
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, String noteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Note"),
        content: const Text("Are you sure you want to delete this note?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _noteService.deleteNote(noteId);
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editNote(BuildContext context, Note note) {
    TextEditingController titleController = TextEditingController(text: note.title);
    TextEditingController contentController = TextEditingController(text: note.content);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Note"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: "Content"),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _noteService.updateNote(note.id, titleController.text, contentController.text);
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
