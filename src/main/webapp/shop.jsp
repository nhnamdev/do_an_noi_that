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
                        <div class="price">
                            <%--                    <%--%>
                            <%--                        double totalPrice = 0;--%>
                            <%--                        List<Product> cartProducts = (List<Product>) session.getAttribute("cartProducts");--%>
                            <%--                        if (cartProducts == null) {--%>
                            <%--                            cartProducts = new ArrayList<Product>();--%>
                            <%--                        }--%>
                            <%--                        for (Product item : cartProducts) {--%>
                            <%--                            totalPrice += item.getPrice() * item.getQuantity();--%>
                            <%--                        }--%>

                            <%--                    %>--%>
                            <%--                    <%= totalPrice %>đ--%>
                        </div>
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
                            Sắp xếp theo: Mặc định
                            <i class="fas fa-chevron-down"></i>
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
                            <a href="#" class="clear-filters"><i class="fas fa-times"></i> Xóa tất cả bộ lọc</a>
                            <%-- những phần dc người dùng ấn lọc ra sẽ hiển thị ở đây --%>
                            <div class="active-filters">

                            </div>
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
                                                        <span class="favorite-product active" title="Bỏ khỏi yêu thích"
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

                                                <div class="product-rating">
                                                    <div class="stars">
                                                        <i class="fas fa-star"></i>
                                                        <i class="fas fa-star"></i>
                                                        <i class="fas fa-star"></i>
                                                        <i class="fas fa-star"></i>
                                                        <i class="fas fa-star"></i>
<%--                                                        <i class="fas fa-star-half-alt"></i>--%>
                                                    </div>
                                                    <span class="rating-count">(12)</span>
                                                </div>

                                                <div class="product-bottom_detail">
                                                    <div class="price">
                                                        <span class="original-price">600.000đ</span>
                                                        <span class="discount-price">${p.price}</span>
                                                    </div>
                                                    <div class="product-actions">
                                                        <button class="add-to-cart-btn">
                                                            <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
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
    <jsp:include page="components/footer.jsp"/>
    <div class="toast-container" id="toastContainer"></div>
</div>
<script src="js/shop.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const favoriteButtons = document.querySelectorAll(".favorite-product");
        favoriteButtons.forEach(function (button) {
            const newButton = button.cloneNode(true);
            button.parentNode.replaceChild(newButton, button);
        });

        function showToast(title, message, type = 'success') {
            let container = document.getElementById('toastContainer');
            if (!container) {
                container = document.createElement('div');
                container.id = 'toastContainer';
                container.className = 'toast-container';
                document.body.appendChild(container);
            }

            const toast = document.createElement('div');
            toast.className = `toast toast-${type}`;

            toast.innerHTML = `
            <div class="toast-icon">
                <i class="fas ${type == 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
            </div>
            <div class="toast-body">
                <div class="toast-title">${title}</div>
                <div class="toast-message">${message}</div>
            </div>
        `;

            container.appendChild(toast);

            setTimeout(() => {
                toast.classList.add('show');
            }, 10);

            // Tự động ẩn sau 3 giây
            setTimeout(() => {
                toast.classList.remove('show');
                setTimeout(() => {
                    if (toast.parentNode) {
                        toast.parentNode.removeChild(toast);
                    }
                }, 300);
            }, 3000);
        }

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
                        if (data.success || data["Đã thêm sản phẩm yêu thích"]) {
                            const isActive = span.classList.contains("active");
                            if (isActive) {
                                span.classList.remove("active");
                                span.setAttribute("title", "Thêm vào yêu thích");
                                span.innerHTML = `<i class="fa-regular fa-heart"></i>`;

                                // Hiển thị thông báo đã bỏ yêu thích
                                showToast('Thông báo', 'Đã xóa khỏi danh sách yêu thích', 'success');
                            } else {
                                span.classList.add("active");
                                span.setAttribute("title", "Bỏ khỏi yêu thích");
                                span.innerHTML = `<i class="fa-solid fa-heart"></i>`;

                                // Hiển thị thông báo đã thêm yêu thích
                                showToast('Thông báo', 'Đã thêm vào danh sách yêu thích', 'success');
                            }
                        } else {
                            // Hiển thị thông báo lỗi
                            showToast('Thông báo', data.message || "Đã có lỗi xảy ra", 'error');
                        }
                    })
                    .catch(error => {
                        console.error("Lỗi:", error);

                        // Hiển thị thông báo lỗi
                        showToast('Thông báo', "Đã xảy ra lỗi khi xử lý yêu cầu", 'error');
                    });
            });
        });
    });
</script>
</body>
</html>