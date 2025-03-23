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
                        <div class="filter-box price-filter">
                            <h3>Chọn khoảng giá</h3>
                            <div class="price-range-options">
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="0-1000000">
                                    <span>Dưới 1 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="1000000-2000000">
                                    <span>Từ 1 triệu - 2 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="2000000-3000000">
                                    <span>Từ 2 triệu - 3 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="3000000-5000000">
                                    <span>Từ 3 triệu - 5 triệu</span>
                                </label>
                                <label class="price-checkbox">
                                    <input type="checkbox" name="price-range" value="5000000+">
                                    <span>Trên 5 triệu</span>
                                </label>
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
                                            <span class="discount-percent">-5%</span>
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <span class="favorite-product" title="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </span>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="original-price">600.000đ</span>
                                                    <span class="discount-price">500.000đ</span>
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
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <span class="discount-percent">-5%</span>
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <span class="favorite-product" title="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </span>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="original-price">600.000đ</span>
                                                    <span class="discount-price">500.000đ</span>
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
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <span class="discount-percent">-5%</span>
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <span class="favorite-product" title="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </span>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="original-price">600.000đ</span>
                                                    <span class="discount-price">500.000đ</span>
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
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <span class="discount-percent">-5%</span>
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <span class="favorite-product" title="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </span>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="original-price">600.000đ</span>
                                                    <span class="discount-price">500.000đ</span>
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
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <span class="discount-percent">-5%</span>
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <span class="favorite-product" title="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </span>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="original-price">600.000đ</span>
                                                    <span class="discount-price">500.000đ</span>
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
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <span class="discount-percent">-5%</span>
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <span class="favorite-product" title="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </span>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="original-price">600.000đ</span>
                                                    <span class="discount-price">500.000đ</span>
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
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <span class="discount-percent">-5%</span>
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <span class="favorite-product" title="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </span>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="original-price">600.000đ</span>
                                                    <span class="discount-price">500.000đ</span>
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
                                <div class="col-sm-3 p-3 col-md-3">
                                    <div class="product-block" data-product-id="1">
                                        <div class="product-tumb">
                                            <span class="discount-percent">-5%</span>
                                            <a href="">
                                                <img src="assets_duc/img/sofa-don-vai-1.png" alt="Sofa đơn vải 1">
                                            </a>
                                            <span class="favorite-product" title="Thêm vào yêu thích">
                                                <i class="fa-regular fa-heart"></i>
                                            </span>
                                        </div>
                                        <div class="product-detail">
                                            <div class="product-category">Sofa</div>
                                            <h4>
                                                <a href="">Sofa đơn vải cao cấp</a>
                                            </h4>
                                            <div class="product-bottom_detail">
                                                <div class="price">
                                                    <span class="original-price">600.000đ</span>
                                                    <span class="discount-price">500.000đ</span>
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/components/footer.jsp"/>
</div>
<script src="js/shop.js"></script>
</body>
</html>