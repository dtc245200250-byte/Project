# Bài thực hành: Máy tính Java Web với Servlet và JSP

## Cấu trúc dự án

```
source_87/
├── README.md
└── servlet-calculator/
    ├── pom.xml
    └── src/main/
        ├── java/com/codegym/
        │   ├── Calculator.java
        │   └── CalculatorServlet.java
        └── webapp/
            ├── index.jsp
            └── WEB-INF/web.xml
```

## Yêu cầu
- JDK 17 trở lên
- Maven
- Apache Tomcat 10.1+ (Jakarta Servlet 6)

## Đóng gói
Mở terminal tại thư mục `servlet-calculator` rồi chạy:

```bash
mvn clean package
```

File WAR sẽ được tạo ở `target/servlet-calculator.war`.

## Triển khai
Sao chép file WAR vào thư mục `webapps` của Tomcat, khởi động server rồi truy cập:

`http://localhost:8080/servlet-calculator/`

## Chức năng
- Form `index.jsp` nhận hai toán hạng và phép toán, sau đó gửi POST đến `/calculate`.
- `Calculator.calculate()` thực hiện cộng, trừ, nhân, chia.
- Khi chia cho 0, lớp `Calculator` ném `ArithmeticException`; `CalculatorServlet` bắt ngoại lệ bằng `try/catch` và hiển thị thông báo lỗi.
- Các dữ liệu số không hợp lệ hoặc phép toán không hợp lệ cũng được xử lý.

## Kiểm thử nhanh
- `12 + 8` → `20`
- `12 − 8` → `4`
- `12 × 8` → `96`
- `12 ÷ 0` → thông báo không thể chia cho 0.
