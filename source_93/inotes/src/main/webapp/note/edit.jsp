<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sửa ghi chú · iNotes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body><div class="shell">
    <nav class="topbar"><a class="brand" href="${pageContext.request.contextPath}/notes"><span class="brand-mark">i</span><span class="brand-name">iNotes<span class="brand-subtitle">Your space to remember</span></span></a><span class="type-pill">Chỉnh sửa</span></nav>
    <main class="panel form-panel">
        <header class="form-heading"><p class="eyebrow">Refine your note</p><h1>Chỉnh sửa ghi chú</h1><p class="lead">Cập nhật nội dung rồi lưu thay đổi vào nguồn dữ liệu đang chọn.</p></header>
        <c:if test="${not empty errorMessage}"><div class="alert"><c:out value="${errorMessage}"/></div></c:if>
        <form action="${pageContext.request.contextPath}/notes?action=edit" method="post">
            <input type="hidden" name="storage" value="<c:out value='${sessionScope.noteStorage}'/>">
            <input type="hidden" name="id" value="<c:out value='${note.id}'/>">
            <div class="field"><label for="title">Tiêu đề</label><input id="title" name="title" maxlength="255" value="<c:out value='${note.title}'/>" required autofocus></div>
            <div class="field"><label for="typeId">Phân loại</label>
                <select id="typeId" name="typeId" required>
                    <c:forEach var="type" items="${noteTypes}">
                        <option value="${type.id}" <c:if test="${note.typeId == type.id}">selected</c:if>><c:out value="${type.name}"/></option>
                    </c:forEach>
                </select>
            </div>
            <div class="field"><label for="content">Nội dung</label><textarea id="content" name="content"><c:out value="${note.content}"/></textarea></div>
            <div class="form-actions"><a class="button secondary" href="${pageContext.request.contextPath}/notes?action=view&id=${note.id}">Hủy bỏ</a><button class="button" type="submit">Lưu thay đổi</button></div>
        </form>
    </main>
</div></body></html>
