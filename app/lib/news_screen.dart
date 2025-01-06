import 'package:flutter/material.dart';

class User {
  final String username;
  final String password;
  final String role;

  User({
    required this.username,
    required this.password,
    required this.role,
  });
}

class UserGridScreen extends StatelessWidget {
  const UserGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<User> users = [
      User(username: 'Khai', password: 'pass1', role: 'admin'),
      User(username: 'user2', password: 'pass2', role: 'editor'),
      User(username: 'user3', password: 'pass3', role: 'viewer'),
      User(username: 'user4', password: 'pass4', role: 'editor'),
      User(username: 'user5', password: 'pass5', role: 'admin'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách người dùng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số cột trong GridView
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.0, // Tỉ lệ giữa chiều ngang và chiều dọc
          ),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username: ${user.username}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Password: ${user.password}'),
                    const SizedBox(height: 8),
                    Text('Role: ${user.role}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: UserGridScreen(),
  ));
}
