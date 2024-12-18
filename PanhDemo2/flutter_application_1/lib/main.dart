import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LayoutExample(),
    );
  }
}

class LayoutExample extends StatelessWidget {
  const LayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Section
          Container(
            height: 150, // Chiều cao phần header
            color: Colors.blue, // Màu nền header
            alignment: Alignment.center,
            child: const Text(
              'Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Body Section
          Expanded(
            child: Container(
              color: Colors.green, // Màu nền body
              alignment: Alignment.center,
              child: const Text(
                'Body',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Footer Section
          Container(
            height: 100, // Chiều cao phần footer
            color: Colors.red, // Màu nền footer
            alignment: Alignment.center,
            child: const Text(
              'Footer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
