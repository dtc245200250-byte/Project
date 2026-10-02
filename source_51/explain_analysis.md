# EXPLAIN Analysis – PayFlow

## Điểm nghẽn

Truy vấn cũ dùng:

`YEAR(created_at)` và `MONTH(created_at)`

Đây là dạng **Non-SARGable** vì cột `created_at` bị bao bởi hàm. Điều kiện không còn là phép so sánh range trực tiếp trên giá trị được index, nên optimizer có thể phải đọc rất nhiều dòng để tính YEAR/MONTH trước khi lọc.

## Sau khi tối ưu

Tạo Composite Index:

`idx_type_date(transaction_type, created_at)`

và viết lại điều kiện:

`created_at >= '2026-06-01 00:00:00' AND created_at < '2026-07-01 00:00:00'`

Điều kiện mới là dạng range trực tiếp trên `created_at`, nên có khả năng tận dụng B-Tree Index cùng điều kiện `transaction_type = 'DEPOSIT'`.

## So sánh EXPLAIN

**Trước:** bài tập kỳ vọng `type = ALL` và `rows` có thể rất lớn khi bảng chứa hàng triệu giao dịch.

**Sau:** bài tập kỳ vọng `possible_keys` và `key` có thể xuất hiện `idx_type_date`, còn `type` thường chuyển sang dạng phù hợp với range/index access.

Lưu ý: giá trị `type`, `rows`, `key` thực tế phụ thuộc dữ liệu, thống kê và phiên bản MySQL. Vì vậy cần chạy EXPLAIN trên môi trường MySQL thật để ghi nhận kết quả thực tế; không nên tự gán một con số rows cụ thể khi chưa chạy.