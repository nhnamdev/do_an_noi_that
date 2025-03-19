<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa hàng</title>
    <link rel="stylesheet" href="css/shop_styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <%--    <script src="js/showSearch.js"></script>--%>
    <%--    <script src="js/showHeader.js"></script>--%>
    <%--    <script src="js/actionOfProfile.js"></script>--%>
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
                        <button class="check_out" onclick="window.location.href='checkout.jsp'">Thanh toán</button>
                    </div>
                </div>
            </div>
            <script src="js/showCart.js"></script>
            <div class="content_section_1">
                <div class="breadcrumb-wrapper">
                    <div class="breadcrumb">
                        <div class="container">
                            <ul>
                                <li><a href="#">Trang chủ</a></li>
                                <li><i class="fas fa-angle-right"></i></li>
                                <li>Sản phẩm</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="shop-container">
                    <!-- Sidebar-->
                    <div class="sidebar">
                        <div class="filter-box">
                            <h3>Danh mục sản phẩm</h3>
                            <ul class="category-list">
                                <li>
                                    <a href="">GIƯỜNG NGỦ</a>
                                </li>
                                <li>
                                    <a href="">BÀN GHẾ</a>
                                    <ul class="subcategory">
                                        <li><a href="">Bàn ăn</a></li>
                                        <li><a href="">Bàn phòng khách</a></li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="">TỦ</a>
                                    <ul class="subcategory">
                                        <li><a href="">Tủ quần áo</a></li>
                                        <li><a href="">Tủ sách</a></li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="">ĐÈN</a>
                                    <ul class="subcategory">
                                        <li><a href="">Đèn trần</a></li>
                                        <li><a href="">Đèn bàn</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="filter-box">
                            <h3>Giá</h3>
                            <div class="price-filter">
                                <div class="price-range">
                                    <input type="range" min="0" max="10000000" step="100000" id="priceRange">
                                </div>
                                <div class="price-inputs">
                                    <input type="text" placeholder="Từ" id="minPrice">
                                    <span>-</span>
                                    <input type="text" placeholder="Đến" id="maxPrice">
                                </div>
                                <button class="apply-price" id="applyPriceFilter">Áp dụng</button>
                            </div>
                        </div>
                    </div>
                    <!-- Danh sách sản phẩm -->
                    <div class="product-list">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <div class="quick-view">
                                                <a href="">Xem nhanh</a>
                                            </div>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="discount-price">500.000đ</span>
                                                    <span class="original-price">600.000đ</span>
                                                </div>
                                                <div class="product-actions">
                                                    <button class="add-to-cart-btn">
                                                        <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                                    </button>
                                                    <button class="favourite-btn" data-product-id="1">
                                                        <i class="far fa-heart"></i>
                                                    </button>
                                                </div>
                                                <div class="sold-quantity">
                                                    Đã bán: 500 cái
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <div class="quick-view">
                                                <a href="">Xem nhanh</a>
                                            </div>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="discount-price">500.000đ</span>
                                                    <span class="original-price">600.000đ</span>
                                                </div>
                                                <div class="product-actions">
                                                    <button class="add-to-cart-btn">
                                                        <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                                    </button>
                                                    <button class="favourite-btn" data-product-id="1">
                                                        <i class="far fa-heart"></i>
                                                    </button>
                                                </div>
                                                <div class="sold-quantity">
                                                    Đã bán: 500 cái
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <div class="quick-view">
                                                <a href="">Xem nhanh</a>
                                            </div>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="discount-price">500.000đ</span>
                                                    <span class="original-price">600.000đ</span>
                                                </div>
                                                <div class="product-actions">
                                                    <button class="add-to-cart-btn">
                                                        <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                                    </button>
                                                    <button class="favourite-btn" data-product-id="1">
                                                        <i class="far fa-heart"></i>
                                                    </button>
                                                </div>
                                                <div class="sold-quantity">
                                                    Đã bán: 500 cái
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <div class="quick-view">
                                                <a href="">Xem nhanh</a>
                                            </div>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="discount-price">500.000đ</span>
                                                    <span class="original-price">600.000đ</span>
                                                </div>
                                                <div class="product-actions">
                                                    <button class="add-to-cart-btn">
                                                        <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                                    </button>
                                                    <button class="favourite-btn" data-product-id="1">
                                                        <i class="far fa-heart"></i>
                                                    </button>
                                                </div>
                                                <div class="sold-quantity">
                                                    Đã bán: 500 cái
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <div class="quick-view">
                                                <a href="">Xem nhanh</a>
                                            </div>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="discount-price">500.000đ</span>
                                                    <span class="original-price">600.000đ</span>
                                                </div>
                                                <div class="product-actions">
                                                    <button class="add-to-cart-btn">
                                                        <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                                    </button>
                                                    <button class="favourite-btn" data-product-id="1">
                                                        <i class="far fa-heart"></i>
                                                    </button>
                                                </div>
                                                <div class="sold-quantity">
                                                    Đã bán: 500 cái
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <div class="quick-view">
                                                <a href="">Xem nhanh</a>
                                            </div>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="discount-price">500.000đ</span>
                                                    <span class="original-price">600.000đ</span>
                                                </div>
                                                <div class="product-actions">
                                                    <button class="add-to-cart-btn">
                                                        <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                                    </button>
                                                    <button class="favourite-btn" data-product-id="1">
                                                        <i class="far fa-heart"></i>
                                                    </button>
                                                </div>
                                                <div class="sold-quantity">
                                                    Đã bán: 500 cái
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <div class="quick-view">
                                                <a href="">Xem nhanh</a>
                                            </div>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="discount-price">500.000đ</span>
                                                    <span class="original-price">600.000đ</span>
                                                </div>
                                                <div class="product-actions">
                                                    <button class="add-to-cart-btn">
                                                        <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                                    </button>
                                                    <button class="favourite-btn" data-product-id="1">
                                                        <i class="far fa-heart"></i>
                                                    </button>
                                                </div>
                                                <div class="sold-quantity">
                                                    Đã bán: 500 cái
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <div class="quick-view">
                                                <a href="">Xem nhanh</a>
                                            </div>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="discount-price">500.000đ</span>
                                                    <span class="original-price">600.000đ</span>
                                                </div>
                                                <div class="product-actions">
                                                    <button class="add-to-cart-btn">
                                                        <i class="fa fa-shopping-cart"></i> Thêm vào giỏ
                                                    </button>
                                                    <button class="favourite-btn" data-product-id="1">
                                                        <i class="far fa-heart"></i>
                                                    </button>
                                                </div>
                                                <div class="sold-quantity">
                                                    Đã bán: 500 cái
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="sort-feature">
                        <div class="sort-dropdown">
                            <div class="sort-dropdown-content">
                                <a href="#" class="active">Mặc định</a>
                                <a href="#">Phổ biến</a>
                                <a href="#">Mới nhất</a>
                                <a href="#">Giá: Tăng dần</a>
                                <a href="#">Giá: Giảm dần</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/components/footer.jsp"/>
</div>
</body>
</html>