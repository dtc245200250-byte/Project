<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm ghi chú · iNotes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body><div class="shell">
    <nav class="topbar"><a class="brand" href="${pageContext.request.contextPath}/notes"><span class="brand-mark">i</span><span class="brand-name">iNotes<span class="brand-subtitle">Your space to remember</span></span></a><span class="type-pill">Tạo ghi chú</span></nav>
    <main class="panel form-panel">
        <header class="form-heading"><p class="eyebrow">Capture an idea</p><h1>Thêm ghi chú mới</h1><p class="lead">Một nơi nhỏ để lưu lại những điều quan trọng.</p></header>
        <c:if test="${not empty errorMessage}"><div class="alert"><c:out value="${errorMessage}"/></div></c:if>
        <form action="${pageContext.request.contextPath}/notes?action=create" method="post">
            <input type="hidden" name="storage" value="<c:out value='${sessionScope.noteStorage}'/>">
            <div class="field">
                <label for="title">Tiêu đề</label>
                <input id="title" name="title" maxlength="255" value="<c:out value='${param.title}'/>" placeholder="Ví dụ: Họp giao ban đầu tuần" required autofocus>
            </div>
            <div class="field">
                <label for="typeId">Phân loại</label>
                <select id="typeId" name="typeId" required>
                    <c:forEach var="type" items="${noteTypes}">
                        <option value="${type.id}" <c:if test="${param.typeId == type.id}">selected</c:if>><c:out value="${type.name}"/></option>
                    </c:forEach>
                </select>
            </div>
            <div class="field">
                <label for="content">Nội dung</label>
                <textarea id="content" name="content" placeholder="Viết ra điều bạn muốn ghi nhớ..."><c:out value="${param.content}"/></textarea>
                <span class="field-hint">Bạn có thể xuống dòng hoặc nhập nhiều đoạn nội dung.</span>
            </div>
            <div class="form-actions">
                <a class="button secondary" href="${pageContext.request.contextPath}/notes">Hủy bỏ</a>
                <button class="button" type="submit">Lưu ghi chú</button>
            </div>
        </form>
    </main>
</div></body></html>
