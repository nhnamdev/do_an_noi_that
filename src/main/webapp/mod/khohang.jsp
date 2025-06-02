<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Kho Hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Bundle JS (bao gồm cả Popper.js) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<jsp:include page="sidebarMod.jsp"/>

<div class="content" style="margin-left: 20%">
    <c:if test="${not empty sessionScope.successMessage}">
        <div id="successAlert" class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>

    <!-- Modal -->
    <div class="modal fade" id="newsModal" tabindex="-1" role="dialog" aria-labelledby="newsModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/mod/khohang" method="post"
                      enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm Sản Phẩm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Tên sản phẩm:</label>
                                <input type="text" class="form-control" name="name" required>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label">Giá bán:</label>
                                <input type="number" class="form-control" name="price" step="1000" min="0" required>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label">Tồn kho:</label>
                                <input type="number" class="form-control" name="stock" min="0" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Chất liệu:</label>
                                <input type="text" class="form-control" name="material">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Thương hiệu:</label>
                                <input type="text" class="form-control" name="brand">
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Màu sắc:</label>
                                <input type="text" class="form-control" name="color">
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Chiều dài (cm):</label>
                                <input type="number" step="0.1" class="form-control" name="length">
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Chiều rộng (cm):</label>
                                <input type="number" step="0.1" class="form-control" name="width">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Chiều cao (cm):</label>
                                <input type="number" step="0.1" class="form-control" name="height">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Trọng lượng (kg):</label>
                                <input type="number" step="0.1" class="form-control" name="weight">
                            </div>

                            <div class="col-12">
                                <label class="form-label">Tính năng nổi bật:</label>
                                <input type="text" class="form-control" name="feature">
                            </div>

                            <div class="col-12">
                                <label class="form-label">Mô tả sản phẩm:</label>
                                <textarea class="form-control" name="description" rows="3"></textarea>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Hình ảnh chính:</label>
                                <input type="file" class="form-control" name="image" accept="image/*" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Hình ảnh phụ (tùy chọn):</label>
                                <input type="file" class="form-control" name="images" accept="image/*" multiple>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">Thêm sản phẩm</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </form>
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
                                        <div style="max-width: 300px !important; display: inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                ${p.name}
                                        </div>
                                    </td>
                                    <td class="text-end">
                                        <div style="max-width: 100px !important; display: inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                            <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/> VND
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
                                        <a href="#" class="badge badge-warning"
                                           onclick="openAddStockModal(${p.id}); return false;">Thêm hàng</a>
                                        <a class="badge badge-danger"
                                           href="${pageContext.request.contextPath}/mod/newsmanager/xoasanpham?id=${p.id}"
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
<!-- Modal Thêm hàng -->
<div class="modal fade" id="addStockModal" tabindex="-1" aria-labelledby="addStockModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form id="addStockForm" method="get" action="${pageContext.request.contextPath}/mod/newsmanager/themtonkho">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm số lượng tồn kho</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="id" id="productIdInput">
                    <label for="amountInput" class="form-label">Nhập số lượng:</label>
                    <input type="number" min="1" class="form-control" name="amount" id="amountInput" required>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                </div>
            </div>
        </form>
    </div>
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
<script>
    setTimeout(function () {
        const alert = document.getElementById("successAlert");
        if (alert) {
            // Fade out bằng Bootstrap class rồi xoá
            alert.classList.remove("show");
            alert.classList.add("fade");
            setTimeout(() => alert.remove(), 500); // chờ hiệu ứng xong mới remove
        }
    }, 2000); // 2 giây
</script>
<script>
    function openAddStockModal(productId) {
        const productIdInput = document.getElementById('productIdInput');
        productIdInput.value = productId;

        const addStockModal = new bootstrap.Modal(document.getElementById('addStockModal'));
        addStockModal.show();
    }
</script>


</body>
</html>
