## Về các phần code:

### Class User:

1. Định nghĩa class User theo yêu cầu của đề bài bao gồm username, password và role.

2. Khởi tạo mảng các User thông qua "final List<User> users = ..."

### Class ForumDetailScreen:

1. Class ForumDetailScreen extends StatelessWidge: để tạo layout cho phần hiển thị thông tin của các user đã khởi tạo với GridView. Trong đó phần thông số của GridView:
   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
   crossAxisCount: 2, // điều chỉnh cột
   crossAxisSpacing: 8.0, // kc cột dọc
   mainAxisSpacing: 8.0, // kc cột ngang
   childAspectRatio: 3 / 2, // tỉ lệ 3/2 cho thẻ child
   ),

2. Phần thông tin để hiển thị các thông tin của object đã tạo:
   Text('Username: ${user.username}',),
   Text('Role: ${user.role}'),

- Tại đây có thể truy cập được tên của object thông qua các dot notation như bình thường.

### main.dart:

1. Class HomeScreen trong main.dart ban đầu được xây dựng với ý tưởng để gọi tới các ForumDetailScreen với ID tăng dần. Nhưng trong phần này em đã sửa đổi itemCount = 1 để chỉ hiển thị ra 1 phần duy nhất. tại trang chủ khi bấm vào "Cửa sổ hiển thị User 1" thì sẽ dẫn tới phần view của class ForumDetailScreen.
