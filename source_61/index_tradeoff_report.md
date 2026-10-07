# Index Trade-off Report – SmartFactory

## Chẩn đoán

Legacy dùng **Fat Covering Index**:

`(sensor_id, recorded_at, temperature, humidity, status)`

Index này giúp truy vấn Dashboard có thể lấy dữ liệu trực tiếp từ Index, nhưng phải lưu thêm nhiều cột và phải duy trì chúng trong mỗi lần ghi. Với hệ thống cảm biến liên tục INSERT, Write Penalty và chi phí Storage trở thành nút thắt cổ chai.

## Giải pháp

Thay bằng **Lean Index**:

`(sensor_id, recorded_at)`

Hai cột này đủ để phục vụ điều kiện lọc của Dashboard. Sau đó MySQL có thể dùng Index để xác định các row phù hợp và lookup vào bảng gốc để lấy `temperature`, `humidity`, `status`.

| Tiêu chí | Fat Index | Lean Index |
|---|---|---|
| SELECT Dashboard | Tối đa, có thể Covering | Chậm hơn một phần |
| INSERT | Write Penalty cao | Nhẹ hơn |
| Index Storage | Lớn | Nhỏ hơn |
| Cân bằng hệ thống | Kém | Tốt hơn cho IoT |

Script có kiểm tra `SHOW TABLE STATUS` và `information_schema.TABLES` trước/sau để ghi nhận `INDEX_LENGTH` thực tế. Các con số MB/GB không được giả định trước vì phụ thuộc dữ liệu thật.

## Kết luận

Với SmartFactory, ưu tiên cân bằng Read/Write/Storage quan trọng hơn việc tối đa hóa một truy vấn SELECT.