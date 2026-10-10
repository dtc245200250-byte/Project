<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Thêm User</title>
<style>
*{box-sizing:border-box}body{min-height:100vh;margin:0;padding:28px;display:grid;place-items:center;font-family:Arial,sans-serif;background:linear-gradient(135deg,#eef2ff,#f8fafc 60%,#ecfeff);color:#172554}
.card{width:100%;max-width:520px;padding:32px;border:1px solid #e2e8f0;border-radius:16px;background:#fff;box-shadow:0 18px 45px #0f172a10}
.eyebrow{color:#4f46e5;text-align:center;font-size:12px;font-weight:800;letter-spacing:1.4px;text-transform:uppercase}h1{margin:8px 0 24px;text-align:center;font-size:26px}
label{display:block;margin:16px 0 7px;font-size:14px;font-weight:700}input{width:100%;padding:12px;border:1px solid #cbd5e1;border-radius:8px;font:inherit}input:focus{outline:3px solid #c7d2fe;border-color:#6366f1}
.error{padding:12px;border-radius:8px;background:#fef2f2;color:#b91c1c;font-size:14px}.buttons{display:flex;gap:10px;margin-top:24px}.btn{flex:1;padding:12px;border:0;border-radius:8px;text-align:center;text-decoration:none;font:inherit;font-weight:700;cursor:pointer}
.primary{background:#168653;color:white}.secondary{background:#eef2ff;color:#3730a3}
</style>
</head>
<body><main class="card">
<p class="eyebrow">User directory</p><h1>Thêm User mới</h1>
<c:if test="${not empty errorMessage}"><div class="error"><c:out value="${errorMessage}"/></div></c:if>
<form action="${pageContext.request.contextPath}/users?action=create" method="post">
<label for="name">Tên</label><input id="name" name="name" maxlength="120" value="<c:out value='${param.name}'/>" required>
<label for="email">Email</label><input id="email" name="email" type="email" maxlength="220" value="<c:out value='${param.email}'/>" required>
<label for="country">Quốc gia</label><input id="country" name="country" maxlength="120" value="<c:out value='${param.country}'/>">
<div class="buttons"><a class="btn secondary" href="${pageContext.request.contextPath}/users">Hủy</a><button class="btn primary" type="submit">Lưu User</button></div>
</form></main></body></html>
