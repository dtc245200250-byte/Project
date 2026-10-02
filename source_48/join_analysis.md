# JOIN Analysis – FlashMart

Trong báo cáo Marketing, **LEFT JOIN** được dùng vì bảng `Customers` là bảng gốc và cần giữ lại toàn bộ khách hàng, kể cả người chưa từng có đơn hàng.

Khi khách hàng chưa có bản ghi tương ứng trong `Orders`, các cột của bảng `Orders` sẽ có giá trị NULL. Vì vậy cần dùng **COUNT(o.order_id)** thay vì **COUNT(*)**. Cột `o.order_id` là khóa chính của Orders và sẽ NULL ở phần không khớp, nên COUNT(o.order_id) không đếm dòng đó và trả về **0** cho Charlie. Ngược lại, COUNT(*) vẫn đếm dòng của LEFT JOIN và có thể cho kết quả 1 dù khách hàng chưa có đơn.

Báo cáo Kho vận dùng **LEFT JOIN + WHERE o.order_id IS NULL** (Anti-Join) để tìm Product chưa từng xuất hiện trong Orders. Với dữ liệu mẫu, sản phẩm không có giao dịch là **Keyboard (103)**.