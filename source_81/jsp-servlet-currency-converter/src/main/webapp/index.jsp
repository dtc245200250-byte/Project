<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chuyển đổi USD sang VNĐ</title>
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
            background: linear-gradient(135deg, #eff6ff, #f8fafc 55%, #ecfeff);
        }
        .converter {
            width: 100%;
            max-width: 430px;
            padding: 34px;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            background: #fff;
            box-shadow: 0 20px 55px rgba(15, 23, 42, .12);
        }
        .eyebrow {
            margin: 0 0 9px;
            color: #4f46e5;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1.6px;
            text-align: center;
            text-transform: uppercase;
        }
        h1 { margin: 0; font-size: 25px; line-height: 1.3; text-align: center; }
        .subtitle { margin: 10px 0 28px; color: #64748b; text-align: center; line-height: 1.5; }
        label { display: block; margin: 18px 0 8px; font-size: 14px; font-weight: 700; }
        input {
            display: block;
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 9px;
            background: #fff;
            color: #0f172a;
            font: inherit;
        }
        input:focus { outline: 3px solid #c7d2fe; border-color: #6366f1; }
        .helper { margin: 7px 0 0; color: #64748b; font-size: 12px; }
        button {
            width: 100%;
            margin-top: 26px;
            padding: 13px 16px;
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
        .note { margin: 20px 0 0; color: #94a3b8; font-size: 12px; line-height: 1.5; text-align: center; }
    </style>
</head>
<body>
    <main class="converter">
        <p class="eyebrow">Currency converter</p>
        <h1>Chuyển đổi USD sang VNĐ</h1>
        <p class="subtitle">Nhập tỉ giá và số USD để tính số tiền tương ứng bằng VNĐ.</p>

        <form action="<%= request.getContextPath() %>/convert" method="POST">
            <label for="rate">Tỉ giá (VND/USD)</label>
            <input id="rate" name="rate" type="number" min="0.000001"
                   step="any" value="25000" placeholder="Ví dụ: 25000" required>
            <p class="helper">Ví dụ: 1 USD = 25.000 VNĐ</p>

            <label for="usd">Lượng USD cần đổi</label>
            <input id="usd" name="usd" type="number" min="0"
                   step="any" placeholder="Nhập số USD" required>

            <button type="submit">Chuyển đổi ngay</button>
        </form>

        <p class="note">Tỉ giá được nhập thủ công theo yêu cầu bài thực hành, không tự cập nhật theo thị trường.</p>
    </main>
</body>
</html>
