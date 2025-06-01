<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa hàng</title>
    <link rel="stylesheet" href="css/shop_styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
<div class="wrapper">
    <jsp:include page="/components/header.jsp"/>
    <div id="content">
        <div class="container">
            <div class="overlay" id="overlay"></div>
            <div class="content_section_1">
                <div class="breadcrumb-wrapper">
                    <div class="breadcrumb">
                        <div class="container">
                            <ul>
                                <li><a href="index">Trang chủ</a></li>
                                <li><i class="fas fa-angle-right"></i></li>
                                <li>Tất cả sản phẩm</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="sort-feature">
                    <div class="sort-dropdown">
                        <div class="sort-btn">
                            Sắp xếp theo <span class="arrow-down"></span>
                        </div>
                        <div class="sort-dropdown-content">
                            <a href="#" class="active">Mặc định</a>
                            <a href="#">Phổ biến nhất</a>
                            <a href="#">Mới nhất</a>
                            <a href="#">Giá: Tăng dần</a>
                            <a href="#">Giá: Giảm dần</a>
                        </div>
                    </div>
                </div>
                <div class="shop-container">
                    <!-- Sidebar-->
                    <div class="sidebar">
                        <div class="filter-box">
                            <h3>Danh mục sản phẩm</h3>
                            <ul class="category-list">
                                <li class="category-item">
                                    <div class="category-header">
                                        <span>PHÒNG NGỦ</span>
                                        <i class="fa-solid fa-chevron-right"></i>
                                    </div>
                                    <ul class="subcategory">
                                        <li class="subcategory-item">
                                            <a href="">Giường ngủ</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Tủ đầu giường</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Tủ quần áo</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Bộ phòng ngủ</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="category-item">
                                    <div class="category-header">
                                        <span>PHÒNG KHÁCH</span>
                                        <i class="fa-solid fa-chevron-right"></i>
                                    </div>
                                    <ul class="subcategory">
                                        <li class="subcategory-item">
                                            <a href="">Sofa & Ghế</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Bàn trà</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Kệ tivi</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Bộ phòng khách</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="category-item">
                                    <div class="category-header">
                                        <span>PHÒNG ĂN</span>
                                        <i class="fa-solid fa-chevron-right"></i>
                                    </div>
                                    <ul class="subcategory">
                                        <li class="subcategory-item">
                                            <a href="">Bàn ăn</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Ghế ăn</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Tủ bếp & Tủ rượu</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Bộ bàn ăn</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="category-item">
                                    <div class="category-header">
                                        <span>VĂN PHÒNG</span>
                                        <i class="fa-solid fa-chevron-right"></i>
                                    </div>
                                    <ul class="subcategory">
                                        <li class="subcategory-item">
                                            <a href="">Bàn làm việc</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Ghế văn phòng</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Kệ sách</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="category-item">
                                    <div class="category-header">
                                        <span>TRANG TRÍ</span>
                                        <i class="fa-solid fa-chevron-right"></i>
                                    </div>
                                    <ul class="subcategory">
                                        <li class="subcategory-item">
                                            <a href="">Đèn trang trí</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Thảm</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Gối trang trí</a>
                                        </li>
                                        <li class="subcategory-item">
                                            <a href="">Trang trí tường</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="filter-box price-filter">
                            <h3>Chọn khoảng giá</h3>
                            <div class="price-range-options">
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="0-1m">
                                    <span>Dưới 1 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="1m-2m">
                                    <span>Từ 1 triệu - 2 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="2m-3m">
                                    <span>Từ 2 triệu - 3 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="3m-5m">
                                    <span>Từ 3 triệu - 5 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="5m+">
                                    <span>Trên 5 triệu</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <!-- Danh sách sản phẩm -->
                    <div class="product-list">
                        <div class="container-fluid">
                            <div class="row">
                                <!-- Neu khong co san pham de hien thi && user vao che do favourite  -->
                                <c:if test="${empty listPagination and onlyFavorite == 'true'}">
                                    <div class="alert alert-info text-center mt-4" style="width: 100%;">
                                        <h5>Không có sản phẩm yêu thích nào.</h5>
                                    </div>
                                </c:if>
                                <c:forEach items="${listPagination}" var="p">
                                    <div class="col-sm-3 p-3 col-md-3">
                                        <div class="product-block">
                                            <div class="product-tumb">
                                                <span class="discount-percent">-5%</span>
                                                <a href="detail?pId=${p.id}">
                                                    <img src="${p.img}" alt="${p.name}" loading="lazy">
                                                </a>
                                                <c:choose>
                                                    <c:when test="${favoriteProductIds.contains(p.id)}">
                                                        <span class="favorite-product" title="Bỏ khỏi yêu thích"
                                                              data-product-id="${p.id}">
                                                            <i class="fa-solid fa-heart"></i>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="favorite-product" title="Thêm vào yêu thích"
                                                              data-product-id="${p.id}">
                                                            <i class="fa-regular fa-heart"></i>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="product-detail">
                                                <h4>
                                                    <a href="detail?pId=${p.id}">${p.name}</a>
                                                </h4>
                                                <div class="product-bottom_detail">
                                                    <div class="price">
                                                        <span class="original-price">600.000đ</span>
                                                        <span class="discount-price">${p.formattedPrice}đ</span>
                                                    </div>
                                                    <div class="product-actions">
                                                        <button class="add-to-cart-btn">
                                                            <i class="fa fa-shopping-cart">
                                                            </i> Thêm vào giỏ
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <%-- phan trang--%>
                        <div class="pagination">
                            <ul class="pagination-container">
                                <li class="pagination-item">
                                    <a href="#" class="pagination-link pagination-prev" aria-label="Previous page">
                                        <i class="fa-solid fa-angle-left"></i>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${endP}" var="i">
                                    <li class="pagination-item">
                                        <a href="shop?index=${i}"
                                           class="pagination-link ${param.index == i || (empty param.index && i == 1) ? 'active' : ''}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="pagination-item">
                                    <a href="#" class="pagination-link pagination-next" aria-label="Next page">
                                        <i class="fa-solid fa-angle-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="components/footer.jsp"/>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".favorite-product").forEach(function (element) {
            element.addEventListener("click", function () {
                const span = this;
                const productId = span.getAttribute("data-product-id");
                const url = `${pageContext.request.contextPath}/addToFavorites`;
                fetch(url, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: new URLSearchParams({
                        productId: productId
                    })
                })
                    .then(response => response.json())
                    .then(data => {
                        console.log(data);
                        if (data.success) {
                            // Kiểm tra action trả về từ server để biết là thêm hay xóa yêu thích
                            if (data.action === "added") {
                                span.classList.add("active");
                                span.setAttribute("title", "Bỏ khỏi yêu thích");
                                span.innerHTML = `<i class="fa-solid fa-heart"></i>`;
                            } else if (data.action === "deleted") {
                                span.classList.remove("active");
                                span.setAttribute("title", "Thêm vào yêu thích");
                                span.innerHTML = `<i class="fa-regular fa-heart"></i>`;
                            }
                        } else {
                            alert(data.message || "Đã có lỗi xảy ra.");
                        }
                    })
                    .catch(error => {
                        console.error("Lỗi:", error);
                        alert("Đã có lỗi xảy ra khi kết nối server.");
                    });
            });
        });
    });
</script>
<script src="js/shop.js"></script>
</body>
</html>