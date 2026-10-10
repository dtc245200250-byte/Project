<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Discount Calculator</title>
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
            max-width: 480px;
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
            font-weight: 700;
            letter-spacing: 1.5px;
            text-align: center;
            text-transform: uppercase;
        }
        h1 { margin: 0; font-size: 26px; text-align: center; }
        .subtitle { margin: 12px 0 26px; color: #64748b; line-height: 1.55; text-align: center; }
        label { display: block; margin: 17px 0 8px; font-size: 14px; font-weight: 700; }
        input, textarea {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 9px;
            background: #fff;
            color: #0f172a;
            font: inherit;
        }
        textarea { min-height: 92px; resize: vertical; }
        input:focus, textarea:focus { outline: 3px solid #c7d2fe; border-color: #6366f1; }
        .hint { margin: 7px 0 0; color: #64748b; font-size: 12px; }
        button {
            width: 100%;
            margin-top: 25px;
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
    </style>
</head>
<body>
    <main class="calculator">
        <p class="eyebrow">Smart shopping</p>
        <h1>Product Discount Calculator</h1>
        <p class="subtitle">Enter your product details to calculate the discount and final price.</p>

        <form action="<%= request.getContextPath() %>/display-discount" method="POST">
            <label for="productDescription">Product Description</label>
            <textarea id="productDescription" name="productDescription"
                      placeholder="Enter the product description" maxlength="300" required></textarea>

            <label for="listPrice">List Price</label>
            <input id="listPrice" name="listPrice" type="number"
                   min="0.01" step="0.01" placeholder="e.g. 199.99" required>

            <label for="discountPercent">Discount Percent (%)</label>
            <input id="discountPercent" name="discountPercent" type="number"
                   min="0" max="100" step="any" placeholder="e.g. 15" required>
            <p class="hint">Enter a percentage from 0 to 100.</p>

            <button type="submit">Calculate Discount</button>
        </form>
    </main>
</body>
</html>
