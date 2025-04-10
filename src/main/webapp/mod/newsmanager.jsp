<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <%--    dâtatable--%>
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <!-- Buttons extension CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
</head>
<body>
<jsp:include page="sidebarMod.jsp"/>
<%--CONTENT MAIN ADMIN --%>
<div class="content">
    <div class="page-inner" id="main_contentt">
        <form style="gap: 0px" action="${pageContext.request.contextPath}/mod/newsmanager" method="post"
              enctype="multipart/form-data">
            <label>Tiêu đề:</label><br>
            <input type="text" name="title" required><br><br>

            <label>Mô tả:</label><br>
            <textarea name="description" rows="3" required></textarea><br><br>

            <label>Nội dung chi tiết:</label><br>
            <textarea name="content" id="editor1"></textarea><br><br>

            <label>Loại tin:</label><br>
            <select name="category_id" required>
                <option value="1">Fashions magazine</option>
                <option value="2">Images</option>
                <option value="3">Life style</option>
                <option value="4">Photography</option>
                <option value="5">Style</option>
            </select><br><br>

            <label>Ảnh:</label><br>
            <input type="file" name="image" required><br><br>

            <input type="submit" value="Thêm bài viết">
        </form>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card card-round">
                <div class="card-header">
                    <div class="card-head-row card-tools-still-right">
                        <div class="card-title">Quản lí tin tức</div>
                        <div class="card-tools">
                            <div class="dropdown">
                                <button id="btnExportPDF" class="btn btn-primary">Print</button>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <!-- Projects table -->
                        <table id="transactionTable" class="table align-items-center mb-0">

                            <thead class="thead-light">
                            <tr>
                                <th scope="col">Tiêu đề</th>
                                <th scope="col" class="text-end">Mô tả</th>
                                <th scope="col" class="text-end">Hình ảnh</th>
                                <th scope="col" class="text-end">Ngày tạo</th>
                                <th scope="col" class="text-end">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach var="news" items="${listNews}">
                                <tr>
                                    <th scope="row">
                                        <div style="max-width: 200px; display: inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                ${news.title}
                                        </div>
                                    </th>
                                    <td class="text-end">
                                        <div style="max-width: 600px; display: inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                ${news.description}
                                        </div>
                                    </td>
                                    <td class="text-end"><img width="60" height="50"
                                                              src="${pageContext.request.contextPath}/img/tintuc/${news.image}"
                                                              class="attachment-large size-large wp-post-image" alt=""
                                                              decoding="async">
                                    </td>
                                    <td class="text-end">
                                        <span class="badge badge-success">${news.createdAt}</span>
                                    </td>
                                    <td class="text-end">
                                            <%--     Chua xu li--%>
                                        <a class="badge badge-danger" href="mod/newsmanager/${news.news_id}">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--END CONTENT MAIN ADMIN --%>
</div>
<!-- Khởi tạo CKEditor -->
<script>
    CKEDITOR.replace('editor1');

    $(document).ready(function () {
        var table = $('#transactionTable').DataTable({
            dom: 'Bfrtip', // B: Buttons, f: filter, r: processing, t: table, i: info, p: pagination
            buttons: [
                {
                    extend: 'pdfHtml5',
                    title: 'Transaction History',
                    exportOptions: {
                        columns: ':visible'
                    }
                },
                {
                    extend: 'print',
                    title: 'Transaction History',
                    exportOptions: {
                        columns: ':visible'
                    }
                }
            ]
        });
    });
</script>

</body>
</html>
