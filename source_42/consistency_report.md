# Consistency Report – HealthSync

## Mục đích

Đối chiếu quy trình "Đặt lịch và Khám bệnh" với cấu trúc cơ sở dữ liệu Legacy để xác định các Data Gap khiến nghiệp vụ không thể vận hành đầy đủ.

## 3 điểm vênh nghiêm trọng nhất

### 1. Trạng thái lịch hẹn không đủ

Bảng `Appointments` cũ chỉ có `is_active BOOLEAN`. Trong khi quy trình nghiệp vụ yêu cầu vòng đời gồm **PENDING → CONFIRMED → CHECKED_IN → COMPLETED hoặc CANCELLED**. Boolean chỉ biểu diễn trạng thái đúng/sai, không thể ghi nhận bệnh nhân đang chờ duyệt, đã xác nhận cọc, đã đến khám hay đã hoàn tất.

**Thiết kế sửa:** thay `is_active` bằng `status ENUM('PENDING', 'CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED')`.

### 2. Không lưu được tiền cọc, phí phạt và lý do hủy

Activity Diagram yêu cầu bệnh nhân đặt lịch phải có tiền cọc. Khi bệnh nhân hủy sau CONFIRMED, hệ thống phải ghi lại lý do và tính phí phạt trừ vào tiền cọc. Legacy `Appointments` hoàn toàn không có các dữ liệu này.

**Thiết kế sửa:** bổ sung `deposit_amount DECIMAL(12,2)`, `penalty_fee DECIMAL(12,2)` và `cancel_reason VARCHAR(255)`. Dùng DECIMAL giúp lưu số tiền theo độ chính xác thập phân thay vì kiểu số dấu chấm động.

### 3. Không có nơi lưu đơn thuốc

Khi lịch hẹn chuyển sang COMPLETED, Bác sĩ phải kê một Prescription. Schema cũ không có bảng `Prescriptions`, vì vậy không có khóa ngoại để liên kết đơn thuốc với lịch hẹn.

**Thiết kế sửa:** tạo bảng `Prescriptions` gồm `prescription_id`, `appointment_id`, `medication_details`, `issued_date`. Thiết kế hiện tại dùng `UNIQUE appointment_id` để mô hình hóa quan hệ 1-1.

## Kết luận

Schema tối ưu phải phản ánh được cả **trạng thái vòng đời**, **dữ liệu tài chính**, **lý do hủy** và **đơn thuốc**. Khi các cấu trúc này khớp với Activity Diagram, Backend mới có đủ dữ liệu để thực hiện và đối soát toàn bộ quy trình.