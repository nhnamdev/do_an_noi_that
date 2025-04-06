<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>Quản Lí Tin Tức</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%--    <link rel="stylesheet" href="css/admin_style.css">--%>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <%--tesst--%>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport"/>
    <link rel="icon" href="assets/img/kaiadmin/favicon.ico" type="image/x-icon"/>
    <!-- Fonts and icons -->
    <script src="assets/js/plugin/webfont/webfont.min.js"></script>
    <script>
        WebFont.load({
            google: {families: ["Public Sans:300,400,500,600,700"]},
            custom: {
                families: [
                    "Font Awesome 5 Solid",
                    "Font Awesome 5 Regular",
                    "Font Awesome 5 Brands",
                    "simple-line-icons",
                ],
                urls: ["assets/css/fonts.min.css"],
            },
            active: function () {
                sessionStorage.fonts = true;
            },
        });
    </script>
    <!-- CSS Files -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="assets/css/plugins.min.css"/>
    <link rel="stylesheet" href="assets/css/kaiadmin.min.css"/>
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="assets/css/demo.css"/>
    <%--    tesst--%>
    <link rel="stylesheet" href="css/admin_style.css">
    <%--DATATABLE--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
    <%--DATATABLE--%>
    <%--    ck4--%>
    <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
</head>
<body>
<jsp:include page="sidebarMod.jsp"/>
<%--CONTENT MAIN ADMIN --%>
<div class="content">
    <div class="page-inner" id="main_contentt">
        <form style="gap: 0px" action="AddNewsServlet" method="post" enctype="multipart/form-data">
            <label>Tiêu đề:</label><br>
            <input type="text" name="title" required><br><br>

            <label>Mô tả:</label><br>
            <textarea name="description" rows="3"></textarea><br><br>

            <label>Nội dung chi tiết:</label><br>
            <textarea name="content" id="editor1"></textarea><br><br>

            <label>Ảnh:</label><br>
            <input type="file" name="image"><br><br>

            <input type="submit" value="Thêm bài viết">
        </form>
    </div>
    <%--END CONTENT MAIN ADMIN --%>
</div>
<!-- Khởi tạo CKEditor -->
<script>
    CKEDITOR.replace('editor1');
</script>

</body>
</html>
