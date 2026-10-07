# AI Prompt Log – SmartFactory

## Prompt 1 – Covering Index

> Covering Index trong MySQL là gì? Vì sao truy vấn có thể không cần đọc bảng gốc khi mọi cột cần thiết đều nằm trong Index?

**Áp dụng:** Hiểu lợi ích của `idx_fat_covering`.

## Prompt 2 – Secondary Index và Clustered Index

> Trong InnoDB, Clustered Index và Secondary Index lưu dữ liệu như thế nào? Khi Secondary Index không chứa đủ các cột SELECT, MySQL lấy dữ liệu còn thiếu ở đâu?

**Áp dụng:** Hiểu vì sao Lean Index có thể phải lookup bảng gốc.

## Prompt 3 – Write Penalty

> Tại sao thêm cột vào Composite Index làm INSERT và UPDATE tốn chi phí hơn?

**Áp dụng:** Phân tích Write Penalty của Fat Index trong hệ thống IoT.

## Prompt 4 – Storage

> Làm thế nào dùng SHOW TABLE STATUS và information_schema.TABLES để so sánh INDEX_LENGTH trước và sau khi thay Index?

**Áp dụng:** Đo chi phí Storage thực tế.

## Prompt 5 – Kiểu dữ liệu

> Nếu status VARCHAR(20) được thay bằng TINYINT và cột đó nằm trong Index, kích thước Data Length và Index Length có thể thay đổi như thế nào?

**Áp dụng:** Tìm hiểu cách kiểu dữ liệu ảnh hưởng tới Storage và Index.
