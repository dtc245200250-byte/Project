<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.finalexam.model.Product" %>
<%
List<Product> products = (List<Product>) request.getAttribute("products");
String msg = request.getParameter("message"), notice = "";
if ("added".equals(msg)) notice = "Thêm sản phẩm thành công.";
else if ("updated".equals(msg)) notice = "Cập nhật sản phẩm thành công.";
else if ("deleted".equals(msg)) notice = "Xóa sản phẩm thành công.";
%>
<!DOCTYPE html><html lang="vi"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Quản lý sản phẩm</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/style.css"></head>
<body><div class="container">
<header class="page-header"><div><p class="eyebrow">PRODUCT MANAGEMENT</p><h1>Quản lý sản phẩm</h1><p class="subtitle">Theo dõi và cập nhật kho sản phẩm của bạn.</p></div>
<a class="button primary" href="<%=request.getContextPath()%>/products?action=new">+ Thêm sản phẩm</a></header>
<% if (!notice.isEmpty()) { %><div class="alert success"><%=notice%></div><% } %>
<section class="panel"><div class="panel-heading"><h2>Danh sách sản phẩm</h2><p class="muted">Tổng số: <strong><%=products == null ? 0 : products.size()%></strong> sản phẩm</p></div>
<div class="table-wrap"><table><thead><tr><th>ID</th><th>Tên sản phẩm</th><th>Giá (₫)</th><th>Số lượng</th><th>Thao tác</th></tr></thead><tbody>
<% if (products == null || products.isEmpty()) { %><tr><td colspan="5" class="empty">Chưa có sản phẩm. Hãy thêm sản phẩm đầu tiên.</td></tr>
<% } else { for (Product p : products) { %><tr><td class="id-cell">#<%=p.getId()%></td><td class="product-name"><%=escapeHtml(p.getName())%></td><td><%=p.getPrice().toPlainString()%></td><td><span class="quantity"><%=p.getQuantity()%></span></td><td class="actions">
<a class="button small" href="<%=request.getContextPath()%>/products?action=edit&id=<%=p.getId()%>">Sửa</a>
<form class="inline-form" method="post" action="<%=request.getContextPath()%>/products" onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?');">
<input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<%=p.getId()%>"><button class="button small danger" type="submit">Xóa</button></form>
</td></tr><% } } %></tbody></table></div></section><footer>Ứng dụng quản lý sản phẩm · JSP & Servlet · JDBC / MySQL</footer></div></body></html>
<%! private String escapeHtml(String s) { if(s==null)return ""; return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("'","&#x27;"); } %>