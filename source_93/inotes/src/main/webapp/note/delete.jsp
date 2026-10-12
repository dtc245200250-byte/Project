<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Xóa ghi chú · iNotes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body><div class="shell">
    <nav class="topbar"><a class="brand" href="${pageContext.request.contextPath}/notes"><span class="brand-mark">i</span><span class="brand-name">iNotes<span class="brand-subtitle">Your space to remember</span></span></a></nav>
    <main class="panel form-panel">
        <p class="eyebrow">Delete note</p>
        <h1>Xóa ghi chú này?</h1>
        <p class="lead">Thao tác này sẽ xóa ghi chú khỏi nguồn lưu trữ đang chọn.</p>
        <div style="margin:24px 0;padding:20px;border:1px solid #e6e9f3;border-radius:12px;background:#fcfcff">
            <h2 style="margin:0 0 10px;font-size:20px"><c:out value="${note.title}"/></h2>
            <div class="detail-meta"><span>ID #<c:out value="${note.id}"/></span>
                <c:forEach var="type" items="${noteTypes}">
                    <c:if test="${type.id == note.typeId}"><span class="type-pill type-${type.id}"><c:out value="${type.name}"/></span></c:if>
                </c:forEach>
            </div>
            <div class="content-box"><c:out value="${note.content}"/></div>
        </div>
        <form action="${pageContext.request.contextPath}/notes?action=delete" method="post">
            <input type="hidden" name="storage" value="<c:out value='${sessionScope.noteStorage}'/>">
            <input type="hidden" name="id" value="<c:out value='${note.id}'/>">
            <div class="form-actions"><a class="button secondary" href="${pageContext.request.contextPath}/notes">Hủy bỏ</a><button class="button danger" type="submit">Xác nhận xóa</button></div>
        </form>
    </main>
</div></body></html>
