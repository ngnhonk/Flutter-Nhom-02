# Nhóm 02
## Thành viên của nhóm:
1. Nguyễn Thị Phương Anh - 22010079
2. Nguyễn Việt Hùng - 22010323
3. Phạm Quang Khải - 22010028
4. Giảng viên hướng dẫn : cô Nguyễn Lệ Thu

# Dự án: Ứng dụng quản lý công việc Task Manager

## Giới thiệu
Task Manager là một ứng dụng quản lý công việc đơn giản, giúp người dùng tạo, chỉnh sửa, xóa và theo dõi các nhiệm vụ hàng ngày. Ứng dụng hỗ trợ phân loại công việc và ghi chú nhanh bằng Sticky Notes.

## Tính năng chính
- **Tạo công việc mới**: Người dùng có thể nhập tên công việc, mô tả chi tiết, thời gian thực hiện và thêm công việc vào danh sách quản lý.
- **Chỉnh sửa công việc**: Người dùng có thể cập nhật thông tin công việc bất cứ lúc nào để đảm bảo thông tin chính xác.
- **Xóa công việc**: Khi một công việc không còn cần thiết, người dùng có thể xóa khỏi danh sách.
- **Đánh dấu hoàn thành**: Người dùng có thể đánh dấu công việc đã hoàn thành bằng cách nhấn vào biểu tượng ✅.
- **Phân loại công việc theo danh mục**: Người dùng có thể tạo và quản lý danh mục công việc (Ví dụ: Cá nhân, Công việc, Học tập) giúp sắp xếp và ưu tiên nhiệm vụ hợp lý hơn.
- **Ghi chú nhanh**: Cung cấp không gian để lưu trữ những thông tin quan trọng, ý tưởng nhanh mà không cần tạo công việc chi tiết.
- **Lưu trữ và truy xuất dữ liệu bằng Firebase**: Dữ liệu công việc và ghi chú được lưu trữ trên Firebase Firestore, giúp người dùng truy cập mọi lúc, mọi nơi.
- **Giao diện thân thiện, dễ sử dụng**: Ứng dụng được thiết kế trực quan, giúp người dùng thao tác dễ dàng trên thiết bị di động và máy tính bảng.

## Structural Diagram 

## Công nghệ sử dụng
- Ngôn ngữ lập trình: Dart
- Framework: Flutter
- Cơ sở dữ liệu: Firebase Firestore

## Hướng dẫn cài đặt
1. Clone repository
   ```sh
   git clone https://github.com/ngnhonk/Nhom-02.git
   ```
2. Cài đặt dependencies
   ```sh
   npm install
   ```
3. Cấu hình Firebase
   - Tạo một dự án Firebase.
   - Kích hoạt Firestore Database.
   - Lấy thông tin cấu hình và thêm vào file `.env`:
   ```env
   REACT_APP_FIREBASE_API_KEY=your_api_key
   REACT_APP_FIREBASE_AUTH_DOMAIN=your_auth_domain
   REACT_APP_FIREBASE_PROJECT_ID=your_project_id
   REACT_APP_FIREBASE_STORAGE_BUCKET=your_storage_bucket
   REACT_APP_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
   REACT_APP_FIREBASE_APP_ID=your_app_id
   ```
4. **Chạy ứng dụng**
   ```sh
   npm start
   ```

## Giao diện App 
thêm giao diện 
## Hướng dẫn sử dụng
- **Thêm công việc mới**: Nhấn "Create New Task" và nhập thông tin.
- **Chỉnh sửa công việc**: Nhấn biểu tượng ✏️ bên cạnh công việc.
- **Xóa công việc**: Nhấn biểu tượng 🗑️ để xóa.
- **Hoàn thành công việc**: Nhấn vào biểu tượng ✅ để đánh dấu hoàn thành.
- **Phân loại công việc**: Chọn danh mục khi tạo/chỉnh sửa công việc.
- **Sticky Notes**: Thêm các ghi chú nhanh từ giao diện chính.

## Hạn chế và đề xuất cải thiện
- Thiếu chức năng nhắc nhở: Có thể thêm thông báo nhắc nhở cho công việc sắp đến hạn.
- Chưa có chế độ đồng bộ thời gian thực: Hiện tại, dữ liệu chỉ cập nhật khi tải lại trang hoặc có hành động thêm/sửa/xóa. Có thể sử dụng Firebase Realtime Database để cải thiện.
- Thiếu hỗ trợ đa người dùng: Hiện tại, ứng dụng chỉ phục vụ một người dùng. Nếu muốn mở rộng, có thể thêm chức năng đăng nhập và lưu công việc theo từng tài khoản.


