// import 'package:app/main.dart';
import 'package:flutter/material.dart';

class User {
  String username;
  String password;
  String role;

  User(this.username, this.password, this.role);
}

final List<User> users = [
  User('Viet Hung', 'pass1', 'Admin'),
  User('user2', 'pass2', 'User'),
  User('user3', 'pass3', 'User'),
  User('user4', 'pass4', 'User'),
  User('user5', 'pass5', 'Guest'),
];

class ForumDetailScreen extends StatelessWidget {
  final int forumId;

  const ForumDetailScreen({super.key, required this.forumId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView hiển thị User $forumId:'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 3 / 2,
          ),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 40,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Username: ${user.username}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
