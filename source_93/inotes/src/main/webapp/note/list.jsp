<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>iNotes · Ghi chú của bạn</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<div class="shell">
    <nav class="topbar">
        <a class="brand" href="${pageContext.request.contextPath}/notes">
            <span class="brand-mark">i</span>
            <span class="brand-name">iNotes<span class="brand-subtitle">Your space to remember</span></span>
        </a>
        <span class="type-pill">Personal workspace</span>
    </nav>

    <section class="heading-row">
        <div>
            <p class="eyebrow">Notes dashboard</p>
            <h1>Những điều cần nhớ.</h1>
            <p class="lead">Ghi lại ý tưởng, sắp xếp theo danh mục và tìm nhanh thông tin của bạn.</p>
        </div>
        <a class="button" href="${pageContext.request.contextPath}/notes?action=create">＋ Thêm ghi chú</a>
    </section>

    <c:if test="${not empty errorMessage}">
        <div class="alert"><c:out value="${errorMessage}"/></div>
    </c:if>

    <section class="storage-card">
        <div>
            <span class="storage-title">Nguồn lưu trữ</span>
            <span class="storage-help">Chuyển đổi Strategy lúc chạy. Dữ liệu hai nguồn được lưu riêng.</span>
        </div>
        <form class="storage-form" action="${pageContext.request.contextPath}/notes" method="get">
            <select name="storage" aria-label="Nguồn lưu trữ">
                <option value="DB" <c:if test="${sessionScope.noteStorage == 'DB'}">selected</c:if>>MySQL database</option>
                <option value="FILE" <c:if test="${sessionScope.noteStorage == 'FILE'}">selected</c:if>>File TXT</option>
            </select>
            <button class="button secondary" type="submit">Áp dụng</button>
        </form>
    </section>

    <form class="filters" action="${pageContext.request.contextPath}/notes" method="get">
        <input type="hidden" name="storage" value="<c:out value='${sessionScope.noteStorage}'/>">
        <input type="search" name="q" value="<c:out value='${keyword}'/>" placeholder="Tìm trong tiêu đề hoặc nội dung..." aria-label="Tìm kiếm ghi chú">
        <button class="button" type="submit">⌕ Tìm kiếm</button>
        <a class="button secondary" href="${pageContext.request.contextPath}/notes?storage=${sessionScope.noteStorage}">Đặt lại</a>
    </form>

    <section class="panel">
        <div class="table-wrap">
            <table>
                <thead><tr><th>#</th><th>Ghi chú</th><th>Phân loại</th><th>Thao tác</th></tr></thead>
                <tbody>
                <c:forEach var="note" items="${notes}" varStatus="loop">
                    <tr>
                        <td><c:out value="${loop.count}"/></td>
                        <td>
                            <a class="note-title" href="${pageContext.request.contextPath}/notes?action=view&id=${note.id}"><c:out value="${note.title}"/></a>
                            <span class="note-preview"><c:out value="${note.content}"/></span>
                        </td>
                        <td>
                            <c:forEach var="type" items="${noteTypes}">
                                <c:if test="${type.id == note.typeId}">
                                    <span class="type-pill type-${type.id}"><c:out value="${type.name}"/></span>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <div class="actions">
                                <a class="action view" href="${pageContext.request.contextPath}/notes?action=view&id=${note.id}">Xem</a>
                                <a class="action edit" href="${pageContext.request.contextPath}/notes?action=edit&id=${note.id}">Sửa</a>
                                <a class="action delete" href="${pageContext.request.contextPath}/notes?action=delete&id=${note.id}">Xóa</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty notes}">
                    <tr><td class="empty" colspan="4">Chưa có ghi chú phù hợp. Hãy thêm ghi chú đầu tiên của bạn.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <div class="countline">
            <span><c:out value="${notes.size()}"/> ghi chú</span>
            <span>Lưu bằng: <c:out value="${sessionScope.noteStorage}"/></span>
        </div>
    </section>
    <footer class="page-foot">iNotes · MVC · Strategy Pattern</footer>
</div>
</body>
</html>
