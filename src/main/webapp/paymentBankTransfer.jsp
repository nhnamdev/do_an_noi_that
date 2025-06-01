<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chuyển khoản ngân hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bankTransfer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
<jsp:include page="/components/header.jsp"/>
<div id="content">
    <div class="container">
        <div class="success-header">
            <h1 class="success-title">Thông tin chuyển khoản</h1>
        </div>
        <div class="order-id" id="order-number">Mã đơn hàng #<span id="order-id"></span>
        </div>
        <div class="order-details">
            <div style="padding: 15px; text-align: center; border-bottom: 1px solid #ddd;">
                <h3>Hướng dẫn thanh toán qua chuyển khoản ngân hàng</h3>
            </div>

            <div class="payment-methods">
                <div class="method-tab">Cách 1: Mở app ngân hàng và quét mã QR</div>
                <div class="method-tab">Cách 2: Chuyển khoản thủ công theo thông tin</div>
            </div>

            <div class="payment-content">
                <div class="qr-method">
                    <div class="bank-logo">
                        <img src="${pageContext.request.contextPath}/img/sepay-logo.png" alt="SePay Logo"/>
                    </div>

                    <div class="qr-code">
                        <img src="${pageContext.request.contextPath}/img/qr-code.png" alt="QR Code"/>
                    </div>

                    <div class="payment-partners">
                        <img src="${pageContext.request.contextPath}/img/napas-logo.png" alt="Napas"
                             class="partner-logo"/>
                        <img src="${pageContext.request.contextPath}/img/mbbank-logo.png" alt="MB Bank"
                             class="partner-logo"/>
                        <img src="${pageContext.request.contextPath}/img/vietqr-logo.png" alt="VietQR"
                             class="partner-logo"/>
                    </div>

                    <button class="download-btn">
                        <span class="download-icon">⬇️</span> Tải ảnh QR
                    </button>

                    <div class="payment-status">
                        Trạng thái: Chờ thanh toán...
                        <span class="spinner"></span>
                    </div>
                </div>

                <div class="transfer-method">
                    <div class="bank-logo" style="text-align: center;">
                        <img src="${pageContext.request.contextPath}/img/mbbank-logo-large.png" alt="MB Bank Logo"/>
                    </div>

                    <div style="text-align: center; margin-bottom: 15px;">
                        <h4>Ngân hàng MBBank</h4>
                    </div>

                    <div class="account-info">
                        <div class="info-row">
                            <div class="info-label">Chủ tài khoản:</div>
                            <div class="info-value">CÔNG TY TNHH NỘI THẤT ABC</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Số TK:</div>
                            <div class="info-value">0903252427</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Số tiền:</div>
                            <div class="info-value" id="amount-value"><f:formatNumber type="currency"
                                                                                      value="${totalAmount}"
                                                                                      pattern="#,###₫"/></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Nội dung CK:</div>
                            <div class="info-value" id="transfer-content"></div>
                        </div>
                    </div>

                    <div class="notice">
                        <strong>Lưu ý:</strong> Vui lòng giữ nguyên nội dung chuyển khoản <span
                            id="notice-order-id"></span>
                        để hệ thống tự động xác nhận thanh toán
                    </div>
                </div>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/cart/" class="back-btn">
            <span class="back-icon">←</span> Quay lại
        </a>
    </div>
</div>
<jsp:include page="/components/footer.jsp"/>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Lấy thông tin đơn hàng từ sessionStorage
        try {
            const orderData = JSON.parse(sessionStorage.getItem('orderData')) || {};

            // Lấy mã đơn hàng
            const orderId = document.getElementById('order-id').textContent;

            // Hiển thị nội dung chuyển khoản
            document.getElementById('transfer-content').textContent = orderId;
            document.getElementById('notice-order-id').textContent = orderId;

            // Lưu tổng tiền vào sessionStorage để trang khác có thể sử dụng
            const totalAmount = document.getElementById('total-amount').textContent;
            sessionStorage.setItem('totalAmount', totalAmount);
        } catch (error) {
            console.error('Lỗi khi xử lý dữ liệu:', error);
        }

        // Simulate payment status checking
        let dots = '';
        setInterval(() => {
            const statusElement = document.querySelector('.payment-status');
            dots = dots.length >= 3 ? '' : dots + '.';
            statusElement.innerHTML = `Trạng thái: Chờ thanh toán${dots} <span class="spinner"></span>`;
        }, 1000);

        // Download QR button functionality
        document.querySelector('.download-btn').addEventListener('click', () => {
            alert('Tải ảnh QR thành công!');
        });
    });
</script>
</body>
</html>