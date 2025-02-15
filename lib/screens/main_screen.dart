import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_sevice.dart';

class MainScreen extends StatelessWidget {
  final TaskService _taskService = TaskService();

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager")),
      body: StreamBuilder<List<Task>>(
        stream: _taskService.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có công việc nào!"));
          }

          List<Task> tasks = snapshot.data!;

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];
              return ListTile(
                title: Text(task.title, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(task.description),
                trailing: Icon(task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: task.isCompleted ? Colors.green : Colors.grey),
                onTap: () {
                  _taskService.toggleTaskCompletion(task.id, task.isCompleted);
                },
                onLongPress: () {
                  _taskService.deleteTask(task.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
