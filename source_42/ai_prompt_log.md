# AI Prompt Log – HealthSync

## Prompt 1 – Phân tích lifecycle status

**Prompt:**

> Trong thiết kế cơ sở dữ liệu quan hệ, tại sao việc dùng một cột is_active kiểu BOOLEAN để theo dõi vòng đời của một lịch hẹn là hạn chế? Với quy trình PENDING, CONFIRMED, CHECKED_IN, COMPLETED, CANCELLED thì nên biểu diễn status như thế nào?

**Mục đích:** Ôn lại cách biểu diễn lifecycle bằng ENUM và phân biệt trạng thái nghiệp vụ với Boolean.

**Kết quả áp dụng:** Thay `is_active` bằng cột `status ENUM(...)`.

---

## Prompt 2 – Kiểu dữ liệu tiền

**Prompt:**

> Khi thiết kế các cột deposit_amount và penalty_fee trong MySQL, nên dùng FLOAT, DOUBLE hay DECIMAL? Hãy giải thích rủi ro làm tròn số đối với dữ liệu tài chính.

**Mục đích:** Ôn lại cách lưu dữ liệu tiền tệ và tránh sai số số thực.

**Kết quả áp dụng:** Sử dụng `DECIMAL(12,2)` cho tiền cọc và phí phạt.

---

## Prompt 3 – ALTER TABLE

**Prompt:**

> Cho tôi cú pháp MySQL để xóa cột is_active khỏi bảng Appointments và thêm cột status kiểu ENUM chứa PENDING, CONFIRMED, CHECKED_IN, COMPLETED, CANCELLED cùng các cột deposit_amount, penalty_fee, cancel_reason mà không cần xóa toàn bộ bảng.

**Mục đích:** Ôn lại cú pháp ALTER TABLE và cách tái cấu trúc schema hiện có.

**Kết quả áp dụng:** Script dùng `ALTER TABLE` để loại bỏ cột cũ và bổ sung các trường mới.

---

## Prompt 4 – Khóa ngoại

**Prompt:**

> Cú pháp chuẩn trong MySQL để tạo bảng Prescriptions có appointment_id là khóa ngoại tham chiếu Appointments là gì? Khi nào nên dùng ON DELETE RESTRICT thay vì ON DELETE CASCADE?

**Mục đích:** Ôn lại quan hệ giữa Appointment và Prescription và tác động của hành vi xóa.

**Kết quả áp dụng:** Dùng khóa ngoại `appointment_id` với `ON DELETE RESTRICT`, `ON UPDATE CASCADE`.

---

## Prompt 5 – Bảo vệ nghiệp vụ bằng Trigger

**Prompt:**

> Nếu một lịch hẹn đang ở trạng thái PENDING nhưng có người cố tình INSERT một đơn thuốc, làm thế nào để chặn hành động phi logic ngay tại tầng cơ sở dữ liệu?

**Mục đích:** Ôn lại cách dùng Database Trigger để bảo vệ tính toàn vẹn nghiệp vụ.

**Kết quả áp dụng:** Tạo trigger `trg_prescription_only_completed` để chỉ cho phép thêm Prescription khi Appointment có status = COMPLETED.