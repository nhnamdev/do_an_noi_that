<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
<div class="wrapper">
    <jsp:include page="/components/header.jsp"/>
    <script src="js/showSearch.js"></script>
    <script src="js/showHeader.js"></script>
    <script src="js/actionOfProfile.js"></script>
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
    <div id="content">
        <div class="container">
            <div class="order-steps">
                <div class="order-row">
                    <div class="checkout-breadcrumb">
                        <div class="title-cart">
                            <a href="${pageContext.request.contextPath}/cart/">
                                <div class="number-wrapper">
                                    <h3 class="step-number">01</h3>
                                </div>
                                <div class="step-content">
                                    <h4 class="step-title">GIỎ HÀNG</h4>
                                    <p class="step-description">Quản lý danh sách sản phẩm</p>
                                </div>
                            </a>
                        </div>
                        <div class="title-checkout">
                            <a href="">
                                <div class="number-wrapper">
                                    <h3 class="step-number">02</h3>
                                </div>
                                <div class="step-content">
                                    <h4 class="step-title">CHI TIẾT THANH TOÁN</h4>
                                    <p class="step-description">Thanh toán danh sách sản phẩm</p>
                                </div>
                            </a>
                        </div>
                        <div class="title-thankyou">
                            <a href="">
                                <div class="number-wrapper">
                                    <h3 class="step-number">03</h3>
                                </div>
                                <div class="step-content">
                                    <h4 class="step-title">HOÀN THÀNH ĐƠN HÀNG</h4>
                                    <p class="step-description">Xem lại đơn hàng</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="cart-container">
                <div class="cart-left">
                    <form action="${pageContext.request.contextPath}/cart/updateQuantity" method="post">
                        <table class="cart-table">
                            <thead>
                            <tr>
                                <th class="product-column">SẢN PHẨM</th>
                                <th class="price-column">ĐƠN GIÁ</th>
                                <th class="quantity-column">SỐ LƯỢNG</th>
                                <th class="subtotal-column">TỔNG</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%-- tai sao o day dung choose ma khong phai if, de sau nay co the mo rong code hon,
                            vi du nhu sau nay muon mo rong them la gio hang khong trong boi vi co san pham het hang
                            nam trong gio hang nen khong tinh la gio hang trong dc--%>
                            <c:choose>
                                <c:when test="${cart == null}">
                                    <td colspan="4" class="empty-cart-message">Giỏ hàng của bạn đang trống.</td>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="entry" items="${cart}">
                                        <c:set var="order" value="${entry.value}"/>
                                        <c:set var="product" value="${order.product}"/>
                                        <tr class="cart-item">
                                            <td class="product-column">
                                                <div class="product-info">
                                                    <img src="${product.img}" alt="${product.name}"
                                                         class="product-image">
                                                    <div class="product-details">
                                                        <div class="product-name">${product.name}</div>
                                                        <div class="product-variants">
                                                            <span class="product-variant">Màu: đen</span>
                                                            <span class="product-variant">Kích thước: 300x400</span>
                                                            <span class="product-variant">Chất liệu: Gỗ cao su</span>
                                                        </div>
                                                        <button class="remove-btn"
                                                                onclick="removeProduct(${product.id})">
                                                            <i class="fas fa-times"></i> Xóa
                                                        </button>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="price-column">
                                                <f:formatNumber type="currency" value="${product.price}"
                                                                pattern="#,###đ"/>
                                            </td>
                                            <td class="quantity-column">
                                                <div class="quantity-control" data-product-id="${product.id}">
                                                    <button type="button" class="quantity-btn minus">-</button>
                                                    <input type="text" class="quantity-input" value="${order.quantity}"
                                                           data-product-id="${product.id}">
                                                    <input type="hidden" name="id" value="${product.id}"
                                                           class="product-id-input">
                                                    <input type="hidden" name="quantity" id="quantity_${product.id}"
                                                           value="${order.quantity}">
                                                    <button type="button" class="quantity-btn plus">+</button>
                                                </div>
                                            </td>
                                            <td class="subtotal-column">
                                                <f:formatNumber type="currency"
                                                                value="${product.price * order.quantity}"
                                                                pattern="#,###đ"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </form>
                    <div class="coupon-section">
                        <div class="coupon-form">
                            <div class="coupon-code">
                                <input type="text" class="coupon-input" placeholder="Mã giảm giá" id="couponCode">
                                <button class="apply-btn" id="applyCoupon">ÁP DỤNG</button>
                            </div>
                            <div class="update-section">
                                <button type="submit" id="updateCartButton" class="update-cart-btn">
                                    <i class="fas fa-sync-alt"></i> CẬP NHẬT GIỎ HÀNG
                                </button>
                            </div>
                        </div>
                        <div class="coupon-message" id="couponMessage"></div>
                        <div class="available-coupons">
                            <span class="coupon-title">Mã giảm giá hiện có:</span>
                            <div class="coupon-chips">
                                <span class="coupon-chip" data-code="WELCOME">CHUCMUNGBANMOI -5%</span>
                                <span class="coupon-chip" data-code="NEWYEAR">CHUCMUNGNAMMOI -20%</span>
                            </div>
                        </div>
                    </div>
                    <div class="cart-buttons">
                        <button class="continue-shopping">
                            <i class="fas fa-arrow-left"></i> TIẾP TỤC MUA HÀNG
                        </button>
                        <button class="clear-cart" id="clearCart">
                            <i class="fas fa-trash-alt"></i> XÓA TẤT CẢ
                        </button>
                    </div>
                </div>
                <div class="cart-right">
                    <h3 class="cart-summary-title">GIỎ HÀNG</h3>
                    <div class="summary-row">
                        <span class="summary-label">Tạm tính</span>
                        <span class="summary-value"></span>
                    </div>
                    <div class="shipping-info">
                        Phí vận chuyển sẽ được tính chính xác trong quá trình thanh toán.
                    </div>
                    <div class="total-row">
                        <span class="total-label">Tổng</span>
                        <span class="total-value"></span>
                    </div>
                    <form action="${pageContext.request.contextPath}/checkout/" method="post">
                        <button class="checkout-btn">TIẾN HÀNH THANH TOÁN</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/components/footer.jsp"/>
</div>
<script src="${pageContext.request.contextPath}/js/cart.js"></script>
</body>
</html>
