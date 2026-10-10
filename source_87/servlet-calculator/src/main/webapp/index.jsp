<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Máy tính cơ bản</title>
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
            background: linear-gradient(135deg, #eef2ff, #f8fafc 58%, #ecfeff);
        }
        .calculator {
            width: 100%;
            max-width: 460px;
            padding: 34px;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            background: #fff;
            box-shadow: 0 20px 55px rgba(15, 23, 42, .12);
        }
        .eyebrow {
            margin: 0 0 10px;
            color: #4f46e5;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 1.5px;
            text-align: center;
            text-transform: uppercase;
        }
        h1 { margin: 0; font-size: 27px; text-align: center; }
        .subtitle { margin: 12px 0 27px; color: #64748b; line-height: 1.6; text-align: center; }
        label { display: block; margin: 18px 0 8px; font-size: 14px; font-weight: 700; }
        input, select {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 9px;
            background: #fff;
            color: #0f172a;
            font: inherit;
        }
        input:focus, select:focus { outline: 3px solid #c7d2fe; border-color: #6366f1; }
        .operator-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
        button {
            width: 100%;
            margin-top: 26px;
            padding: 14px 16px;
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
        .operations { display: grid; grid-template-columns: repeat(4, 1fr); gap: 8px; margin-top: 22px; }
        .operation {
            padding: 10px 4px;
            border: 1px solid #e0e7ff;
            border-radius: 8px;
            background: #f8faff;
            color: #4338ca;
            font-size: 13px;
            font-weight: 700;
            text-align: center;
        }
    </style>
</head>
<body>
    <main class="calculator">
        <p class="eyebrow">Basic calculator</p>
        <h1>Máy tính cơ bản</h1>
        <p class="subtitle">Nhập hai toán hạng và chọn phép tính cần thực hiện.</p>

        <form action="<%= request.getContextPath() %>/calculate" method="POST">
            <label for="firstOperand">Số thứ nhất</label>
            <input id="firstOperand" name="firstOperand" type="number"
                   step="any" placeholder="Nhập số thứ nhất" required>

            <label for="secondOperand">Số thứ hai</label>
            <input id="secondOperand" name="secondOperand" type="number"
                   step="any" placeholder="Nhập số thứ hai" required>

            <label for="operator">Phép toán</label>
            <select id="operator" name="operator" required>
                <option value="add">Cộng (+)</option>
                <option value="subtract">Trừ (−)</option>
                <option value="multiply">Nhân (×)</option>
                <option value="divide">Chia (÷)</option>
            </select>

            <button type="submit">Tính kết quả</button>
        </form>

        <div class="operations" aria-label="Các phép toán được hỗ trợ">
            <span class="operation">Cộng +</span>
            <span class="operation">Trừ −</span>
            <span class="operation">Nhân ×</span>
            <span class="operation">Chia ÷</span>
        </div>
    </main>
</body>
</html>
