<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết ghi chú · iNotes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body><div class="shell">
    <nav class="topbar"><a class="brand" href="${pageContext.request.contextPath}/notes"><span class="brand-mark">i</span><span class="brand-name">iNotes<span class="brand-subtitle">Your space to remember</span></span></a><span class="type-pill">Chi tiết ghi chú</span></nav>
    <main class="panel form-panel">
        <p class="eyebrow">Note details · #<c:out value="${note.id}"/></p>
        <h1><c:out value="${note.title}"/></h1>
        <div class="detail-meta">
            <c:forEach var="type" items="${noteTypes}">
                <c:if test="${type.id == note.typeId}"><span class="type-pill type-${type.id}"><c:out value="${type.name}"/></span></c:if>
            </c:forEach>
            <span>Lưu trong <c:out value="${sessionScope.noteStorage}"/></span>
        </div>
        <div class="content-box"><c:out value="${note.content}"/></div>
        <div class="form-actions" style="justify-content:space-between;margin-top:22px">
            <a class="button secondary" href="${pageContext.request.contextPath}/notes">← Danh sách</a>
            <a class="button" href="${pageContext.request.contextPath}/notes?action=edit&id=${note.id}">Sửa ghi chú</a>
        </div>
    </main>
</div></body></html>
