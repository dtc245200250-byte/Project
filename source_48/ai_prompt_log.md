# AI Prompt Log – FlashMart

## Prompt 1 – INNER JOIN và LEFT JOIN

**Prompt:**
> Trong MySQL, JOIN mặc định là loại JOIN nào nếu không ghi INNER, LEFT hay RIGHT? Nó giữ hay loại các bản ghi không có sự trùng khớp?

**Mục đích:** Ôn lại hành vi của JOIN khi hai tập dữ liệu không giao nhau.

**Kết quả áp dụng:** Không dùng JOIN mặc định cho báo cáo Marketing vì cần giữ khách hàng chưa mua.

---

## Prompt 2 – COUNT với LEFT JOIN

**Prompt:**
> Khi dùng LEFT JOIN và COUNT để đếm số đơn hàng theo từng khách hàng, nên dùng COUNT(*) hay COUNT(o.order_id)? Vì sao khách hàng chưa mua phải ra 0?

**Mục đích:** Hiểu cách NULL ở bảng bên phải ảnh hưởng tới COUNT.

**Kết quả áp dụng:** Dùng COUNT(o.order_id).

---

## Prompt 3 – Anti-Join

**Prompt:**
> Vì sao LEFT JOIN kết hợp WHERE o.order_id IS NULL có thể tìm các bản ghi không tồn tại ở bảng Orders?

**Mục đích:** Ôn lại kỹ thuật Anti-Join để tìm Product chưa từng được bán.

**Kết quả áp dụng:** Dùng LEFT JOIN Products -> Orders và lọc IS NULL.

---

## Prompt 4 – Performance

**Prompt:**
> Hãy phân tích về mặt khái niệm hiệu năng giữa LEFT JOIN ... IS NULL và NOT IN khi tìm bản ghi không tồn tại trong bảng khác. Có những lưu ý nào về NULL?

**Mục đích:** Mở rộng kiến thức về cách viết truy vấn Anti-Join.

**Kết quả áp dụng:** Ưu tiên cách viết dễ đọc và phù hợp với mô hình dữ liệu hiện tại.

---

## Prompt 5 – FULL OUTER JOIN trong MySQL

**Prompt:**
> MySQL không có FULL OUTER JOIN trực tiếp thì có thể kết hợp LEFT JOIN và RIGHT JOIN như thế nào để mô phỏng?

**Mục đích:** Mở rộng kiến thức JOIN ngoài yêu cầu chính.

**Kết quả áp dụng:** Ghi nhận như nội dung tham khảo lý thuyết, không dùng trong hai báo cáo chính.