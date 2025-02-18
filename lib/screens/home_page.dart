import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/note.dart';
import '../models/task.dart';
import '../services/note_service.dart';
import '../services/task_sevice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskService _taskService = TaskService();
  SortOption _sortOption = SortOption.createdAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          decoration: BoxDecoration(
            color: Color(0xFF87CEFA),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Text(
                  "Tasks",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Sort by: ", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 8),
                    DropdownButton<SortOption>(
                      value: _sortOption,
                      items: [
                        DropdownMenuItem(
                          value: SortOption.title,
                          child: Text("Title"),
                        ),
                        DropdownMenuItem(
                          value: SortOption.createdAt,
                          child: Text("Created"),
                        ),
                        DropdownMenuItem(
                          value: SortOption.isCompleted,
                          child: Text("Status"),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _sortOption = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: StreamBuilder<List<Task>>(
              stream: _taskService.getTasks(),
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
                      "No tasks yet. Let's add one!",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  );
                }
                List<Task> tasks = snapshot.data!;
                tasks = _taskService.sortTasks(tasks, _sortOption);

                return ListView.builder(
                  itemCount: tasks.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: () => _createNewTask(context, _taskService),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add, color: Colors.blueAccent),
                              SizedBox(width: 10),
                              Text("Create New Task",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueAccent)),
                            ],
                          ),
                        ),
                      );
                    }

                    Task task = tasks[index - 1];

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color:
                                task.isCompleted ? Colors.grey : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          task.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.note_add),
                              onPressed: () => _createNewNote(context, task.id),
                            ),

                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blueAccent),
                              onPressed: () => _editTask(context, task),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => _taskService.deleteTask(task.id),
                            ),
                            GestureDetector(
                              onTap: () => _taskService.toggleTaskCompletion(
                                  task.id, task.isCompleted),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  task.isCompleted
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: task.isCompleted
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------- create task --------------------------
  void _createNewTask(BuildContext context, TaskService taskService) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Title"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String title = titleController.text.trim();
                String description = descriptionController.text.trim();

                if (title.isNotEmpty && description.isNotEmpty) {
                  Task newTask = Task(
                    id: UniqueKey().toString(),
                    title: title,
                    description: description,
                    isCompleted: false,
                    createdAt: Timestamp.now(),
                    updatedAt: Timestamp.now(),
                  );

                  await taskService.addTask(newTask);
                }

                Navigator.of(context).pop();
              },
              child: Text("Create"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  // -------------------------- edit task --------------------------
  void _editTask(BuildContext context, Task task) {
    TextEditingController titleController =
        TextEditingController(text: task.title);
    TextEditingController descriptionController =
        TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await _taskService.updateTask(
                  task.id,
                  titleController.text,
                  descriptionController.text,
                );

                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // -------------------------- new note --------------------------

  void _createNewNote(BuildContext context, String taskId) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add new note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: "Content"),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Hủy"),
            ),
            TextButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  await NoteService().addNote(Note(
                    id: "",
                    taskId: taskId,
                    title: titleController.text,
                    content: contentController.text,
                    createdAt: Timestamp.now(),
                  ));
                  Navigator.pop(context);
                }
              },
              child: Text("Lưu"),
            ),
          ],
        );
      },
    );
  }

}
