<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${isFromOrderList}">Chi tiết đơn hàng</c:when>
            <c:otherwise>Đặt hàng thành công</c:otherwise>
        </c:choose>
    </title>
    <link rel="stylesheet" href="css/orderReceived.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="wrapper">
    <jsp:include page="/components/header.jsp"/>
    <script src="js/showSearch.js"></script>
    <script src="js/actionOfProfile.js"></script>
    <script src="js/showCart.js"></script>
    <div id="content">
        <div class="container">
            <!-- Back Navigation -->
            <div class="back-navigation">
                <c:choose>
                    <c:when test="${isFromOrderList}">
                        <a href="${pageContext.request.contextPath}/orderInformation" class="back-btn">
                            <i class="fa fa-arrow-left"></i>
                            Quay lại danh sách đơn hàng
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/shop" class="back-btn">
                            <i class="fa fa-arrow-left"></i>
                            Tiếp tục mua sắm
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Navigation Info -->
            <c:if test="${isFromOrderList}">
                <div class="navigation-info">
                    <p class="info-text">
                        <i class="fa fa-info-circle"></i>
                        Bạn đang xem chi tiết đơn hàng từ danh sách đơn hàng của mình.
                    </p>
                </div>
            </c:if>

            <!-- Order Steps - Only show for new orders -->
            <c:if test="${!isFromOrderList}">
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
            </c:if>

            <div class="confirmation-card">
                <!-- Success Icon - Only for new orders -->
                <c:if test="${!isFromOrderList}">
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
                </c:if>

                <!-- Order Detail Title for existing orders -->
                <c:if test="${isFromOrderList}">
                    <div class="success-icon">
                        <div class="circle-check">
                            <i class="fa fa-file-text"></i>
                        </div>
                        <div>
                            <h1 class="confirmation-title">Chi tiết đơn hàng</h1>
                            <p class="confirmation-message">Thông tin chi tiết về đơn hàng của bạn</p>
                        </div>
                    </div>
                </c:if>

                <div class="confirm-form-container">
                    <div class="left-column">
                        <div class="order-info">
                            <!-- Order Meta Information -->
                            <c:if test="${isFromOrderList}">
                                <div class="order-meta-info">
                                    <div class="meta-item">
                                        <span class="meta-label">Trạng thái:</span>
                                        <span class="meta-value">
                                            <c:choose>
                                                <c:when test="${orderInfo.orderStatus == 'pending'}">Chờ xác nhận</c:when>
                                                <c:when test="${orderInfo.orderStatus == 'confirmed'}">Đã xác nhận</c:when>
                                                <c:when test="${orderInfo.orderStatus == 'shipping'}">Đang giao hàng</c:when>
                                                <c:when test="${orderInfo.orderStatus == 'delivered'}">Đã giao hàng</c:when>
                                                <c:when test="${orderInfo.orderStatus == 'cancelled'}">Đã hủy</c:when>
                                                <c:otherwise>Chờ xử lý</c:otherwise>
                                            </c:choose>
                                            <span class="order-status-badge status-${orderInfo.orderStatus}">
                                                    ${orderInfo.orderStatus}
                                            </span>
                                        </span>
                                    </div>
                                    <div class="meta-item">
                                        <span class="meta-label">Ngày đặt:</span>
                                        <span class="meta-value">
                                            <f:formatDate value="${orderDateAsDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </span>
                                    </div>
                                    <c:if test="${invoiceInfo != null}">
                                        <div class="meta-item">
                                            <span class="meta-label">Trạng thái thanh toán:</span>
                                            <span class="meta-value">${invoiceInfo.status}</span>
                                        </div>
                                    </c:if>
                                </div>
                            </c:if>

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

                            <!-- Enhanced Action Buttons -->
                            <div class="enhanced-action-buttons">
                                <c:choose>
                                    <c:when test="${isFromOrderList}">
                                        <!-- Actions for viewing existing order -->
                                        <c:if test="${orderInfo.orderStatus == 'pending'}">
                                            <button class="btn btn-danger"
                                                    onclick="cancelThisOrder(${orderInfo.orderId})">
                                                <i class="fa fa-times"></i> Hủy đơn hàng
                                            </button>
                                        </c:if>
                                        <button class="btn btn-outline" onclick="window.print()">
                                            <i class="fa fa-print"></i> In đơn hàng
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Actions for new order -->
                                        <a href="${pageContext.request.contextPath}/orderInformation"
                                           class="btn btn-primary">
                                            <i class="fa fa-list"></i> Xem đơn đặt hàng
                                        </a>
                                        <button class="btn btn-outline" onclick="window.print()">
                                            <i class="fa fa-print"></i> In
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="right-column">
                        <div class="order-details">
                            <div class="order-header">
                                <div class="order-number">Đơn hàng
                                    #${orderInfo.orderNumber != null ? orderInfo.orderNumber : sessionScope.lastOrderId}
                                    <c:if test="${isFromOrderList}">
                                        <span class="order-status-badge status-${orderInfo.orderStatus}">
                                            <c:choose>
                                                <c:when test="${orderInfo.orderStatus == 'pending'}">Chờ xác nhận</c:when>
                                                <c:when test="${orderInfo.orderStatus == 'confirmed'}">Đã xác nhận</c:when>
                                                <c:when test="${orderInfo.orderStatus == 'shipping'}">Đang giao hàng</c:when>
                                                <c:when test="${orderInfo.orderStatus == 'delivered'}">Đã giao hàng</c:when>
                                                <c:when test="${orderInfo.orderStatus == 'cancelled'}">Đã hủy</c:when>
                                                <c:otherwise>Chờ xử lý</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Hiển thị danh sách sản phẩm -->
                            <c:forEach var="item" items="${orderItems}">
                                <div class="product-item">
                                    <div class="product-image">
                                        <img src="${pageContext.request.contextPath}/img/sanpham/${item.productImage}"
                                             alt="${item.productName}">
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

<script>
    $(document).ready(function () {
        const isFromOrderList = ${isFromOrderList != null ? isFromOrderList : false};

        if (isFromOrderList) {
            $('.info-box').hide();

            document.title = 'Chi tiết đơn hàng #${orderInfo.orderNumber}';
        } else {
            setTimeout(function () {
                $('.info-box').fadeOut();
            }, 3000);
        }
    });

    function cancelThisOrder(orderId) {
        if (!confirm('Bạn có chắc chắn muốn hủy đơn hàng này?\n\nHành động này không thể hoàn tác.')) {
            return;
        }

        const cancelBtn = $(`button[onclick="cancelThisOrder(${orderId})"]`);
        const originalText = cancelBtn.html();
        cancelBtn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang hủy...');

        $.ajax({
            url: '${pageContext.request.contextPath}/orderInformation',
            type: 'POST',
            data: {
                action: 'cancel',
                orderId: orderId
            },
            timeout: 10000,
            success: function (response) {
                try {
                    const result = typeof response === 'string' ? JSON.parse(response) : response;
                    if (result.success) {
                        // Show success message
                        alert('Hủy đơn hàng thành công!');
                        // Reload page to show updated status
                        window.location.reload();
                    } else {
                        alert('Không thể hủy đơn hàng: ' + (result.message || 'Lỗi không xác định'));
                        cancelBtn.prop('disabled', false).html(originalText);
                    }
                } catch (error) {
                    alert('Có lỗi xảy ra khi xử lý phản hồi');
                    cancelBtn.prop('disabled', false).html(originalText);
                }
            },
            error: function (xhr, status, error) {
                let errorMessage = 'Có lỗi xảy ra khi hủy đơn hàng!';
                if (status === 'timeout') {
                    errorMessage = 'Quá thời gian chờ, vui lòng thử lại';
                }
                alert(errorMessage);
                cancelBtn.prop('disabled', false).html(originalText);
            }
        });
    }

    // Print functionality
    function printOrder() {
        window.print();
    }
</script>
</body>
</html>