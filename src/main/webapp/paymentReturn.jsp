<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả thanh toán</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body style="background-color: #f4f4f4; font-family: Arial, sans-serif; margin: 0; padding: 20px;">
<section style="margin-top: 50px; text-align: center;">
    <div>
        <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:150:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Review-empty.png"
             alt="Transaction Status"
             style="width: 120px; height: 120px; margin-bottom: 20px;">
    </div>

    <!-- Giao dịch thành công -->
    <c:if test="${transResult}">
        <div>
            <h3 style="font-weight: bold; color: #28a745;">
                Bạn đã giao dịch thành công!
                <i class="fas fa-check-circle"></i>
            </h3>
            <p style="font-size: 18px; margin-top: 15px;">Vui lòng để ý số điện thoại của nhân viên tư vấn:</p>
            <strong style="color: red; font-size: 24px;">079345xxx</strong>

            <!-- Phần đếm ngược -->
            <div style="margin-top: 30px; padding: 20px; background-color: #e8f5e9; border-radius: 8px; border-left: 4px solid #28a745;">
                <p style="font-size: 16px; margin: 0;">
                    <i class="fas fa-info-circle" style="color: #28a745;"></i>
                    Trang sẽ tự động chuyển đến thông tin đơn hàng sau <span id="countdown"
                                                                             style="font-weight: bold; color: #28a745;">15</span>
                    giây
                </p>
                <button onclick="redirectNow()"
                        style="margin-top: 10px; padding: 8px 16px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer;">
                    Xem đơn hàng ngay
                </button>
            </div>
        </div>
    </c:if>

    <!-- Giao dịch thất bại -->
    <c:if test="${transResult == false}">
        <div>
            <h3 style="font-weight: bold; color: #dc3545;">
                Đơn hàng giao dịch thất bại!
            </h3>
            <p style="font-size: 18px; margin-top: 15px;">Cảm ơn quý khách đã dùng dịch vụ của chúng tôi.</p>
            <p style="font-size: 18px;">Liên hệ tổng đài để được tư vấn:</p>
            <strong style="color: red; font-size: 24px;">079345xxx</strong>
            <div style="margin-top: 30px;">
                <button onclick="window.location.href='${pageContext.request.contextPath}/checkout/'"
                        style="padding: 10px 20px; background-color: #dc3545; color: white; border: none; border-radius: 4px; cursor: pointer; margin-right: 10px;">
                    Thử lại thanh toán
                </button>
                <button onclick="window.location.href='${pageContext.request.contextPath}/'"
                        style="padding: 10px 20px; background-color: #6c757d; color: white; border: none; border-radius: 4px; cursor: pointer;">
                    Về trang chủ
                </button>
            </div>
        </div>
    </c:if>

    <!-- Đang xử lý giao dịch -->
    <c:if test="${transResult == null}">
        <div>
            <h3 style="font-weight: bold; color: #ffc107;">
                Chúng tôi đã tiếp nhận đơn hàng, xin chờ quá trình xử lý!
            </h3>
            <p style="font-size: 18px; margin-top: 15px;">Vui lòng để ý số điện thoại của nhân viên tư vấn:</p>
            <strong style="color: red; font-size: 24px;">079345xxx</strong>
        </div>
    </c:if>
</section>

<!-- JavaScript đếm ngược và chuyển hướng -->
<c:if test="${transResult}">
    <script>
        let countdown = 15;
        const countdownElement = document.getElementById('countdown');

        function redirectNow() {
            window.location.href = '${pageContext.request.contextPath}/orderReceived';
        }

        const timer = setInterval(function () {
            countdown--;
            countdownElement.textContent = countdown;

            if (countdown <= 0) {
                clearInterval(timer);
                redirectNow();
            }
        }, 1000);
    </script>
</c:if>
</body>
</html>