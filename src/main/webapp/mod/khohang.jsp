<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="sidebarMod.jsp"/>
<div class="content" style="margin-left: 20%">
    <!-- Modal -->
    <div class="modal fade" id="newsModal" tabindex="-1" role="dialog" aria-labelledby="newsModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document"> <!-- modal-lg để modal to ra -->
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm Sản Phẩm</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/mod/khohang" method="post"
                          enctype="multipart/form-data">
                        <div class="form-group">
                            <label>Tên sản phẩm:</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>

                        <div class="form-group">
                            <label>Giá bán:</label>
                            <input type="number" class="form-control" name="price" step="1000" min="0" required>
                        </div>

                        <div class="form-group">
                            <label>Số lượng tồn kho:</label>
                            <input type="number" class="form-control" name="stock" min="0" required>
                        </div>

                        <div class="form-group">
                            <label>Mô tả sản phẩm (nếu có):</label>
                            <textarea class="form-control" name="description" rows="4"></textarea>
                        </div>

                        <div class="form-group">
                            <label>Hình ảnh:</label>
                            <input type="file" class="form-control" name="image" accept="image/*" required>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary" style="width: auto; margin-right: 14px">
                                Thêm sản phẩm
                            </button>
                            <button type="button" class="btn btn-secondary" style="width: auto;"
                                    data-bs-dismiss="modal">
                                Đóng
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="card card-round">
                <div class="card-header">
                    <div class="card-head-row card-tools-still-right">
                        <div class="card-title">Quản lí SP</div>
                        <div class="card-tools">
                            <div class="dropdown" style="display: flex">
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newsModal">Thêm
                                    Sản Phẩm
                                </button>
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
                                <th scope="col">Mã SP</th>
                                <th scope="col" class="text-end">Tên SP</th>
                                <th scope="col" class="text-end">Giá Bán</th>
                                <th scope="col" class="text-end">Hình ảnh</th>
                                <th scope="col" class="text-end">Tồn Kho</th>
                                <th scope="col" class="text-end">Hành Động</th>
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach var="p" items="${listProduct}">
                                <tr>
                                    <th scope="row">
                                        <div style="max-width: 200px; display: inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                ${p.id}
                                        </div>
                                    </th>
                                    <td class="text-end">
                                        <div style="max-width: 500px; display: inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                ${p.name}
                                        </div>
                                    </td>
                                    <td class="text-end">
                                        <div style="max-width: 50px; display: inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                ${p.price}
                                        </div>
                                    </td>
                                    <td class="text-end"><img width="60" height="50"
                                                              src="${pageContext.request.contextPath}/img/sanpham/${p.img}"
                                                              class="attachment-large size-large wp-post-image" alt=""
                                                              decoding="async">
                                    </td>
                                    <td class="text-end">
                                        <span class="badge badge-success">${p.stock}</span>
                                    </td>
                                    <td class="text-end">
                                        <a class="badge badge-danger"
                                           href="${pageContext.request.contextPath}/mod/newsmanager/deleteNews?id=${news.news_id}"
                                           onclick="return confirm('Bạn có chắc chắn muốn xoá?')">Xóa</a>
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
<script>

    document.getElementById("btnShowForm").addEventListener("click", function () {
        var formDiv = document.getElementById("main_contentt");
        if (formDiv.style.display === "none") {
            formDiv.style.display = "block";
        } else {
            formDiv.style.display = "none";
        }
    });
</script>
</body>
</html>
