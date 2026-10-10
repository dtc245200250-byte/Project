<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Xóa User</title>
<style>
*{box-sizing:border-box}body{min-height:100vh;margin:0;padding:24px;display:grid;place-items:center;font-family:Arial,sans-serif;background:#f8fafc;color:#172554}
.card{width:100%;max-width:500px;padding:34px;border:1px solid #e2e8f0;border-radius:16px;background:white;box-shadow:0 18px 45px #0f172a10}
h1{color:#b91c1c;font-size:25px;margin-top:0}.text{color:#64748b;line-height:1.6}.details{padding:16px;border-radius:9px;background:#f8fafc;line-height:1.9;overflow-wrap:anywhere}
.buttons{display:flex;gap:10px;margin-top:22px}.btn{flex:1;padding:12px;border:0;border-radius:8px;text-align:center;text-decoration:none;font:inherit;font-weight:700;cursor:pointer}.danger{background:#dc2626;color:white}.secondary{background:#e2e8f0;color:#172033}
</style>
</head>
<body><main class="card">
<h1>Xác nhận xóa User</h1><p class="text">Bạn có chắc chắn muốn xóa User này khỏi cơ sở dữ liệu?</p>
<div class="details"><strong>ID:</strong> <c:out value="${user.id}"/><br>
<strong>Tên:</strong> <c:out value="${user.name}"/><br>
<strong>Email:</strong> <c:out value="${user.email}"/><br>
<strong>Quốc gia:</strong> <c:out value="${user.country}"/></div>
<form action="${pageContext.request.contextPath}/users?action=delete" method="post">
<input type="hidden" name="id" value="<c:out value='${user.id}'/>">
<div class="buttons"><a class="btn secondary" href="${pageContext.request.contextPath}/users">Hủy</a><button class="btn danger" type="submit">Xác nhận xóa</button></div>
</form></main></body></html>
