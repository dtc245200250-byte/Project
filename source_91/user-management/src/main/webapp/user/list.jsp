<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý User</title>
    <style>
        *{box-sizing:border-box}
        body{margin:0;min-height:100vh;padding:36px 20px;font-family:Arial,sans-serif;color:#172554;background:linear-gradient(135deg,#eef2ff,#f8fafc 58%,#ecfeff)}
        main{max-width:1100px;margin:0 auto}.eyebrow{margin:0 0 8px;color:#4f46e5;font-size:12px;font-weight:800;letter-spacing:1.4px;text-transform:uppercase}
        h1{margin:0;font-size:clamp(28px,4vw,36px)}.intro{margin:10px 0 26px;color:#64748b;line-height:1.6}
        .toolbar{display:flex;justify-content:space-between;align-items:center;gap:14px;flex-wrap:wrap;margin-bottom:18px}
        .filters{display:flex;align-items:center;gap:9px;flex-wrap:wrap;flex:1}
        input,select{min-width:150px;padding:11px 12px;border:1px solid #cbd5e1;border-radius:8px;background:#fff;font:inherit;color:#172554}
        .btn{display:inline-flex;align-items:center;justify-content:center;padding:11px 15px;border:0;border-radius:8px;font:inherit;font-size:13px;font-weight:700;text-decoration:none;cursor:pointer}
        .primary{background:#4338ca;color:white}.soft{background:#e0e7ff;color:#3730a3}.primary:hover{background:#3730a3}
        .card{overflow:hidden;border:1px solid #e2e8f0;border-radius:15px;background:#fff;box-shadow:0 18px 45px #0f172a0e}
        .table-wrap{overflow-x:auto}table{width:100%;border-collapse:collapse;min-width:720px}
        th{padding:15px 17px;background:#f8fafc;color:#64748b;text-align:left;font-size:11px;letter-spacing:.8px;text-transform:uppercase}
        td{padding:15px 17px;border-top:1px solid #edf2f7;font-size:14px;vertical-align:middle}tbody tr:hover{background:#fafbff}
        .name{font-weight:700;color:#172554}.country{color:#475569}.actions{display:flex;gap:10px;white-space:nowrap}
        .action{text-decoration:none;font-size:13px;font-weight:700}.edit{color:#0369a1}.delete{color:#dc2626}
        .empty{padding:30px;text-align:center;color:#64748b}.error{margin:0 0 16px;padding:12px 14px;border-radius:8px;background:#fef2f2;color:#b91c1c}
        footer{margin-top:16px;color:#94a3b8;font-size:12px;text-align:right}
        @media(max-width:640px){body{padding:24px 12px}.filters{width:100%}.filters input,.filters select{flex:1;min-width:130px}.toolbar>.primary{width:100%}}
    </style>
</head>
<body>
<main>
    <header>
        <p class="eyebrow">User directory · JDBC</p>
        <h1>Quản lý người dùng</h1>
        <p class="intro">Quản lý dữ liệu User từ MySQL, lọc theo quốc gia và sắp xếp theo tên.</p>
    </header>

    <c:if test="${not empty errorMessage}">
        <div class="error"><c:out value="${errorMessage}"/></div>
    </c:if>

    <div class="toolbar">
        <form class="filters" action="${pageContext.request.contextPath}/users" method="GET">
            <input type="search" name="country" value="<c:out value='${country}'/>"
                   placeholder="Tìm theo quốc gia..." aria-label="Tìm theo quốc gia">
            <select name="sort" aria-label="Sắp xếp theo tên">
                <option value="ASC" <c:if test="${sort == 'ASC'}">selected</c:if>>Tên: A → Z</option>
                <option value="DESC" <c:if test="${sort == 'DESC'}">selected</c:if>>Tên: Z → A</option>
            </select>
            <button class="btn soft" type="submit">Lọc & sắp xếp</button>
            <a class="btn soft" href="${pageContext.request.contextPath}/users">Xóa lọc</a>
        </form>
        <a class="btn primary" href="${pageContext.request.contextPath}/users?action=create">+ Thêm User</a>
    </div>

    <section class="card">
        <div class="table-wrap">
            <table>
                <thead>
                    <tr><th>ID</th><th>Tên</th><th>Email</th><th>Quốc gia</th><th>Thao tác</th></tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${listUser}">
                    <tr>
                        <td><c:out value="${user.id}"/></td>
                        <td class="name"><c:out value="${user.name}"/></td>
                        <td><c:out value="${user.email}"/></td>
                        <td class="country"><c:out value="${user.country}"/></td>
                        <td><div class="actions">
                            <a class="action edit" href="${pageContext.request.contextPath}/users?action=edit&id=${user.id}">Sửa</a>
                            <a class="action delete" href="${pageContext.request.contextPath}/users?action=delete&id=${user.id}">Xóa</a>
                        </div></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listUser}">
                    <tr><td class="empty" colspan="5">Không tìm thấy người dùng phù hợp.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </section>
    <footer>User Management · MVC + Servlet + JSP + JDBC + MySQL</footer>
</main>
</body>
</html>
