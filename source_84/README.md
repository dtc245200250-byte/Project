# JSP Currency Converter

## Cấu trúc dự án

```
source_84/
├── README.md
└── jsp-currency-converter/
    ├── pom.xml
    └── src/main/webapp/
        ├── index.jsp
        ├── converter.jsp
        └── WEB-INF/web.xml
```

## Yêu cầu
- JDK 17 trở lên
- Maven
- Apache Tomcat 10.1+ (Jakarta Servlet 6)

## Đóng gói
Mở terminal tại thư mục `jsp-currency-converter` rồi chạy:

```bash
mvn clean package
```

File WAR sau khi đóng gói nằm ở `target/jsp-currency-converter.war`.

## Chạy trên Tomcat
Sao chép file WAR vào thư mục `webapps` của Tomcat và khởi động server. Truy cập:

`http://localhost:8080/jsp-currency-converter/`

## Cách hoạt động
- `index.jsp` hiển thị form nhập `rate` và `usd`; form gửi bằng POST đến `converter.jsp`.
- `converter.jsp` dùng JSP Scriptlet (`<% %>`) đọc và kiểm tra dữ liệu, tính `VND = USD × Rate`, rồi dùng JSP Expression (`<%= %>`) để hiển thị kết quả.
- Giá trị tỉ giá phải lớn hơn 0; lượng USD không được âm. Dữ liệu không hợp lệ sẽ được hiển thị thành thông báo lỗi.

Ví dụ: tỉ giá `25000`, lượng USD `100` → `2,500,000.00 VNĐ`.
