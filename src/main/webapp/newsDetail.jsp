<%--
  Created by IntelliJ IDEA.
  User: Nam
  Date: 4/9/2025
  Time: 10:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title News - Mona Decor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="css/news.css">
    <%--    Ck editor--%>
    <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
    <%--    Ck editor--%>
    <style>
        #content p img {
            max-width: 900px;
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
                <li><a href="#">Fashions magazine</a></li>
                <li><a href="#">Images</a></li>
                <li><a href="#">Life style</a></li>
                <li><a href="#">Photography</a></li>
                <li><a href="#">Style</a></li>
            </ul>
            <h5>Bài viết mới nhất</h5>
            <!-- bài viết mới nhất của mỗi danh mục -->
            <div class="latest-post d-flex align-items-center mb-2">
                <img src="img/sofa1.jpg" alt="">
                <div class="ms-2">
                    <small>Fashions magazine</small>
                    <p class="mb-0">Beauty life style classic</p>
                </div>
            </div>
            <!-- bài viết mới nhất của mỗi danh mục -->
        </aside>
        <!-- Main content -->
        <main class="col-md-9">
            <div class="news">
                <div id="content">
                    ${news.content}
                </div>
            </div>
        </main>
        <!-- Main content -->
    </div>
</div>
<jsp:include page="components/footer.jsp"/>
</body>
</html>
