# SASS Mixins & Variables

## Mục tiêu

- Tạo variables để kiểm soát giao diện.
- Tạo mixins để giảm lặp code.
- Sử dụng nesting và partials.
- Tăng khả năng tái sử dụng của CSS.

## Cấu trúc

```
source_32/
├── index.html
├── styles.css
├── css/
│   └── main.css
└── sass/
    ├── main.scss
    ├── abstracts/
    │   ├── _variables.scss
    │   └── _mixins.scss
    ├── base/
    │   ├── _global.scss
    │   └── _typography.scss
    ├── components/
    │   ├── _buttons.scss
    │   └── _cards.scss
    ├── layout/
    │   ├── _container.scss
    │   └── _footer.scss
    └── pages/
        └── _home.scss
```

## Biên dịch

```bash
sass sass/main.scss css/main.css
```

Watch mode:

```bash
sass --watch sass/main.scss:css/main.css
```

Trong file variables, có thể thay đổi `$primary-color`, `$font-large`, `$padding-standard`
hoặc `$box-shadow-default` để cập nhật nhiều component cùng lúc.
