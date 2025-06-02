<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cartCheckout.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
<div id="wrapper">
    <jsp:include page="/components/header.jsp"/>
    <script src="js/showSearch.js"></script>
    <script src="js/actionOfProfile.js"></script>
    <div class="overlay" id="overlay"></div>
    <div class="info-box" id="infoBox">
        <div class="container">
            <h3>Thông tin giỏ hàng</h3>
            <div class="listProduct">
                <div class="row1">
                    <div class="alpha">
                        <img src="img/sofa15.jpg" alt>
                    </div>
                    <div class="omega">
                        <div class="name">Asgaard sofa</div>
                        <div class="sumPrice">
                            <div class="quantity">1 X</div>
                            <div class="price">220.000</div>
                        </div>
                    </div>
                    <div class="beta">
                        <button class="close-button">
                            <i class="fa fa-times-circle"></i>
                        </button>
                    </div>
                </div>
                <div class="row2">
                    <div class="alpha">
                        <img src="img/sofa16.jpg" alt>
                    </div>
                    <div class="omega">
                        <div class="name">Upholstered Sofa</div>
                        <div class="sumPrice">
                            <div class="quantity">2 X</div>
                            <div class="price">450.000</div>
                        </div>
                    </div>
                    <div class="beta">
                        <button class="close-button">
                            <i class="fa fa-times-circle"></i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="totalPrice">
                <div class="title">Tổng tiền</div>
                <div class="price">1.120.000đ</div>
            </div>
            <div class="other_choose">
                <button class="view_cart" onclick="window.location.href='../page_Cart/cart.html'">Giỏ hàng</button>
                <button class="check_out" onclick="window.location.href='../page_CheckOut/checkout.html'">Thanh toán
                </button>
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
            <div class="row-checkout">
                <div class="checkout-content">
                    <form action="${pageContext.request.contextPath}/payment" method="post" class="checkout-cart">
                        <div class="left-col">
                            <h3>THÔNG TIN THANH TOÁN</h3>
                            <div class="form-group">
                                <label for="fullname">Họ và tên *</label>
                                <input type="text" id="fullname" name="fullname" required
                                       value="${sessionScope.userName}">
                            </div>
                            <div class="form-group">
                                <label for="email">Địa chỉ email *</label>
                                <input type="email" id="email" name="email" required value="${sessionScope.userEmail}">
                            </div>
                            <div class="form-group">
                                <label for="phone">Số điện thoại *</label>
                                <input type="tel" id="phone" name="phone" required value="${sessionScope.userPhone}">
                            </div>
                            <div class="form-group">
                                <label for="province">Tỉnh/Thành phố *</label>
                                <select id="province" name="province" required>
                                    <option value="">Chọn Tỉnh/Thành phố</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="district">Quận/Huyện *</label>
                                <select id="district" name="district" required>
                                    <option value="">Chọn Quận/Huyện</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="ward">Phường/Xã *</label>
                                <select id="ward" name="ward" required>
                                    <option value="">Chọn Phường/Xã</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="address">Địa chỉ *</label>
                                <input type="text" id="address" name="address" required
                                       value="${sessionScope.userAddress}">
                            </div>
                            <div class="form-group">
                                <label for="order-notes">Ghi chú đơn hàng (tùy chọn)</label>
                                <textarea id="order-notes" name="order-notes" rows="4"
                                          placeholder="Ghi chú về đơn hàng, ví dụ: thời gian giao hàng, địa điểm giao..."></textarea>
                            </div>
                        </div>
                        <div class="right-col">
                            <h3>THÔNG TIN ĐƠN HÀNG</h3>
                            <div class="order-summary-item">
                                <c:forEach var="entry" items="${cart}">
                                    <c:set var="order" value="${entry.value}"/>
                                    <c:set var="product" value="${order.product}"/>
                                    <c:set var="itemTotal" value="${product.price * order.quantity}"/>
                                    <div class="product-cart-item">
                                        <div class="product-info">
                                            <img src="${product.img}" alt="${product.name}" class="product-image">
                                            <div class="product-details">
                                                <h4 class="product-name">${product.name}</h4>
                                                <div class="product-meta">
                                                    <span class="product-quantity">Số lượng: ${order.quantity}</span>
                                                    <span class="product-price">
                            <f:formatNumber type="currency" value="${product.price}" pattern="#,###đ"/>
                        </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-subtotal">
                                            <f:formatNumber type="currency"
                                                            value="${product.price * order.quantity}"
                                                            pattern="#,###đ"/>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="order-summary-total">
                                <div>Tổng tiền hàng</div>
                                <div id="total-product"><f:formatNumber type="currency" value="${totalAmount}"
                                                                        pattern="#,###đ"/></div>
                            </div>
                            <div class="order-summary-total">
                                <div>Phí vận chuyển</div>
                                <div id="shipping-fee-display">Chọn địa chỉ để tính phí</div>
                            </div>
                            <div class="order-summary-total grand-total">
                                <div>Tổng thanh toán</div>
                                <div id="total-invoice"><f:formatNumber type="currency" value="${totalAmount}"
                                                                        pattern="#,###đ"/></div>
                            </div>
                            <div class="payment-method">
                                <div class="payment-option">
                                    <input type="radio" id="bank-transfer" name="payment" value="bank" checked>
                                    <label for="bank-transfer">Chuyển khoản ngân hàng</label>
                                </div>
                                <div class="payment-option">
                                    <input type="radio" id="vnpay-transfer" name="payment" value="vnpay">
                                    <label for="vnpay-transfer">Thanh toán qua VNPay</label>
                                </div>
                                <div class="payment-option">
                                    <input type="radio" id="cash-on-delivery" name="payment" value="cod">
                                    <label for="cash-on-delivery">Trả tiền mặt khi nhận hàng (COD)</label>
                                </div>
                                <p class="order-note">
                                    Thực hiện thanh toán vào ngay tài khoản ngân hàng của chúng tôi. Vui lòng sử dụng Mã
                                    đơn hàng của bạn trong phần nội dung thanh toán. Đơn hàng sẽ được giao sau khi tiền
                                    đã chuyển.
                                </p>
                            </div>
                            <input type="hidden" name="totalBill" value="${totalAmount}"/>
                            <button type="submit" class="order-button">ĐẶT HÀNG</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/components/footer.jsp"/>
</div>
<script>
    var contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/js/cartCheckout.js"></script>
</body>
</html>