<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Delete Product</title>
<style>
*{box-sizing:border-box}body{min-height:100vh;margin:0;padding:24px;display:grid;place-items:center;font-family:Arial,sans-serif;background:#f8fafc;color:#172554}
.card{width:100%;max-width:510px;padding:36px;border:1px solid #e2e8f0;border-radius:18px;background:#fff;box-shadow:0 18px 48px #0f172a12;text-align:center}
.icon{width:58px;height:58px;margin:0 auto 18px;display:grid;place-items:center;border-radius:50%;background:#fee2e2;color:#b91c1c;font-size:27px;font-weight:800}
h1{margin:0 0 12px;font-size:25px}.copy{color:#64748b;line-height:1.6}.product{margin:22px 0;padding:18px;border-radius:10px;background:#f8fafc;text-align:left;line-height:1.8}.label{color:#64748b}.buttons{display:flex;gap:10px;margin-top:22px}
.btn{flex:1;padding:12px;border:0;border-radius:8px;text-decoration:none;font:inherit;font-weight:700;cursor:pointer}.danger{background:#dc2626;color:#fff}.cancel{background:#eef2ff;color:#3730a3}
</style>
</head>
<body>
<main class="card">
    <div class="icon">!</div><h1>Delete this product?</h1>
    <p class="copy">This will remove the product from the in-memory catalog. This action cannot be undone after the request is submitted.</p>
    <div class="product">
        <div><span class="label">ID:</span> <strong><c:out value="${product.id}"/></strong></div>
        <div><span class="label">Name:</span> <strong><c:out value="${product.name}"/></strong></div>
        <div><span class="label">Manufacturer:</span> <c:out value="${product.manufacturer}"/></div>
        <div><span class="label">Price:</span> $<c:out value="${product.price}"/></div>
    </div>
    <form action="${pageContext.request.contextPath}/products?action=delete" method="POST">
        <input type="hidden" name="id" value="<c:out value='${product.id}'/>">
        <div class="buttons">
            <a class="btn cancel" href="${pageContext.request.contextPath}/products">Cancel</a>
            <button class="btn danger" type="submit">Delete product</button>
        </div>
    </form>
</main>
</body>
</html>
