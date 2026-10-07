# AI Prompt Log

## 1. Flexbox cho Author Info
**Prompt:** Vì sao thanh thông tin tác giả gồm avatar, text và nút Share phù hợp với Flexbox? Làm thế nào để căn giữa dọc và cho phép nút Share xuống dòng trên mobile?

**Áp dụng:** `display: flex`, `align-items: center`, `justify-content: space-between`, `flex-wrap: wrap`.

## 2. CSS Grid cho Mosaic Gallery
**Prompt:** Dùng CSS Grid và `grid-row` hoặc `grid-template-areas` để tạo layout gồm một ảnh lớn bên trái và hai ảnh nhỏ xếp chồng bên phải.

**Áp dụng:** Hai cột `2fr 1fr`, ảnh chính `grid-row: 1 / span 2`, mobile chuyển về một cột.

## 3. Bootstrap Breakpoints
**Prompt:** Giải thích `col-12 col-md-6 col-lg-3` và cách nó thay thế float phần trăm cho 4 thẻ bài viết.

**Áp dụng:** Mobile 1 cột, tablet 2 cột, desktop 4 cột.

## 4. Bootstrap Spacing Utilities
**Prompt:** Khi nào nên dùng các utility như `gap-3`, `mt-3`, `pb-2` thay vì thêm CSS riêng?

**Áp dụng:** Dùng utility cho spacing cơ bản, giữ CSS riêng chủ yếu cho Mosaic Grid và các chi tiết giao diện đặc thù.

## 5. Responsive Image
**Prompt:** Vì sao nên dùng `object-fit: cover` trong gallery responsive?

**Áp dụng:** Giữ tỷ lệ vùng ảnh ổn định, cắt phần thừa thay vì làm méo ảnh.
