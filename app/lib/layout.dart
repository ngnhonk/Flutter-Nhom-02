import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const LayoutScreen(),
//     );
//   }
// }

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row and Column Layout'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phần bên trái: Column
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề
                  const Text(
                    'Khóa học C/C++',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Đoạn mô tả
                  const Text(
                    'Học môn C/C++ với thầy Vinh là một trải nghiệm đáng nhớ và đầy giá trị. Phong cách giảng dạy của thầy rất logic, dễ hiểu và bám sát các vấn đề thực tế, giúp sinh viên không chỉ nắm chắc lý thuyết mà còn áp dụng hiệu quả vào thực hành.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  // Đánh giá
                  Row(
                    children: [
                      // Số sao
                      Row(
                        children: List.generate(5, (index) {
                          return const Icon(Icons.star,
                              color: Colors.red, size: 16);
                        }),
                      ),
                      const SizedBox(width: 8),
                      // Số lượng đánh giá
                      const Text(
                        '172 Reviews',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Thông tin thêm
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Thời gian đăng bài
                      Column(
                        children: const [
                          Icon(Icons.access_time, color: Colors.green),
                          SizedBox(
                            height:
                                4, // Nếu cần thêm khoảng cách, có thể chỉnh giá trị `height`.
                          ),
                          Text(
                            '23 hours ago',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                      // Ngày đăng
                      Column(
                        children: const [
                          Icon(Icons.access_time_filled, color: Colors.green),
                          Text(
                            '13/01/2025',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                      // Số người xem
                      Column(
                        children: const [
                          Icon(Icons.person, color: Colors.green),
                          Text(
                            '571',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Phần bên phải: Hình ảnh
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/anh.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
