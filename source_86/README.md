# Bài thực hành: Hiển thị danh sách khách hàng bằng JSTL

## Cấu trúc dự án

```
source_86/
├── README.md
└── jstl-customer-list/
    ├── pom.xml
    └── src/main/
        ├── java/com/codegym/
        │   ├── CustomerListServlet.java
        │   └── model/Customer.java
        └── webapp/
            ├── index.jsp
            ├── images/
            │   ├── customer-1.svg
            │   ├── customer-2.svg
            │   ├── customer-3.svg
            │   ├── customer-4.svg
            │   └── customer-5.svg
            └── WEB-INF/web.xml
```

## Yêu cầu
- JDK 17 trở lên
- Maven
- Apache Tomcat 10.1+
- JSTL 3.0 (được khai báo qua Maven dependencies)

## Chạy ứng dụng
Mở terminal tại thư mục `jstl-customer-list` và chạy:

```bash
mvn clean package
```

WAR được tạo tại `target/jstl-customer-list.war`. Sao chép file WAR vào thư mục `webapps` của Tomcat, khởi động Tomcat, rồi mở:

`http://localhost:8080/jstl-customer-list/`

## Cách hoạt động
- `CustomerListServlet` tạo danh sách khách hàng mẫu và đưa danh sách vào request attribute `customers`.
- `index.jsp` dùng JSTL Core Tags: `c:forEach` để lặp qua danh sách, `c:out` để hiển thị dữ liệu an toàn và `c:if` khi danh sách rỗng.
- Mỗi khách hàng có tên, ngày sinh, địa chỉ và ảnh minh họa SVG riêng.
- JSTL API và implementation được khai báo trong `pom.xml`; không cần tải JAR thủ công.
