# AI Prompt Log – PayFlow

## Prompt 1 – YEAR/MONTH và Index

**Prompt:**
> Trong MySQL, nếu tạo Index cho cột ngày tháng nhưng WHERE lại viết YEAR(created_at) = 2026 thì vì sao Index có thể không được tận dụng như điều kiện range trực tiếp?

**Mục đích:** Ôn lại khái niệm Non-SARGable.

**Kết quả áp dụng:** Loại bỏ YEAR()/MONTH() khỏi cột indexed và chuyển sang điều kiện >= / <.

---

## Prompt 2 – Composite Index

**Prompt:**
> Khi tạo Composite Index trên (transaction_type, created_at), thứ tự cột trong Index có ảnh hưởng như thế nào đến khả năng lọc dữ liệu?

**Mục đích:** Hiểu leftmost prefix và vai trò của điều kiện bằng/range trong composite index.

**Kết quả áp dụng:** Dùng idx_type_date(transaction_type, created_at).

---

## Prompt 3 – Các giá trị type trong EXPLAIN

**Prompt:**
> Giải thích ý nghĩa các giá trị thường gặp của cột type trong MySQL EXPLAIN như ALL, index, range, ref và const.

**Mục đích:** Đọc execution plan và nhận biết full table scan so với index access.

---

## Prompt 4 – SARGable

**Prompt:**
> SARGable là gì trong SQL? Vì sao điều kiện created_at >= ngày đầu tháng AND created_at < ngày đầu tháng sau có thể dùng Index tốt hơn YEAR(created_at) và MONTH(created_at)?

**Mục đích:** Hiểu vì sao biểu thức range trực tiếp trên cột hỗ trợ index search.

---

## Prompt 5 – Execution Time

**Prompt:**
> Trong MySQL hiện đại có thể dùng EXPLAIN ANALYZE như thế nào để quan sát execution timing thực tế thay vì chỉ xem execution plan?

**Mục đích:** Phân biệt execution plan với số liệu thực thi thực tế.

---

## Prompt 6 – Tác động của Index lên ghi dữ liệu

**Prompt:**
> Nếu bảng Transactions có rất nhiều INSERT/UPDATE/DELETE mỗi giây, việc thêm nhiều Index có thể gây ảnh hưởng gì đến hệ thống?

**Mục đích:** Hiểu trade-off giữa tốc độ đọc và chi phí duy trì Index.