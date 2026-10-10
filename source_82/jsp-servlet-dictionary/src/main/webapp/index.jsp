<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Từ điển Anh - Việt</title>
    <style>
        * { box-sizing: border-box; }
        body {
            min-height: 100vh;
            margin: 0;
            padding: 24px;
            display: grid;
            place-items: center;
            font-family: Arial, sans-serif;
            color: #172554;
            background: linear-gradient(135deg, #eff6ff, #f8fafc 58%, #ecfeff);
        }
        .dictionary {
            width: 100%;
            max-width: 470px;
            padding: 36px;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            background: #fff;
            box-shadow: 0 20px 55px rgba(15, 23, 42, .12);
        }
        .eyebrow {
            margin: 0 0 10px;
            color: #4f46e5;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-align: center;
            text-transform: uppercase;
        }
        h1 { margin: 0; font-size: 27px; text-align: center; }
        .intro { margin: 12px 0 28px; color: #64748b; line-height: 1.6; text-align: center; }
        label { display: block; margin-bottom: 9px; font-size: 14px; font-weight: 700; }
        input {
            width: 100%;
            padding: 14px;
            border: 1px solid #cbd5e1;
            border-radius: 9px;
            font: inherit;
        }
        input:focus { outline: 3px solid #c7d2fe; border-color: #6366f1; }
        button {
            width: 100%;
            margin-top: 16px;
            padding: 13px;
            border: 0;
            border-radius: 9px;
            background: #3730a3;
            color: #fff;
            font: inherit;
            font-weight: 700;
            cursor: pointer;
            transition: background .18s ease, transform .18s ease;
        }
        button:hover { background: #312e81; transform: translateY(-1px); }
        .examples {
            margin-top: 24px;
            padding: 15px;
            border-radius: 10px;
            background: #f8fafc;
            color: #475569;
            font-size: 13px;
            line-height: 1.9;
        }
        .examples strong { color: #1e293b; }
    </style>
</head>
<body>
    <main class="dictionary">
        <p class="eyebrow">English → Vietnamese</p>
        <h1>Từ điển Anh - Việt</h1>
        <p class="intro">Nhập một từ tiếng Anh để tra nghĩa tiếng Việt trong từ điển mẫu.</p>

        <form action="<%= request.getContextPath() %>/translate" method="POST">
            <label for="word">Từ tiếng Anh</label>
            <input id="word" name="word" type="text"
                   placeholder="Ví dụ: hello" autocomplete="off" required autofocus>
            <button type="submit">Tìm kiếm</button>
        </form>

        <div class="examples">
            <strong>Từ có sẵn:</strong><br>
            hello — Xin chào<br>
            book — Quyển sách<br>
            computer — Máy tính<br>
            student — Sinh viên
        </div>
    </main>
</body>
</html>
