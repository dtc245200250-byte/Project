# Bài thực hành: Đăng nhập bằng JSP và Java Servlet

## Cấu trúc
```
source_80/
├── README.md
└── jsp-servlet-login/
    ├── pom.xml
    └── src/main/
        ├── java/com/codegym/LoginServlet.java
        └── webapp/
            ├── index.jsp
            └── WEB-INF/web.xml
```

## Yêu cầu
- Java 17+
- Maven
- Apache Tomcat 10.1+ (Jakarta Servlet 6)

## Đóng gói
Mở terminal tại thư mục `jsp-servlet-login` rồi chạy:

```bash
mvn clean package
```

Sau khi build thành công, WAR nằm ở `target/jsp-servlet-login.war`.

## Triển khai lên Tomcat
Sao chép file WAR vào thư mục `webapps` của Tomcat, khởi động Tomcat, sau đó mở:

`http://localhost:8080/jsp-servlet-login/`

## Kiểm thử
- Username: `admin`
- Password: `admin`
- Đúng: hiển thị `Welcome admin to website`
- Sai: hiển thị `Login Error`

Form gửi dữ liệu bằng phương thức POST đến `/login`. Servlet lấy dữ liệu bằng `request.getParameter()` và so sánh với thông tin đăng nhập được yêu cầu trong bài.

> Đây là bài thực hành nên thông tin đăng nhập được viết cố định theo đề bài; không dùng cách này cho hệ thống thực tế.
