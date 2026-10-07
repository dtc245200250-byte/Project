# Storage & Performance Report – QuickFeed

## Chẩn đoán

QuickFeed đang **over-indexing** bảng `Posts`: cả 5 Index đều phải được duy trì khi dữ liệu được INSERT/UPDATE/DELETE. Điều này làm tăng chi phí ghi, RAM và Disk Space. Trong đó `idx_content` trên `TEXT` gây overhead lớn; `idx_post_type` chỉ có khoảng 3 giá trị và `idx_is_visible` chỉ có 0/1 nên độ phân giải dữ liệu thấp, thường không đủ hấp dẫn để Optimizer dùng thay cho quét bảng.

## Quyết định

| Index | Quyết định | Lý do |
|---|---|---|
| `idx_user_id` | Giữ | Hữu ích khi lấy bài viết theo người dùng |
| `idx_content` | Xóa | Tốn storage; nhu cầu tìm văn bản phù hợp với FULLTEXT hơn |
| `idx_post_type` | Xóa | Cardinality thấp |
| `idx_is_visible` | Xóa | Chỉ 2 giá trị, cardinality rất thấp |
| `idx_created_at` | Giữ | Hữu ích cho newsfeed theo thời gian |

## Đối chiếu Storage

Script đo `DATA_LENGTH` và `INDEX_LENGTH` từ `information_schema.TABLES` trước và sau khi DROP 3 Index. **Số MB thực tế phụ thuộc dữ liệu đang có trong môi trường MySQL và không được giả định trước.** Sau khi chạy, điền kết quả thực tế vào bảng:

| Chỉ số | Trước | Sau |
|---|---:|---:|
| Data MB | lấy từ query | lấy từ query |
| Index MB | lấy từ query | lấy từ query |
| Total MB | lấy từ query | lấy từ query |

Việc loại bỏ 3 Index làm giảm số cấu trúc B-Tree phải duy trì trong các thao tác ghi, đổi lại một số truy vấn có thể mất lựa chọn Index và phải kiểm tra lại bằng EXPLAIN.
