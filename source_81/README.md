# Bài thực hành: Chuyển đổi USD sang VNĐ bằng Servlet

## Cấu trúc dự án

```
source_81/
├── README.md
└── jsp-servlet-currency-converter/
    ├── pom.xml
    └── src/main/
        ├── java/com/codegym/ConverterServlet.java
        └── webapp/
            ├── index.jsp
            └── WEB-INF/web.xml
```

## Yêu cầu
- JDK 17 trở lên
- Maven
- Apache Tomcat 10.1+ (Jakarta Servlet 6)

## Đóng gói
Mở terminal trong thư mục `jsp-servlet-currency-converter` và chạy:

```bash
mvn clean package
```

File WAR được tạo tại `target/jsp-servlet-currency-converter.war`.

## Chạy trên Tomcat
Sao chép file WAR vào thư mục `webapps` của Tomcat và khởi động máy chủ. Truy cập:

`http://localhost:8080/jsp-servlet-currency-converter/`

## Cách kiểm thử
1. Nhập tỉ giá, ví dụ `25000` VNĐ/USD.
2. Nhập lượng USD cần đổi, ví dụ `100`.
3. Nhấn **Chuyển đổi ngay**.
4. Với ví dụ trên, kết quả là `2.500.000 VNĐ`.

Form gửi các tham số `rate` và `usd` bằng POST đến endpoint `/convert`. `ConverterServlet` nhận dữ liệu, kiểm tra đầu vào, tính `VND = USD × Rate`, sau đó hiển thị kết quả. Các thư viện Servlet/JSP được khai báo ở scope `provided` vì Tomcat cung cấp chúng khi chạy ứng dụng.
