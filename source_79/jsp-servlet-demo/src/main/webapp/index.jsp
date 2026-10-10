<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.ZonedDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss z");
    String serverTime = ZonedDateTime.now().format(dateFormat);
%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CodeGym JSP Demo</title>
    <style>
        :root {
            color-scheme: light;
            font-family: Arial, Helvetica, sans-serif;
            background: #f8fafc;
            color: #1e293b;
        }

        * { box-sizing: border-box; }

        body {
            margin: 0;
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 24px;
        }

        .panel {
            width: min(100%, 760px);
            padding: clamp(24px, 5vw, 52px);
            text-align: center;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 22px;
            box-shadow: 0 18px 50px rgba(30, 41, 59, .08);
        }

        .eyebrow {
            color: #4f46e5;
            font-size: .78rem;
            font-weight: 800;
            letter-spacing: .14em;
            text-transform: uppercase;
        }

        h1 {
            margin: 12px 0;
            color: #1b2a7a;
            font-size: clamp(1.9rem, 5vw, 2.8rem);
        }

        .description { color: #64748b; line-height: 1.7; }

        .time-label { margin-top: 28px; color: #64748b; }

        .time {
            overflow-wrap: anywhere;
            color: #f15a24;
            font-size: clamp(1.15rem, 3vw, 1.6rem);
            font-weight: 700;
        }

        .button {
            display: inline-block;
            margin-top: 18px;
            padding: 12px 20px;
            color: #fff;
            background: #1b2a7a;
            border-radius: 8px;
            text-decoration: none;
            transition: background .2s ease, transform .2s ease;
        }

        .button:hover { background: #303f9f; transform: translateY(-1px); }
        .note { margin-top: 24px; color: #94a3b8; font-size: .85rem; }
    </style>
</head>
<body>
    <main class="panel">
        <p class="eyebrow">Java Web · JSP / Servlet</p>
        <h1>Chào mừng tới lớp học Java Web!</h1>
        <p class="description">
            Đây là trang JSP được xử lý bởi máy chủ Tomcat.
            Thời gian bên dưới lấy từ đồng hồ của máy chủ khi trang được yêu cầu.
        </p>

        <p class="time-label">Thời gian hệ thống hiện tại:</p>
        <p class="time"><%= serverTime %></p>

        <a class="button" href="<%= request.getContextPath() %>/hello">
            Đi tới HelloServlet
        </a>

        <p class="note">Tải lại trang để xem thời gian được cập nhật.</p>
    </main>
</body>
</html>
