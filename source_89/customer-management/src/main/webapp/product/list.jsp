<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
    <style>
        :root{--ink:#172554;--muted:#64748b;--line:#e2e8f0;--primary:#4338ca;--bg:#f5f7ff}
        *{box-sizing:border-box}body{margin:0;padding:36px 22px;font-family:Arial,sans-serif;color:var(--ink);background:linear-gradient(135deg,#eef2ff,#f8fafc 55%,#ecfeff);min-height:100vh}
        .page{max-width:1180px;margin:0 auto}.eyebrow{margin:0 0 10px;color:var(--primary);font-size:12px;font-weight:800;letter-spacing:1.6px;text-transform:uppercase}
        h1{font-size:clamp(28px,4vw,38px);letter-spacing:-1px;margin:0}.subtitle{margin:10px 0 28px;color:var(--muted);line-height:1.6}
        .toolbar{display:flex;align-items:center;justify-content:space-between;gap:14px;flex-wrap:wrap;margin-bottom:18px}
        .search{display:flex;gap:9px;flex:1;max-width:560px}.search input{min-width:0;flex:1;padding:12px 14px;border:1px solid #cbd5e1;border-radius:9px;font:inherit;background:#fff}
        .btn{display:inline-flex;align-items:center;justify-content:center;padding:11px 15px;border:0;border-radius:9px;text-decoration:none;font:inherit;font-size:13px;font-weight:700;cursor:pointer}
        .btn-primary{background:var(--primary);color:#fff}.btn-primary:hover{background:#3730a3}.btn-quiet{background:#eef2ff;color:#3730a3}
        .table-card{overflow:hidden;border:1px solid var(--line);border-radius:16px;background:#fff;box-shadow:0 18px 48px rgba(15,23,42,.08)}
        .table-wrap{overflow-x:auto}table{width:100%;border-collapse:collapse;min-width:850px}thead{background:#f8fafc}
        th{padding:15px 18px;text-align:left;color:#64748b;font-size:11px;text-transform:uppercase;letter-spacing:.8px}td{padding:16px 18px;border-top:1px solid #edf2f7;font-size:14px;vertical-align:middle}
        tbody tr:hover{background:#fafbff}.product-name{font-weight:700;color:#172554;text-decoration:none}.product-name:hover{color:var(--primary)}
        .description{max-width:270px;color:#64748b;line-height:1.5}.price{font-weight:700;white-space:nowrap}.actions{display:flex;align-items:center;gap:10px;white-space:nowrap}
        .action-link{text-decoration:none;font-size:13px;font-weight:700}.view{color:#4338ca}.edit{color:#0369a1}.delete{color:#dc2626}.empty{padding:34px;text-align:center;color:var(--muted)}
        .result-note{color:var(--muted);font-size:13px;margin:0 0 12px}footer{margin-top:16px;color:#94a3b8;font-size:12px;text-align:right}
        @media(max-width:640px){body{padding:26px 12px}.search{max-width:none;width:100%}.toolbar .btn-primary{width:100%}.search .btn{padding:11px}}
    </style>
</head>
<body>
<main class="page">
    <header>
        <p class="eyebrow">Inventory workspace</p>
        <h1>Product Management</h1>
        <p class="subtitle">Manage products, review details, and search the catalog by product name.</p>
    </header>

    <div class="toolbar">
        <form class="search" action="${pageContext.request.contextPath}/products" method="GET">
            <input type="hidden" name="action" value="search">
            <input type="search" name="keyword" value="<c:out value='${keyword}'/>"
                   placeholder="Search products by name…" aria-label="Search products by name">
            <button class="btn btn-quiet" type="submit">Search</button>
            <c:if test="${not empty keyword}">
                <a class="btn btn-quiet" href="${pageContext.request.contextPath}/products">Clear</a>
            </c:if>
        </form>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/products?action=create">+ Add product</a>
    </div>

    <c:if test="${not empty keyword}">
        <p class="result-note">Search results for “<c:out value="${keyword}"/>”</p>
    </c:if>

    <section class="table-card">
        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th>ID</th><th>Product</th><th>Price</th><th>Manufacturer</th><th>Description</th><th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td><c:out value="${product.id}"/></td>
                        <td><a class="product-name" href="${pageContext.request.contextPath}/products?action=view&id=${product.id}"><c:out value="${product.name}"/></a></td>
                        <td class="price">$<c:out value="${product.price}"/></td>
                        <td><c:out value="${product.manufacturer}"/></td>
                        <td class="description"><c:out value="${product.description}"/></td>
                        <td>
                            <div class="actions">
                                <a class="action-link view" href="${pageContext.request.contextPath}/products?action=view&id=${product.id}">View</a>
                                <a class="action-link edit" href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}">Edit</a>
                                <a class="action-link delete" href="${pageContext.request.contextPath}/products?action=delete&id=${product.id}">Delete</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty products}">
                    <tr><td colspan="6" class="empty">No products found. Try another keyword or add a new product.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </section>
    <footer>Product Management · MVC with Servlet, JSP and JSTL</footer>
</main>
</body>
</html>
