<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Login</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 24px;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #eef2ff, #f8fafc);
            color: #172554;
        }
        .login-container {
            width: 100%;
            max-width: 390px;
            padding: 32px;
            border-radius: 16px;
            background: #fff;
            box-shadow: 0 18px 45px rgba(30, 41, 59, .12);
        }
        h1 { margin: 0 0 8px; text-align: center; font-size: 26px; }
        .subtitle { margin: 0 0 26px; color: #64748b; text-align: center; }
        label { display: block; margin: 16px 0 7px; font-size: 14px; font-weight: 700; }
        input {
            width: 100%;
            padding: 12px 13px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font: inherit;
        }
        input:focus { outline: 2px solid #a5b4fc; border-color: #4f46e5; }
        button {
            width: 100%;
            margin-top: 24px;
            padding: 12px;
            border: 0;
            border-radius: 8px;
            background: #3730a3;
            color: white;
            font: inherit;
            font-weight: 700;
            cursor: pointer;
        }
        button:hover { background: #312e81; }
        .hint { margin: 16px 0 0; color: #64748b; font-size: 12px; text-align: center; }
    </style>
</head>
<body>
    <main class="login-container">
        <h1>System Login</h1>
        <p class="subtitle">Sign in to continue</p>

        <form action="<%= request.getContextPath() %>/login" method="POST">
            <label for="username">Username</label>
            <input id="username" name="username" type="text"
                   placeholder="Enter username" autocomplete="username" required>

            <label for="password">Password</label>
            <input id="password" name="password" type="password"
                   placeholder="Enter password" autocomplete="current-password" required>

            <button type="submit">Login</button>
        </form>

        <p class="hint">Demo credentials: admin / admin</p>
    </main>
</body>
</html>
