# User Management MVC + JDBC

Bài thực hành quản lý User bằng Java Web (JSP/Servlet), JDBC và MySQL, có thêm tìm kiếm theo country và sắp xếp theo name.

## Chức năng
- Hiển thị danh sách User từ MySQL.
- Thêm mới, sửa và xóa User.
- Tìm kiếm theo quốc gia bằng từ khóa (khớp một phần, không phân biệt hoa/thường theo collation MySQL).
- Sắp xếp tên tăng dần (A–Z) hoặc giảm dần (Z–A).
- Dùng PreparedStatement cho các giá trị truy vấn.

## 1. Khởi tạo database
Mở MySQL Workbench hoặc DBeaver và chạy `database.sql` ở thư mục này.

## 2. Cấu hình kết nối MySQL
Giá trị mặc định:
- URL: `jdbc:mysql://localhost:3306/demo?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true`
- Username: `root`
- Password: `password`

Nên đặt biến môi trường `DB_URL`, `DB_USERNAME`, `DB_PASSWORD` để khớp thiết lập MySQL của bạn. Không lưu mật khẩu thật vào GitHub.

## 3. Build
Yêu cầu JDK 17+, Maven và Apache Tomcat 10.1+.

Mở terminal trong thư mục `user-management` rồi chạy:

```bash
mvn clean package
```

WAR được tạo tại `target/user-management.war`. Sao chép WAR vào thư mục `webapps` của Tomcat rồi khởi động server.

Mở ứng dụng tại:
`http://localhost:8080/user-management/users`

## Cấu trúc
- `model/User.java`: dữ liệu User.
- `dao/IUserDAO.java` và `dao/UserDAO.java`: các thao tác JDBC/CRUD và truy vấn tìm kiếm/sắp xếp.
- `controller/UserServlet.java`: điều phối action.
- `user/*.jsp`: danh sách, tạo, sửa, xác nhận xóa.
- `database.sql`: tạo database và dữ liệu mẫu.

Dữ liệu được lưu trong MySQL nên vẫn còn sau khi restart ứng dụng.
