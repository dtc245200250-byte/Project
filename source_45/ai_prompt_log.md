# AI Prompt Log – AutoRide

## Prompt 1 – DECIMAL cho dữ liệu tài chính

**Prompt:**
> Trong MySQL, vì sao nên dùng DECIMAL thay cho FLOAT khi lưu tiền cọc, phí trễ và phí sửa chữa?

**Mục đích:** Ôn lại vấn đề sai số của số thực khi tính toán tiền.

**Kết quả áp dụng:** Dùng `DECIMAL(10,2)` cho `security_deposit`, `late_fee`, `damage_fee`.

---

## Prompt 2 – Quan hệ Inspections

**Prompt:**
> Khi lưu biên bản kiểm tra xe, khi nào quan hệ giữa Rentals và Inspections nên là 1-1 và khi nào nên là 1-N? Hãy phân tích theo khả năng một hợp đồng có thể có nhiều lần kiểm tra.

**Mục đích:** Chọn cardinality phù hợp và tránh nhồi dữ liệu kiểm tra vào Rentals.

**Kết quả áp dụng:** Thiết kế `Inspections.rental_id` là FK nhưng không đặt UNIQUE, cho phép mở rộng thành quan hệ 1-N.

---

## Prompt 3 – ALTER TABLE

**Prompt:**
> Cho tôi cú pháp MySQL để đổi cột status từ VARCHAR sang ENUM('BOOKED','ACTIVE','COMPLETED','CANCELLED') và thêm các cột security_deposit, late_fee, damage_fee vào bảng Rentals hiện có.

**Mục đích:** Ôn lại cách nâng cấp schema mà không cần xóa toàn bộ bảng.

**Kết quả áp dụng:** Script sử dụng `ALTER TABLE Rentals`.

---

## Prompt 4 – Khóa ngoại RESTRICT

**Prompt:**
> Khi tạo bảng Inspections tham chiếu Rentals, tại sao có thể dùng ON DELETE RESTRICT và khi nào phù hợp hơn ON DELETE CASCADE?

**Mục đích:** Ôn lại toàn vẹn tham chiếu và tránh xóa lịch sử kiểm tra xe ngoài ý muốn.

**Kết quả áp dụng:** Dùng `ON DELETE RESTRICT` và `ON UPDATE CASCADE`.

---

## Prompt 5 – Bảo vệ trạng thái bằng Trigger

**Prompt:**
> Nếu hợp đồng còn BOOKED thì không được phép tạo biên bản Inspections. Có thể dùng trigger MySQL nào để chặn thao tác INSERT này?

**Mục đích:** Bảo vệ quy tắc nghiệp vụ ngay ở tầng database.

**Kết quả áp dụng:** Tạo trigger `trg_inspection_only_after_pickup` và chỉ chặn khi Rental còn BOOKED.