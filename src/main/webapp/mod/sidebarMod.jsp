<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%--    <link rel="stylesheet" href="css/admin_style.css">--%>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <%--tesst--%>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport"/>
    <!-- Fonts and icons -->
    <script src="../assets/js/plugin/webfont/webfont.min.js"></script>
    <!-- CSS Files -->
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../assets/css/plugins.min.css"/>
    <link rel="stylesheet" href="../assets/css/kaiadmin.min.css"/>
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="../assets/css/demo.css"/>
    <%--    tesst--%>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_style.css">
    <%--DATATABLE--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
    <%--DATATABLE--%>
    <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
</head>
<body>
<div class="d-flex flex-column flex-shrink-0 p-3 bg-dark text-white position-fixed vh-100" style="width: 250px;">
    <a href="${pageContext.request.contextPath}/mod"
       class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
        <span class="fs-4 fw-bold">Mod</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/mod" class="nav-link text-white">
                <i class="fa fa-home me-2"></i> Trang chủ
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/mod/newsmanager" class="nav-link text-white">
                <i class="fa fa-newspaper me-2"></i> Quản lí Tin Tức
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/mod/khohang" class="nav-link text-white">
                <i class="fa fa-boxes me-2"></i> Kho hàng
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link text-white">
                <i class="fa fa-right-from-bracket"></i> Đăng xuất
            </a>
        </li>

    </ul>
</div>

</body>
</html>
