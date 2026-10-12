# Product Management - JSP / Servlet / JDBC / MySQL

Bài kiểm tra cuối module: quản lý sản phẩm bằng Java 17, Maven, Jakarta Servlet 6, JSP và MySQL. Yêu cầu Apache Tomcat 10.1+.

## Cấu hình
1. Chạy `database/product_management.sql` trong MySQL Workbench.
2. Sửa tài khoản và mật khẩu MySQL trong `src/main/java/com/finalexam/util/DBConnection.java`.
3. Chạy `mvn clean package`.
4. Deploy `target/ProductManagement.war` lên Tomcat 10.1+.
5. Mở `/ProductManagement/products`.

Chức năng: xem, thêm, sửa, xóa sản phẩm. Xóa có xác nhận; DAO dùng PreparedStatement.