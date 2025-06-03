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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="wrapper">
    <jsp:include page="/components/header.jsp"/>
    <div id="content">
        <div class="container">
            <div class="overlay" id="overlay"></div>
            <div class="info-box" id="infoBox">
                <div class="container">
                    <h3>Thông tin giỏ hàng</h3>
                    <div class="listProduct">
                        <c:choose>
                            <c:when test="${not empty sessionScope.cartProducts}">
                                <c:forEach var="item" items="${sessionScope.cartProducts}">
                                    <div class="row1">
                                        <div class="alpha">
                                            <img src="${item.image}" alt="">
                                        </div>
                                        <div class="omega">
                                            <div class="name">${item.name}</div>
                                            <div class="sumPrice">
                                                <div class="quantity">${item.quantity} X</div>
                                                <div class="price">${item.price * item.quantity}đ</div>
                                            </div>
                                        </div>
                                        <div class="beta">
                                            <button class="close-button">
                                                <i class="fa fa-times-circle"></i>
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-cart">Giỏ hàng của bạn đang trống.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="totalPrice">
                        <div class="title">Tổng tiền</div>
                        <div class="price"></div>
                    </div>
                    <div class="other_choose">
                        <button class="view_cart" onclick="window.location.href='cart.jsp'">Giỏ hàng</button>
                        <button class="check_out" onclick="window.location.href='cartCheckout.jsp'">Thanh toán</button>
                    </div>
                </div>
            </div>
            <script src="js/showCart.js"></script>
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
                            <span id="sortLabel">
                                <c:choose>
                                    <c:when test="${currentSortBy == 'price_asc'}">Giá: Tăng dần</c:when>
                                    <c:when test="${currentSortBy == 'price_desc'}">Giá: Giảm dần</c:when>
                                    <c:when test="${currentSortBy == 'popular'}">Phổ biến nhất</c:when>
                                    <c:when test="${currentSortBy == 'newest'}">Mới nhất</c:when>
                                    <c:when test="${currentSortBy == 'name'}">Tên A-Z</c:when>
                                    <c:otherwise>Sắp xếp theo: Mặc định</c:otherwise>
                                </c:choose>
                            </span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="sort-dropdown-content">
                            <a href="#" data-sort="" class="${empty currentSortBy ? 'active' : ''}">Mặc định</a>
                            <a href="#" data-sort="popular" class="${currentSortBy == 'popular' ? 'active' : ''}">Phổ
                                biến nhất</a>
                            <a href="#" data-sort="newest" class="${currentSortBy == 'newest' ? 'active' : ''}">Mới
                                nhất</a>
                            <a href="#" data-sort="price_asc" class="${currentSortBy == 'price_asc' ? 'active' : ''}">Giá:
                                Tăng dần</a>
                            <a href="#" data-sort="price_desc" class="${currentSortBy == 'price_desc' ? 'active' : ''}">Giá:
                                Giảm dần</a>
                            <a href="#" data-sort="name" class="${currentSortBy == 'name' ? 'active' : ''}">Tên A-Z</a>
                        </div>
                    </div>
                </div>
                <div class="shop-container">
                    <!-- Sidebar-->
                    <div class="sidebar">
                        <div class="filter-box">
                            <a href="#" class="clear-filters" onclick="clearAllFilters()">
                                <i class="fas fa-times"></i> Xóa tất cả bộ lọc
                            </a>

                            <!-- Hiển thị active filters -->
                            <div class="active-filters" id="activeFilters">
                                <c:if test="${selectedCategoryId != null && selectedCategoryId > 0}">
                                    <div class="filter-badge">
                                        <c:forEach var="cat" items="${categories}">
                                            <c:if test="${cat.categoryId == selectedCategoryId}">
                                                ${cat.categoryName}
                                            </c:if>
                                        </c:forEach>
                                        <i class="fas fa-times" onclick="removeFilter('category')"></i>
                                    </div>
                                </c:if>

                                <c:if test="${selectedSubcategoryId != null && selectedSubcategoryId > 0}">
                                    <div class="filter-badge">
                                        <c:forEach var="cat" items="${categories}">
                                            <c:forEach var="sub" items="${cat.subcategories}">
                                                <c:if test="${sub.subcategoryId == selectedSubcategoryId}">
                                                    ${sub.subcategoryName}
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                        <i class="fas fa-times" onclick="removeFilter('subcategory')"></i>
                                    </div>
                                </c:if>

                                <c:if test="${selectedPriceRanges != null}">
                                    <c:forEach var="range" items="${selectedPriceRanges}">
                                        <div class="filter-badge">
                                            <c:choose>
                                                <c:when test="${range == '0-1m'}">Dưới 1 triệu</c:when>
                                                <c:when test="${range == '1m-2m'}">1-2 triệu</c:when>
                                                <c:when test="${range == '2m-3m'}">2-3 triệu</c:when>
                                                <c:when test="${range == '3m-5m'}">3-5 triệu</c:when>
                                                <c:when test="${range == '5m+'}">Trên 5 triệu</c:when>
                                            </c:choose>
                                            <i class="fas fa-times" onclick="removePriceRange('${range}')"></i>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <h3>Danh mục sản phẩm</h3>
                            <ul class="category-list">
                                <c:choose>
                                    <c:when test="${not empty categories}">
                                        <c:forEach var="category" items="${categories}">
                                            <li class="category-item">
                                                <div class="category-header ${selectedCategoryId != null && selectedCategoryId == category.categoryId ? 'expanded' : ''}">
                                                    <span onclick="selectCategory(${category.categoryId})">${category.categoryName}</span>
                                                    <c:if test="${not empty category.subcategories}">
                                                        <i class="fa-solid fa-chevron-right"></i>
                                                    </c:if>
                                                </div>
                                                <c:if test="${not empty category.subcategories}">
                                                    <ul class="subcategory ${selectedCategoryId != null && selectedCategoryId == category.categoryId ? 'active' : ''}">
                                                        <c:forEach var="subcategory" items="${category.subcategories}">
                                                            <li class="subcategory-item">
                                                                <a href="#"
                                                                   onclick="selectSubcategory(${subcategory.subcategoryId})"
                                                                   class="${selectedSubcategoryId != null && selectedSubcategoryId == subcategory.subcategoryId ? 'selected' : ''}">
                                                                        ${subcategory.subcategoryName}
                                                                </a>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </c:if>
                                            </li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Fallback to static categories if dynamic not available -->
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
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                        <div class="filter-box price-filter">
                            <h3>Chọn khoảng giá</h3>
                            <div class="price-range-options">
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="0-1m"
                                    <c:forEach var="range" items="${selectedPriceRanges}">
                                           <c:if test="${range == '0-1m'}">checked</c:if>
                                    </c:forEach>
                                           onchange="updatePriceFilter()">
                                    <span>Dưới 1 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="1m-2m"
                                    <c:forEach var="range" items="${selectedPriceRanges}">
                                           <c:if test="${range == '1m-2m'}">checked</c:if>
                                    </c:forEach>
                                           onchange="updatePriceFilter()">
                                    <span>Từ 1 triệu - 2 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="2m-3m"
                                    <c:forEach var="range" items="${selectedPriceRanges}">
                                           <c:if test="${range == '2m-3m'}">checked</c:if>
                                    </c:forEach>
                                           onchange="updatePriceFilter()">
                                    <span>Từ 2 triệu - 3 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="3m-5m"
                                    <c:forEach var="range" items="${selectedPriceRanges}">
                                           <c:if test="${range == '3m-5m'}">checked</c:if>
                                    </c:forEach>
                                           onchange="updatePriceFilter()">
                                    <span>Từ 3 triệu - 5 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="5m+"
                                    <c:forEach var="range" items="${selectedPriceRanges}">
                                           <c:if test="${range == '5m+'}">checked</c:if>
                                    </c:forEach>
                                           onchange="updatePriceFilter()">
                                    <span>Trên 5 triệu</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <!-- Danh sách sản phẩm -->
                    <div class="product-list">
                        <div class="container-fluid">
                            <div class="row">
                                <c:choose>
                                    <c:when test="${not empty listPagination}">
                                        <c:forEach items="${listPagination}" var="p">
                                            <div class="col-sm-3 p-3 col-md-3">
                                                <div class="product-block">
                                                    <div class="product-tumb">
                                                        <span class="discount-percent">-5%</span>
                                                        <a href="detail?pId=${p.id}">
                                                            <img src="${pageContext.request.contextPath}/img/sanpham/${p.img}"
                                                                 alt="${p.name}"
                                                                 loading="lazy">
                                                        </a>
                                                        <c:choose>
                                                            <c:when test="${favoriteProductIds != null && favoriteProductIds.contains(p.id)}">
                                                                <span class="favorite-product active"
                                                                      title="Bỏ khỏi yêu thích"
                                                                      data-product-id="${p.id}">
                                                                    <i class="fa-solid fa-heart"></i>
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="favorite-product"
                                                                      title="Thêm vào yêu thích"
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

                                                        <div class="product-rating">
                                                            <div class="stars">
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                            </div>
                                                            <span class="rating-count">(12)</span>
                                                        </div>

                                                        <div class="product-bottom_detail">
                                                            <div class="price">
                                                                <span class="original-price">
<%--                                                                     lấy giá gốc là giá trên trang * 1.05, làm vậy để kích thị giác khach hang  --%>
                                                                    <f:formatNumber value="${p.price * 1.05}"
                                                                                    type="number" pattern="#,###"/>đ
                                                                </span>
                                                                <span class="discount-price">
                                                                    <f:formatNumber value="${p.price}" type="number"
                                                                                    pattern="#,###"/>đ
                                                                </span>
                                                            </div>
                                                            <div class="product-actions">
                                                                <form action="${pageContext.request.contextPath}/cart/addToCart"
                                                                      method="post">
                                                                    <input type="hidden" name="id"
                                                                           value="${p.id}">
                                                                    <input type="hidden" name="quantity"
                                                                           id="quantityInput" value="1">
                                                                    <button type="submit" class="add-to-cart-btn">
                                                                        <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                                                                        hàng
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="col-12 text-center">
                                            <div style="padding: 50px; text-align: center;">
                                                <i class="fas fa-search"
                                                   style="font-size: 48px; color: #ccc; margin-bottom: 20px;"></i>
                                                <h3 style="color: #666;">Không tìm thấy sản phẩm nào</h3>
                                                <p style="color: #999;">Vui lòng thử lại với các bộ lọc khác</p>
                                                <button onclick="clearAllFilters()" class="add-to-cart-btn"
                                                        style="margin-top: 15px;">
                                                    Xóa bộ lọc
                                                </button>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <%-- phan trang--%>
                        <c:if test="${endP > 1}">
                            <div class="pagination">
                                <ul class="pagination-container">
                                    <c:if test="${currentPage > 1}">
                                        <li class="pagination-item">
                                            <a href="#" onclick="goToPage(${currentPage - 1})"
                                               class="pagination-link pagination-prev" aria-label="Previous page">
                                                <i class="fa-solid fa-angle-left"></i>
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${endP}" var="i">
                                        <li class="pagination-item">
                                            <a href="#" onclick="goToPage(${i})"
                                               class="pagination-link ${currentPage == i ? 'active' : ''}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${currentPage < endP}">
                                        <li class="pagination-item">
                                            <a href="#" onclick="goToPage(${currentPage + 1})"
                                               class="pagination-link pagination-next" aria-label="Next page">
                                                <i class="fa-solid fa-angle-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="components/footer.jsp"/>
    <div class="toast-container" id="toastContainer"></div>
    <script src="${pageContext.request.contextPath}/js/shop.js"></script>
</body>
</html>