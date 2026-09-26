# Chuyển CSS sang SASS

## Cấu trúc

```
source_31/
├── index.html
├── styles.css                  # CSS ban đầu
├── css/
│   └── main.css                # CSS đã biên dịch từ SASS
├── sass/
│   ├── main.scss
│   ├── abstracts/
│   │   ├── _variables.scss
│   │   └── _mixins.scss
│   ├── base/
│   │   └── _global.scss
│   ├── layout/
│   │   └── _container.scss
│   ├── components/
│   │   ├── _buttons.scss
│   │   └── _cards.scss
│   └── pages/
│       └── _home.scss
└── README.md
```

## Điểm chuyển đổi chính

- Variables: gom màu sắc, shadow và kích thước dùng chung.
- Mixins: tái sử dụng style cho button và box-shadow.
- Nesting: nhóm selector như `.card__title`, `.hero__description` trong component cha.
- Partials: tách code theo abstracts, base, layout, components và pages.
- Main SCSS: import toàn bộ partials thành một entry point duy nhất.

## Biên dịch

Nếu đã cài Dart Sass:

```bash
sass sass/main.scss css/main.css
```

Watch mode:

```bash
sass --watch sass/main.scss:css/main.css
```
