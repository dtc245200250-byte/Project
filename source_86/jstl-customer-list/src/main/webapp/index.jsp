<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách khách hàng</title>
    <style>
        :root {
            color-scheme: light;
            --ink: #172554;
            --muted: #64748b;
            --line: #e2e8f0;
            --accent: #4f46e5;
        }
        * { box-sizing: border-box; }
        body {
            margin: 0;
            min-height: 100vh;
            padding: 42px 22px;
            font-family: Arial, sans-serif;
            color: var(--ink);
            background: linear-gradient(135deg, #eef2ff 0%, #f8fafc 55%, #ecfeff 100%);
        }
        .page { width: 100%; max-width: 1120px; margin: 0 auto; }
        .heading { margin-bottom: 28px; }
        .eyebrow {
            margin: 0 0 10px;
            color: var(--accent);
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 1.7px;
            text-transform: uppercase;
        }
        h1 { margin: 0; font-size: clamp(28px, 4vw, 38px); letter-spacing: -1px; }
        .description { margin: 12px 0 0; color: var(--muted); line-height: 1.6; }
        .summary {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 16px;
        }
        .summary h2 { margin: 0; font-size: 18px; }
        .count {
            padding: 7px 11px;
            border-radius: 999px;
            background: #e0e7ff;
            color: #3730a3;
            font-size: 12px;
            font-weight: 700;
            white-space: nowrap;
        }
        .table-wrap {
            overflow: hidden;
            border: 1px solid rgba(203, 213, 225, .8);
            border-radius: 16px;
            background: rgba(255, 255, 255, .95);
            box-shadow: 0 18px 48px rgba(15, 23, 42, .08);
        }
        table { width: 100%; border-collapse: collapse; }
        thead { background: #f8fafc; }
        th {
            padding: 16px 20px;
            color: #64748b;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: .8px;
            text-align: left;
            text-transform: uppercase;
        }
        td {
            padding: 17px 20px;
            border-top: 1px solid #edf2f7;
            color: #334155;
            font-size: 14px;
            vertical-align: middle;
        }
        tbody tr { transition: background .15s ease; }
        tbody tr:hover { background: #f8faff; }
        .customer {
            display: flex;
            align-items: center;
            gap: 13px;
            min-width: 220px;
        }
        .avatar {
            width: 52px;
            height: 52px;
            flex: 0 0 52px;
            border: 1px solid #e2e8f0;
            border-radius: 50%;
            object-fit: cover;
            background: #eef2ff;
        }
        .customer-name { color: #172554; font-weight: 700; }
        .customer-label { margin-top: 4px; color: #94a3b8; font-size: 12px; }
        .address { color: #475569; }
        .empty { padding: 34px; color: var(--muted); text-align: center; }
        footer { margin-top: 16px; color: #94a3b8; font-size: 12px; text-align: right; }
        @media (max-width: 760px) {
            body { padding: 28px 14px; }
            .table-wrap { overflow-x: auto; }
            table { min-width: 700px; }
            th, td { padding: 14px 15px; }
        }
    </style>
</head>
<body>
    <main class="page">
        <header class="heading">
            <p class="eyebrow">Customer directory</p>
            <h1>Danh sách khách hàng</h1>
            <p class="description">Thông tin khách hàng mẫu được hiển thị bằng JSTL Core Tags.</p>
        </header>

        <section aria-labelledby="list-heading">
            <div class="summary">
                <h2 id="list-heading">Thông tin khách hàng</h2>
                <span class="count">
                    <c:out value="${customers.size()}"/> khách hàng
                </span>
            </div>

            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Khách hàng</th>
                            <th>Ngày sinh</th>
                            <th>Địa chỉ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="customer" items="${customers}" varStatus="status">
                            <tr>
                                <td>
                                    <div class="customer">
                                        <img class="avatar"
                                             src="${pageContext.request.contextPath}${customer.imageUrl}"
                                             alt="Ảnh ${customer.name}">
                                        <div>
                                            <div class="customer-name"><c:out value="${customer.name}"/></div>
                                            <div class="customer-label">Khách hàng #<c:out value="${status.count}"/></div>
                                        </div>
                                    </div>
                                </td>
                                <td><c:out value="${customer.birthDate}"/></td>
                                <td class="address"><c:out value="${customer.address}"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty customers}">
                            <tr>
                                <td colspan="3" class="empty">Chưa có dữ liệu khách hàng.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </section>

        <footer>Demo JSP + JSTL · Dữ liệu minh họa</footer>
    </main>
</body>
</html>
