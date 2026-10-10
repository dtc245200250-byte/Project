<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Not Found</title>
<style>
*{box-sizing:border-box}body{min-height:100vh;margin:0;padding:24px;display:grid;place-items:center;font-family:Arial,sans-serif;background:#f8fafc;color:#172554}
.card{max-width:520px;width:100%;padding:40px;border:1px solid #e2e8f0;border-radius:18px;background:#fff;box-shadow:0 18px 48px #0f172a12;text-align:center}
.code{font-size:54px;font-weight:900;color:#dc2626;letter-spacing:-2px}h1{margin:8px 0 12px;font-size:25px}.message{color:#64748b;line-height:1.7}.btn{display:inline-block;margin-top:20px;padding:12px 18px;border-radius:9px;background:#4338ca;color:#fff;text-decoration:none;font-weight:700}
</style>
</head>
<body>
<main class="card">
    <div class="code">404</div>
    <h1>Product not found</h1>
    <p class="message"><c:out value="${errorMessage}"/></p>
    <a class="btn" href="${pageContext.request.contextPath}/products">Back to product list</a>
</main>
</body>
</html>
