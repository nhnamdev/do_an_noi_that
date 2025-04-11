<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tin Tức - Mona Decor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="css/news.css">
    <%--    Ck editor--%>
    <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
    <%--    Ck editor--%>
    <style>
        .banner-container {
            width: 280px;
            height: 280px;
            margin-top: 30px;
            overflow: hidden;
        }

        .banner-container img {
            width: 100%;
            height: 100%;
            animation: zoomFade 2s ease-in-out forwards;
            opacity: 0;
            border-radius: 20px;
            transform: scale(1.1);
        }

        @keyframes zoomFade {
            0% {
                opacity: 0;
                transform: scale(1.1);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }
    </style>
</head>
<body>
<jsp:include page="/components/header.jsp"/>
<div class="container" style="margin-top: 6.4rem">
    <div class="row">
        <div class="breadcrumb-wrapper">
            <div class="breadcrumb">
                <div class="container ">
                    <ul style=" padding-top: 14px;text-align: center;height: 54px;display: flex; background-color: #e8e8e8">
                        <li><a href="${pageContext.request.contextPath}/index">Trang chủ</a></li>
                        <li><i class="fas fa-angle-right"></i></li>
                        <li><a href="${pageContext.request.contextPath}/news.jsp">Tin Tức</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <!-- Sidebar -->
        <aside class="col-md-3 sidebar">
            <h5>Tìm kiếm</h5>
            <input type="text" class="form-control mb-3" placeholder="Tìm kiếm...">
            <h5>Chuyên mục</h5>
            <ul class="list-unstyled">
                <li><a href="${pageContext.request.contextPath}/news">Fashions magazine</a></li>
                <li><a href="${pageContext.request.contextPath}/news">Images</a></li>
                <li><a href="${pageContext.request.contextPath}/news">Life style</a></li>
                <li><a href="${pageContext.request.contextPath}/news">Photography</a></li>
                <li><a href="${pageContext.request.contextPath}/news">Style</a></li>
            </ul>
            <h5>Bài viết mới nhất</h5>
            <!-- bài viết mới nhất của mỗi danh mục -->
            <c:forEach var="news" items="${listNews}">
                <a href="NewDetailController?id=${news.news_id}"
                   class="text-decoration-none text-dark">
                    <div class="latest-post d-flex align-items-center mb-2">
                        <img src="img/tintuc/${news.image}" alt="">
                        <div class="ms-2">
                            <small style="max-width: 150px; display: inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                    ${news.title}
                            </small>
                            <p class="mb-0"
                               style="max-width: 200px; display: inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                    ${news.description}
                            </p>
                        </div>
                    </div>
                </a>
            </c:forEach>
            <div class="banner-container">
                <img src="img/img.png" width="340px" height="340px">
            </div>
            <!-- bài viết mới nhất của mỗi danh mục -->

        </aside>
        <!-- Main content -->
        <main class="col-md-9">
            <div class="row">
                <c:forEach var="news" items="${listNews}">
                    <div class="col-md-6 mb-4">
                        <div class="news">
                            <a href="NewDetailController?id=${news.news_id}" title="Funiture"
                               class="entry-image nasa-blog-img blog-image-attachment nasa-block">
                                <img width="400" height="380"
                                     src="img/tintuc/${news.image}"
                                     class="attachment-large size-large wp-post-image" alt="" decoding="async">
                                <div class="image-overlay"></div>
                            </a>
                            <h3>${news.title}</h3>
                            <p>
                                <small>
                                    <fmt:formatDate value="${news.createdAt}" pattern="dd MMMM, yyyy"/> - Nguyễn Hoàng
                                    Nam
                                </small>
                            </p>
                            <p>${news.description}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>
        <!-- Main content -->
    </div>
</div>
<jsp:include page="components/footer.jsp"/>


</body>
</html>
