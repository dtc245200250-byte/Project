# User Management — MySQL Stored Procedures + JDBC

Bài thực hành chuyển chức năng tìm User theo ID và thêm User sang MySQL Stored Procedures, gọi từ Java bằng CallableStatement.

## Công nghệ
- Java 17, Maven WAR, Jakarta Servlet 6 (Tomcat 10.1+)
- MySQL 8+, JDBC / MySQL Connector/J
- JSP + JSTL

## 1. Tạo database
Chạy toàn bộ file database/schema.sql bằng MySQL Workbench hoặc DBeaver. Script tạo database demo, bảng users và hai procedures get_user_by_id / insert_user.

## 2. Cấu hình kết nối
Thiết lập biến môi trường trước khi chạy Tomcat:
- DB_URL (mặc định jdbc:mysql://localhost:3306/demo?useSSL=false&serverTimezone=Asia/Ho_Chi_Minh)
- DB_USER (mặc định root)
- DB_PASSWORD (mặc định rỗng — hãy đặt mật khẩu của bạn)

Không đưa mật khẩu thật lên GitHub.

## 3. Build
Tại thư mục source_35:
```bash
mvn clean package
```
WAR tạo tại target/user-management.war.

## 4. Deploy
Dùng Tomcat 10.1+ (dự án dùng Jakarta Servlet). Sao chép WAR vào TOMCAT_HOME/webapps/, khởi động Tomcat và mở:
http://localhost:8080/user-management/users

## 5. Kiểm thử
- Nhấn Thêm User, nhập tên/email/quốc gia rồi lưu.
- Nhấn Edit để tải User theo ID. Chức năng này gọi get_user_by_id(?) bằng CallableStatement.
- Chức năng thêm gọi insert_user(?, ?, ?) bằng CallableStatement.
- Danh sách, sửa và xóa tiếp tục dùng DAO/JDBC thông thường.

Ghi chú: Mã nguồn được lưu trên GitHub. Cần chạy build và triển khai trên máy có JDK, Maven, MySQL và Tomcat để xác nhận hoạt động thực tế.
