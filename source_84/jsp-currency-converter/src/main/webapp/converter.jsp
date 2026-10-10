<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String rateInput = request.getParameter("rate");
    String usdInput = request.getParameter("usd");

    double rate = 0;
    double usd = 0;
    double vnd = 0;
    String errorMessage = null;

    try {
        if (rateInput == null || usdInput == null
                || rateInput.trim().isEmpty() || usdInput.trim().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập đầy đủ tỉ giá và lượng USD.");
        }

        rate = Double.parseDouble(rateInput.trim());
        usd = Double.parseDouble(usdInput.trim());

        if (!Double.isFinite(rate) || !Double.isFinite(usd)
                || rate <= 0 || usd < 0) {
            throw new IllegalArgumentException("Tỉ giá phải lớn hơn 0 và lượng USD không được âm.");
        }

        vnd = rate * usd;
        if (!Double.isFinite(vnd)) {
            throw new IllegalArgumentException("Số tiền quá lớn để tính toán.");
        }
    } catch (NumberFormatException ex) {
        errorMessage = "Dữ liệu không hợp lệ. Vui lòng nhập các giá trị dạng số.";
    } catch (IllegalArgumentException ex) {
        errorMessage = ex.getMessage();
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả chuyển đổi</title>
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
        .result {
            width: 100%;
            max-width: 520px;
            padding: 36px;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            background: #fff;
            box-shadow: 0 20px 55px rgba(15, 23, 42, .12);
            text-align: center;
        }
        .eyebrow {
            margin: 0 0 10px;
            color: #4f46e5;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }
        h1 { margin: 0 0 24px; font-size: 26px; }
        .detail { color: #475569; line-height: 1.8; overflow-wrap: anywhere; }
        .amount {
            margin: 24px 0;
            padding: 22px 14px;
            border-radius: 12px;
            background: #ecfdf5;
            color: #15803d;
            font-size: clamp(25px, 5vw, 34px);
            font-weight: 800;
            overflow-wrap: anywhere;
        }
        .error {
            margin: 20px 0;
            padding: 16px;
            border-radius: 10px;
            background: #fef2f2;
            color: #b91c1c;
            line-height: 1.6;
        }
        .back {
            display: inline-block;
            margin-top: 14px;
            padding: 12px 20px;
            border-radius: 9px;
            background: #3730a3;
            color: #fff;
            text-decoration: none;
            font-weight: 700;
        }
        .back:hover { background: #312e81; }
    </style>
</head>
<body>
    <main class="result">
        <p class="eyebrow">Conversion result</p>
        <h1>Kết quả chuyển đổi</h1>

        <% if (errorMessage == null) { %>
            <p class="detail">Tỉ giá: <strong><%= rate %> VND/USD</strong></p>
            <p class="detail">Lượng USD: <strong>$<%= usd %></strong></p>
            <div class="amount">Thành tiền: <%= String.format(java.util.Locale.US, "%,.2f", vnd) %> VNĐ</div>
        <% } else { %>
            <div class="error"><strong>Lỗi xử lý!</strong><br><%= errorMessage %></div>
        <% } %>

        <a class="back" href="index.jsp">Quay lại trang chủ</a>
    </main>
</body>
</html>
