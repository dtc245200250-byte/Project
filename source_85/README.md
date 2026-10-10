# JSP Pure Dictionary — Từ điển Anh - Việt

## Cấu trúc dự án

```
source_85/
├── README.md
└── jsp-pure-dictionary/
    ├── pom.xml
    └── src/main/webapp/
        ├── index.jsp
        ├── dictionary.jsp
        └── WEB-INF/web.xml
```

## Yêu cầu
- JDK 17 trở lên
- Maven
- Apache Tomcat 10.1+ (Jakarta Servlet 6)

## Đóng gói
Mở terminal tại thư mục `jsp-pure-dictionary` và chạy:

```bash
mvn clean package
```

File WAR được tạo tại `target/jsp-pure-dictionary.war`.

## Triển khai
Sao chép file WAR vào thư mục `webapps` của Tomcat, khởi động server rồi truy cập:

`http://localhost:8080/jsp-pure-dictionary/`

## Cách hoạt động
- `index.jsp` cung cấp form nhập từ với trường `search`; form sử dụng POST đến `dictionary.jsp`.
- `dictionary.jsp` khởi tạo từ điển trong một `Map<String, String>` bằng JSP Scriptlet, đọc từ khóa, chuẩn hóa chữ thường và tìm nghĩa.
- JSP Expression (`<%= %>`) hiển thị từ đã tìm và nghĩa tiếng Việt. Từ không tồn tại sẽ cho thông báo không tìm thấy.
- Ví dụ: `hello` → `Xin chào`, `book` → `Quyển sách`, `computer` → `Máy tính`. Tra cứu không phân biệt chữ hoa/chữ thường.

Ứng dụng dùng JSP Scriptlet/Expression đúng theo mục tiêu bài thực hành, không có Java Servlet riêng.
