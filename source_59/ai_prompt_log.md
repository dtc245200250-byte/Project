# AI Prompt Log – QuickFeed

## Prompt 1 – Cardinality

> Cardinality trong MySQL là gì? Vì sao cột chỉ có 2 hoặc 3 giá trị thường là ứng viên kém cho B-Tree Index?

**Áp dụng:** Dùng để đánh giá `idx_is_visible` và `idx_post_type`.

## Prompt 2 – TEXT Index

> Index B-Tree trên cột TEXT với prefix 255 ký tự gây ảnh hưởng thế nào đến Disk Space, RAM và chi phí INSERT?

**Áp dụng:** Quyết định loại bỏ `idx_content`.

## Prompt 3 – Write overhead

> Khi một bảng có nhiều Index, điều gì xảy ra ở tầng lưu trữ khi INSERT hoặc UPDATE một row?

**Áp dụng:** Phân tích trade-off giữa Read và Write.

## Prompt 4 – information_schema

> Hãy viết truy vấn dùng information_schema.TABLES để xem DATA_LENGTH và INDEX_LENGTH của bảng Posts theo MB.

**Áp dụng:** Đo Storage trước và sau khi tối ưu.

## Prompt 5 – FULLTEXT

> Muốn tìm kiếm từ khóa trong cột content kiểu TEXT, nên dùng B-Tree prefix index hay FULLTEXT Index? Vì sao?

**Áp dụng:** Định hướng giải pháp thay thế cho nhu cầu tìm kiếm văn bản.
