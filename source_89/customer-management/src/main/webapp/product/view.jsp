<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Details</title>
<style>
*{box-sizing:border-box}body{min-height:100vh;margin:0;padding:28px;display:grid;place-items:center;font-family:Arial,sans-serif;background:linear-gradient(135deg,#eef2ff,#f8fafc 58%,#ecfeff);color:#172554}
.card{width:100%;max-width:620px;padding:36px;border:1px solid #e2e8f0;border-radius:18px;background:#fff;box-shadow:0 20px 55px #0f172a16}
.eyebrow{margin:0 0 9px;color:#4f46e5;text-align:center;font-size:12px;font-weight:800;letter-spacing:1.5px;text-transform:uppercase}h1{text-align:center;margin:0 0 8px;font-size:28px;overflow-wrap:anywhere}.id{text-align:center;color:#94a3b8;font-size:13px;margin:0 0 26px}
.price{padding:22px;border-radius:12px;background:#eef2ff;color:#3730a3;text-align:center;font-size:30px;font-weight:800;margin-bottom:24px}
.row{display:grid;grid-template-columns:150px 1fr;gap:16px;padding:15px 0;border-bottom:1px solid #edf2f7;line-height:1.6;overflow-wrap:anywhere}.label{color:#64748b;font-size:14px}.value{color:#172554;font-weight:600;white-space:pre-wrap}
.actions{display:flex;gap:10px;margin-top:26px}.btn{flex:1;padding:12px;border-radius:8px;text-align:center;text-decoration:none;font-size:14px;font-weight:700}.primary{background:#4338ca;color:#fff}.secondary{background:#eef2ff;color:#3730a3}.danger{background:#fee2e2;color:#b91c1c}
@media(max-width:480px){.row{grid-template-columns:1fr;gap:4px}.card{padding:24px}.actions{flex-wrap:wrap}}
</style>
</head>
<body>
<main class="card">
    <p class="eyebrow">Product catalog</p>
    <h1><c:out value="${product.name}"/></h1>
    <p class="id">Product ID: <c:out value="${product.id}"/></p>
    <div class="price">$<c:out value="${product.price}"/></div>
    <div class="row"><div class="label">Manufacturer</div><div class="value"><c:out value="${product.manufacturer}"/></div></div>
    <div class="row"><div class="label">Description</div><div class="value"><c:out value="${product.description}"/></div></div>
    <div class="actions">
        <a class="btn secondary" href="${pageContext.request.contextPath}/products">Back to list</a>
        <a class="btn primary" href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}">Edit</a>
        <a class="btn danger" href="${pageContext.request.contextPath}/products?action=delete&id=${product.id}">Delete</a>
    </div>
</main>
</body>
</html>
