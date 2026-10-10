<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="nameValue" value="${product.name}"/>
<c:set var="priceValue" value="${product.price}"/>
<c:set var="manufacturerValue" value="${product.manufacturer}"/>
<c:set var="descriptionValue" value="${product.description}"/>
<c:if test="${not empty param.name}"><c:set var="nameValue" value="${param.name}"/></c:if>
<c:if test="${not empty param.price}"><c:set var="priceValue" value="${param.price}"/></c:if>
<c:if test="${not empty param.manufacturer}"><c:set var="manufacturerValue" value="${param.manufacturer}"/></c:if>
<c:if test="${not empty param.description}"><c:set var="descriptionValue" value="${param.description}"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Product</title>
<style>
*{box-sizing:border-box}body{min-height:100vh;margin:0;padding:28px;display:grid;place-items:center;font-family:Arial,sans-serif;background:linear-gradient(135deg,#eef2ff,#f8fafc 58%,#ecfeff);color:#172554}
.card{width:100%;max-width:570px;padding:34px;border:1px solid #e2e8f0;border-radius:17px;background:#fff;box-shadow:0 20px 55px #0f172a16}
.eyebrow{margin:0 0 9px;text-align:center;color:#4f46e5;font-size:12px;font-weight:800;letter-spacing:1.5px;text-transform:uppercase}h1{margin:0 0 24px;text-align:center;font-size:27px}
.id{margin:-10px 0 20px;color:#64748b;text-align:center;font-size:13px}label{display:block;margin:16px 0 7px;font-size:14px;font-weight:700}
input,textarea{width:100%;padding:12px 13px;border:1px solid #cbd5e1;border-radius:8px;font:inherit}textarea{min-height:100px;resize:vertical}input:focus,textarea:focus{outline:3px solid #c7d2fe;border-color:#6366f1}
.error{padding:12px 14px;border-radius:8px;background:#fef2f2;color:#b91c1c;font-size:14px;line-height:1.5}.buttons{display:flex;gap:10px;margin-top:24px}
.btn{flex:1;padding:12px;border:0;border-radius:8px;text-align:center;text-decoration:none;font:inherit;font-weight:700;cursor:pointer}.primary{background:#4338ca;color:#fff}.secondary{background:#eef2ff;color:#3730a3}
</style>
</head>
<body>
<main class="card">
    <p class="eyebrow">Product catalog</p><h1>Edit product</h1>
    <p class="id">Product ID: <c:out value="${product.id}"/></p>
    <c:if test="${not empty errorMessage}"><div class="error"><c:out value="${errorMessage}"/></div></c:if>
    <form action="${pageContext.request.contextPath}/products?action=update" method="POST">
        <input type="hidden" name="id" value="<c:out value='${product.id}'/>">
        <label for="name">Product name</label>
        <input id="name" name="name" type="text" maxlength="120" value="<c:out value='${nameValue}'/>" required>
        <label for="price">Price (USD)</label>
        <input id="price" name="price" type="number" min="0" step="0.01" value="<c:out value='${priceValue}'/>" required>
        <label for="manufacturer">Manufacturer</label>
        <input id="manufacturer" name="manufacturer" type="text" maxlength="120" value="<c:out value='${manufacturerValue}'/>" required>
        <label for="description">Description</label>
        <textarea id="description" name="description" maxlength="1000"><c:out value="${descriptionValue}"/></textarea>
        <div class="buttons"><a class="btn secondary" href="${pageContext.request.contextPath}/products">Cancel</a><button class="btn primary" type="submit">Save changes</button></div>
    </form>
</main>
</body>
</html>
