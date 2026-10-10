<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    private String escapeHtml(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");

    Map<String, String> dictionary = new HashMap<>();
    dictionary.put("hello", "Xin chào");
    dictionary.put("how", "Thế nào");
    dictionary.put("book", "Quyển sách");
    dictionary.put("computer", "Máy tính");
    dictionary.put("student", "Sinh viên");
    dictionary.put("apple", "Quả táo");
    dictionary.put("school", "Trường học");
    dictionary.put("thank you", "Cảm ơn");
    dictionary.put("good morning", "Chào buổi sáng");

    String searchWord = request.getParameter("search");
    String normalizedWord = searchWord == null
            ? ""
            : searchWord.trim().toLowerCase(Locale.ROOT);
    String meaning = normalizedWord.isEmpty()
            ? null
            : dictionary.get(normalizedWord);
    boolean emptySearch = normalizedWord.isEmpty();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả tra cứu từ điển</title>
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
        h1 { margin: 0 0 24px; font-size: 26px; overflow-wrap: anywhere; }
        .meaning {
            margin: 22px 0;
            padding: 22px 16px;
            border-radius: 12px;
            background: #ecfdf5;
            color: #15803d;
            font-size: 23px;
            font-weight: 800;
            line-height: 1.5;
            overflow-wrap: anywhere;
        }
        .not-found, .empty {
            margin: 22px 0;
            padding: 18px;
            border-radius: 12px;
            background: #fef2f2;
            color: #b91c1c;
            line-height: 1.6;
            overflow-wrap: anywhere;
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
        <p class="eyebrow">Dictionary result</p>
        <h1>Kết quả tra cứu</h1>

        <% if (emptySearch) { %>
            <div class="empty">Vui lòng nhập từ tiếng Anh cần tra cứu.</div>
        <% } else if (meaning != null) { %>
            <p>Từ cần tra: <strong><%= escapeHtml(searchWord.trim()) %></strong></p>
            <div class="meaning">Nghĩa tiếng Việt: <%= escapeHtml(meaning) %></div>
        <% } else { %>
            <div class="not-found">
                <strong>Không tìm thấy!</strong><br>
                Từ khóa “<%= escapeHtml(searchWord.trim()) %>” không có trong từ điển.
            </div>
        <% } %>

        <a class="back" href="index.jsp">Quay lại trang chủ</a>
    </main>
</body>
</html>
