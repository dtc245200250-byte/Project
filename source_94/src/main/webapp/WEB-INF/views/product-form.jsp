<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.finalexam.model.Product" %>
<%
Product product = (Product)request.getAttribute("product");
if(product == null) product = new Product();
boolean editMode = Boolean.TRUE.equals(request.getAttribute("editMode"));
String error = (String)request.getAttribute("error");
%>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title><%=editMode?"Cập nhật":"Thêm"%> sản phẩm</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/style.css"></head>
<body><div class="container form-container"><a class="back-link" href="<%=request.getContextPath()%>/products">← Quay lại danh sách</a>
<section class="panel form-panel"><p class="eyebrow"><%=editMode?"EDIT PRODUCT":"NEW PRODUCT"%></p><h1><%=editMode?"Cập nhật sản phẩm":"Thêm sản phẩm mới"%></h1><p class="subtitle">Điền đầy đủ thông tin bên dưới.</p>
<% if(error != null) { %><div class="alert error"><%=error%></div><% } %>
<form method="post" action="<%=request.getContextPath()%>/products" class="product-form">
<input type="hidden" name="action" value="<%=editMode?"update":"insert"%>">
<% if(editMode) { %><input type="hidden" name="id" value="<%=product.getId()%>"><% } %>
<label for="name">Tên sản phẩm</label><input id="name" name="name" type="text" maxlength="150" required value="<%=escapeHtml(product.getName())%>" placeholder="Ví dụ: Bàn phím cơ">
<div class="field-grid"><div><label for="price">Giá (₫)</label><input id="price" name="price" type="number" min="0" step="0.01" required value="<%=product.getPrice()==null?"":product.getPrice().toPlainString()%>" placeholder="250000"></div>
<div><label for="quantity">Số lượng</label><input id="quantity" name="quantity" type="number" min="0" step="1" required value="<%=editMode?product.getQuantity():""%>" placeholder="10"></div></div>
<div class="form-actions"><a class="button" href="<%=request.getContextPath()%>/products">Hủy</a><button class="button primary" type="submit"><%=editMode?"Lưu thay đổi":"Thêm sản phẩm"%></button></div>
</form></section></div></body></html>
<%! private String escapeHtml(String s) { if(s==null)return ""; return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("'","&#x27;"); } %>