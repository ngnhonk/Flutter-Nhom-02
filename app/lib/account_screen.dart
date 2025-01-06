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

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<User> users = [
      User(username: 'user1', password: 'pass1', role: 'admin'),
      User(username: 'user2', password: 'pass2', role: 'editor'),
      User(username: 'user3', password: 'pass3', role: 'viewer'),
      User(username: 'user4', password: 'pass4', role: 'editor'),
      User(username: 'user5', password: 'pass5', role: 'admin'),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 50, color: Colors.blueAccent),
                  const SizedBox(height: 8),
                  Text(
                    user.username,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Password: ${user.password}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Role: ${user.role}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
