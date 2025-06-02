<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công</title>
    <link rel="stylesheet" href="css/orderReceived.css">
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
                <button class="view_cart" onclick="window.location.href='${pageContext.request.contextPath}/cart/'">Giỏ
                    hàng
                </button>
                <button class="check_out" onclick="window.location.href='${pageContext.request.contextPath}/checkout/'">
                    Thanh toán
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
                            <a href="${pageContext.request.contextPath}/checkout/">
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
            <div class="confirmation-card">
                <div class="success-icon">
                    <div class="circle-check">
                        <i class="fa-regular fa-circle-check"></i>
                    </div>
                    <div>
                        <h1 class="confirmation-title">Cảm ơn bạn đã đặt hàng</h1>
                        <p class="confirmation-message">Một email xác nhận đã được gửi tới
                            <b>${sessionScope.userEmail != null ? sessionScope.userEmail : orderInfo.customerEmail}</b>.<br>Xin
                            vui lòng kiểm tra email của bạn</p>
                    </div>
                </div>
                <div class="confirm-form-container">
                    <div class="left-column">
                        <div class="order-info">
                            <div class="info-section">
                                <h2 class="section-title">Thông tin mua hàng</h2>
                                <div class="info-item">${orderInfo.customerName}</div>
                                <div class="info-item">${sessionScope.userEmail != null ? sessionScope.userEmail : orderInfo.customerEmail}</div>
                                <div class="info-item">${orderInfo.customerPhone}</div>
                            </div>
                            <div class="info-section">
                                <h2 class="section-title">Địa chỉ nhận hàng</h2>
                                <div class="info-item">${orderInfo.shippingAddress}</div>
                            </div>
                            <div class="info-section">
                                <h2 class="section-title">Phương thức thanh toán</h2>
                                <div class="info-item">${orderInfo.paymentMethod}</div>
                            </div>
                            <div class="info-section">
                                <h2 class="section-title">Phương thức vận chuyển</h2>
                                <div class="info-item">Giao hàng tận nơi</div>
                            </div>
                            <div class="action-buttons">
                                <button class="profile-order"
                                        onclick="window.location.href='${pageContext.request.contextPath}/orderInformation'">
                                    Xem đơn đặt hàng
                                </button>
                                <button class="print-button" onclick="window.print()">
                                    <i class="fa-solid fa-print"></i>
                                    <span>In</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="right-column">
                        <div class="order-details">
                            <div class="order-header">
                                <div class="order-number">Đơn hàng
                                    #${orderInfo.orderNumber != null ? orderInfo.orderNumber : sessionScope.lastOrderId}</div>
                            </div>

                            <!-- Hiển thị danh sách sản phẩm -->
                            <c:forEach var="item" items="${orderItems}">
                                <div class="product-item">
                                    <div class="product-image">
                                        <img src="/img/sanpham/${item.productImage}" alt="${item.productName}">
                                    </div>
                                    <div class="product-details">
                                        <div class="product-name">
                                            <span class="product-quantity">${item.quantity}</span>
                                                ${item.productName}
                                        </div>
                                    </div>
                                    <div class="product-price">
                                        <f:formatNumber type="currency" value="${item.totalPrice}" pattern="#,###₫"/>
                                    </div>
                                </div>
                            </c:forEach>

                            <div class="order-summary">
                                <div class="summary-row">
                                    <div>Tạm tính</div>
                                    <div><f:formatNumber type="currency" value="${orderInfo.totalAmount}"
                                                         pattern="#,###₫"/></div>
                                </div>
                                <div class="total-row">
                                    <div>Tổng cộng</div>
                                    <div><f:formatNumber type="currency" value="${orderInfo.totalAmount}"
                                                         pattern="#,###₫"/></div>
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
</body>
</html>