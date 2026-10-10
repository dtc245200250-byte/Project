# Bài thực hành: Từ điển Anh - Việt bằng JSP/Servlet

## Cấu trúc dự án

```
source_82/
├── README.md
└── jsp-servlet-dictionary/
    ├── pom.xml
    └── src/main/
        ├── java/com/codegym/DictionaryServlet.java
        └── webapp/
            ├── index.jsp
            └── WEB-INF/web.xml
```

## Yêu cầu
- JDK 17 trở lên
- Maven
- Apache Tomcat 10.1+ (Jakarta Servlet 6)

## Đóng gói
Mở terminal tại thư mục `jsp-servlet-dictionary` rồi chạy:

```bash
mvn clean package
```

Sau khi build thành công, file WAR nằm tại `target/jsp-servlet-dictionary.war`.

## Triển khai và kiểm thử
Sao chép file WAR vào thư mục `webapps` của Tomcat, khởi động Tomcat rồi mở:

`http://localhost:8080/jsp-servlet-dictionary/`

Nhập thử các từ `hello`, `book`, `computer`, `student`, `how`, `apple`, `thank you` hoặc `school`. Tra cứu không phân biệt chữ hoa/chữ thường. Nếu từ không nằm trong Map, ứng dụng hiển thị thông báo `Không tìm thấy từ: [từ_khóa]`.

Form sử dụng POST đến `/translate`; `DictionaryServlet` đọc tham số `word`, tra cứu trong Map và trả về nghĩa tiếng Việt. Danh sách từ vựng hiện được lưu cố định trong mã nguồn để phù hợp với bài thực hành.
