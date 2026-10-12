# User Management — Stored Procedures + JDBC

Bài thực hành Java Web quản lý User theo mô hình MVC, sử dụng JSP/Servlet, MySQL và JDBC. Hai chức năng được chuyển sang Stored Procedures gọi qua `CallableStatement`:
- Lấy User theo ID bằng `get_user_by_id` khi mở trang sửa.
- Thêm User bằng `insert_user` khi gửi form thêm mới.

Các chức năng khác vẫn được giữ lại: danh sách, sửa, xóa, tìm theo country và sắp xếp theo name.

## 1. Khởi tạo database và stored procedures
Trong MySQL Workbench hoặc DBeaver, chạy lần lượt:
1. `database.sql` — tạo database `demo`, bảng `users` và dữ liệu mẫu.
2. `stored_procedures.sql` — tạo `get_user_by_id` và `insert_user`.

File stored procedure có `DROP PROCEDURE IF EXISTS`, vì vậy có thể chạy lại khi cập nhật thủ tục.

## 2. Cấu hình kết nối MySQL
Mặc định:
- URL: `jdbc:mysql://localhost:3306/demo?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true`
- Username: `root`
- Password: `password`

Đổi cấu hình bằng biến môi trường `DB_URL`, `DB_USERNAME`, `DB_PASSWORD`. Không commit mật khẩu MySQL thật lên GitHub.

## 3. Build và chạy
Yêu cầu JDK 17+, Maven và Tomcat 10.1+.

Mở terminal tại thư mục `user-management`:
```bash
mvn clean package
```

Copy `target/user-management.war` vào thư mục `webapps` của Tomcat rồi khởi động Tomcat. Mở:
`http://localhost:8080/user-management/users`

## 4. Nội dung luyện tập
- `IUserDAO`: khai báo các thao tác truy cập dữ liệu.
- `UserDAO`: JDBC CRUD, tìm kiếm/sắp xếp và hai lời gọi `CallableStatement`.
- `UserServlet`: điều phối request và chuyển sang JSP.
- `user/*.jsp`: giao diện danh sách, thêm, sửa và xác nhận xóa.

Lưu ý: code đã được tải lên GitHub và kiểm tra file/logic ở mức tĩnh; cần chạy SQL trên MySQL và build/deploy tại máy bạn để kiểm thử môi trường thực tế.
