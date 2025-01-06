## Đề bài

### Câu 1: (Cấp độ CĐR 1.1 – 3 điểm)
Viết lớp (class) có tên `User` bằng ngôn ngữ Dart gồm thông tin sau:
- `username`
- `password`
- `role`

### Câu 2: (Cấp độ CĐR 1.2 và 2.1 – 7 điểm)
1. Nhập vào 5 bản ghi thông tin người dùng. (3 điểm)
2. Hiển thị trên Mobile App 05 bản ghi người dùng theo dạng `GridView`. (4 điểm)

## Hướng dẫn thực hiện

### Câu 1: Tạo lớp `User`
- Lớp `User` được định nghĩa với ba thuộc tính:
  - `username`: Tên đăng nhập của người dùng.
  - `password`: Mật khẩu của người dùng.
  - `role`: Vai trò của người dùng.
- Lớp sử dụng tính năng `required` trong Dart để đảm bảo giá trị của các thuộc tính bắt buộc khi tạo đối tượng.

### Câu 2: Hiển thị thông tin người dùng
- Danh sách 5 người dùng được tạo thủ công dưới dạng danh sách (`List`) trong mã nguồn.
- Giao diện người dùng:
  - Sử dụng `GridView.builder` để hiển thị danh sách người dùng theo dạng lưới.
  - Mỗi phần tử trong lưới là một `Card` hiển thị thông tin chi tiết của người dùng, bao gồm: `username`, `password`, và `role`.
  - Sử dụng `SliverGridDelegateWithFixedCrossAxisCount` để định cấu trúc lưới, với 2 cột và khoảng cách giữa các phần tử.

## Mô tả tệp nguồn

### `main.dart`
Chứa toàn bộ mã nguồn cho ứng dụng. Các phần chính bao gồm:
1. **Lớp `User`**: Mô tả thông tin người dùng.
2. **Màn hình `UserGridScreen`**:
   - Hiển thị danh sách người dùng dạng lưới.
   - Sử dụng `GridView.builder` để tạo giao diện động từ danh sách người dùng.
3. **Hàm `main()`**: Điểm bắt đầu của ứng dụng, khởi chạy màn hình `UserGridScreen`.

## Hướng dẫn chạy ứng dụng

1. **Cài đặt môi trường**:
   - Đảm bảo đã cài đặt Flutter trên máy.
   - Chạy lệnh `flutter doctor` để kiểm tra cấu hình.

2. **Chạy ứng dụng**:
   - Tải mã nguồn vào thư mục dự án Flutter.
   - Chạy lệnh `flutter run` để khởi động ứng dụng trên thiết bị giả lập hoặc thực.

## Kết quả mong đợi

- Ứng dụng hiển thị danh sách 5 người dùng dưới dạng lưới (`GridView`).
- Mỗi người dùng được hiển thị trên một `Card` với thông tin:
  - `Username`
  - `Password`
  - `Role`


