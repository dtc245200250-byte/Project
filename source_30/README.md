# SASS CLI Demo

## Kiểm tra Node.js và npm

```bash
node -v
npm -v
```

## Cài Sass bằng npm

```bash
npm install -g sass
sass -v
```

Hoặc cài Sass trong dự án:

```bash
npm install --save-dev sass
```

## Biên dịch SCSS sang CSS

Tại thư mục `source_30`:

```bash
sass scss/styles.scss css/styles.css
```

Hoặc dùng npm script:

```bash
npm run build
```

## Watch mode

```bash
sass --watch scss/:css/
```

Hoặc:

```bash
npm run watch
```

## Sơ đồ thư mục

```
source_30/
├── index.html
├── package.json
├── README.md
├── scss/
│   └── styles.scss
└── css/
    └── styles.css
```

## Lưu ý Windows

Nếu PowerShell chặn script của npm, nên kiểm tra chính sách thực thi hiện tại trước khi thay đổi:

```powershell
Get-ExecutionPolicy
```

Có thể dùng phạm vi người dùng hiện tại thay vì thay đổi toàn hệ thống:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

Sau đó mở lại PowerShell và thử lệnh npm/Sass.
