# Activity Diagram → ERD Mapping – AutoRide

Activity Diagram của AutoRide có một khoảng trống quan trọng trong mô hình cũ: khi khách trả xe, hệ thống phải tính **phí phạt trễ**, **phí sửa chữa** và tiền hoàn lại, nhưng bảng `Rentals` không có các cột tương ứng.

Cột `damage_fee` là bắt buộc vì nhánh nghiệp vụ kiểm tra xe có thể phát hiện hư hỏng sau khi khách trả xe. Nếu chỉ lưu mô tả lỗi bằng ghi chú hoặc giấy tờ bên ngoài, hệ thống không thể chuyển kết quả kiểm tra thành dữ liệu tài chính để tính khoản phải khấu trừ từ tiền cọc. Khi đó phép tính hoàn tiền `security_deposit - late_fee - damage_fee` không thể thực hiện nhất quán và kế toán khó đối soát.

Thiết kế mới bổ sung `damage_fee DECIMAL(10,2)`, đồng thời có bảng `Inspections` để lưu chi tiết hư hỏng, ngày kiểm tra và nhân viên kiểm tra. Nhờ vậy, dữ liệu mô tả và dữ liệu tài chính được lưu riêng nhưng liên kết qua `rental_id`, phù hợp với quy trình nghiệp vụ và dễ mở rộng.