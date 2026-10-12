# iNotes — Strategy Pattern

Ứng dụng web quản lý ghi chú cá nhân bằng Java 17, JSP/Servlet Jakarta, MySQL/JDBC và Strategy Pattern. Người dùng có thể chuyển nguồn lưu trữ giữa MySQL và file văn bản ngay trên giao diện mà không thay đổi phần nghiệp vụ.

## Chức năng
- Tạo, xem, sửa, xóa ghi chú.
- Tìm kiếm theo tiêu đề hoặc nội dung.
- Phân loại ghi chú: Cá nhân, Công việc, Học tập.
- Chuyển chế độ lưu trữ **MySQL** hoặc **File TXT** lúc chạy.
- Cả hai chiến lược cùng triển khai `NoteStrategy`; lớp `NoteManagement` không phụ thuộc cụ thể vào cơ chế lưu.

## 1. Cấu trúc
- `inotes/src/main/java/com/codegym/inotes/model`: `Note`, `NoteType`.
- `.../strategy/NoteStrategy.java`: hợp đồng chung cho lưu/xóa/liệt kê/tìm kiếm.
- `.../strategy/NoteDBStrategy.java`: JDBC/MySQL.
- `.../strategy/NoteFileStrategy.java`: file UTF-8, định dạng mỗi dòng `id|title|content|typeId` (các ký tự `|`, dấu gạch chéo và xuống dòng được escape).
- `.../service/NoteManagement.java`: nghiệp vụ ghi chú và thay đổi Strategy runtime.
- `.../controller/NoteServlet.java`: điều phối request MVC.
- `.../webapp/note/*.jsp`: dashboard và form.

## 2. MySQL
Chạy file `database.sql` trong MySQL Workbench hoặc DBeaver. Script tạo `inotes_db`, hai bảng `note_type` và `notes`, cùng 3 loại ghi chú mẫu.

Cấu hình kết nối bằng biến môi trường:
- `INOTES_DB_URL` (mặc định `jdbc:mysql://localhost:3306/inotes_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true`)
- `INOTES_DB_USERNAME` (mặc định `root`)
- `INOTES_DB_PASSWORD` (mặc định `password`)

File strategy lưu ở `%USERPROFILE%/iNotes-notes.txt` trên Windows hoặc `$HOME/iNotes-notes.txt` trên macOS/Linux theo mặc định. Có thể đổi bằng biến môi trường `INOTES_FILE_PATH`.

## 3. Build và chạy
Yêu cầu JDK 17+, Maven, MySQL (chỉ cần khi dùng chiến lược MySQL) và Tomcat 10.1+.

Trong thư mục `inotes`:
```bash
mvn clean package
```

Copy `target/inotes.war` vào thư mục `webapps` của Tomcat và khởi động. Truy cập:
`http://localhost:8080/inotes/notes`

Trong thanh điều khiển ở dashboard, chọn **MySQL** hoặc **File TXT** rồi nhấn “Áp dụng”. Mỗi chế độ lưu một tập dữ liệu riêng: đổi chế độ không tự di chuyển dữ liệu giữa MySQL và file.

## Ghi chú bảo mật
Đặt mật khẩu MySQL bằng biến môi trường thay vì ghi mật khẩu thật vào GitHub. Khi chạy ở chế độ File, ứng dụng cần quyền đọc/ghi file tại đường dẫn `INOTES_FILE_PATH`.
