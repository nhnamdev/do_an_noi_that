<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="css/ConfirmOTP.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div>
    <jsp:include page="/components/header.jsp"/>
    <script src="js/showSearch.js"></script>
    <div class="navigation_titlePage">
        <div class="container">
            <div class="alpha">
                <img src="img/background.jpg" alt="">
            </div>
            <div class="omega">
                <h1 class="title">Tài khoản</h1>
                <div class="path">
                    <div class="home">Trang chủ</div>
                    <div class="icon">
                        <ul class="icons">
                            <li><i class="fa fa-chevron-right"></i></li>
                        </ul>
                    </div>
                    <div class="contact">Kích hoạt</div>
                </div>
            </div>
        </div>
    </div>
    <div class="slider2" style="background-color: #fff; height: 590px">
        <div class="confirm" style="margin: auto; width: 460px;">
            <h2 style="margin-left: 120px;">Kích hoạt tài khoản</h2>
            <form action="confirm" method="post"
                  style="margin-right: 32px;width: 426px;border: 2px dashed #6bae0e;padding-left: 30px; padding-bottom: 20px;margin-left: 40px">
                <c:if test="${not empty error}">
                    <div style="color: red; font-weight: bold; width: 360px;">
                            ${error}
                    </div>
                </c:if>
                <label style="margin-top: 5px ">Nhập Email(nếu cần gửi lại mã otp):</label>
                <input class="dangnhap-matkhau" name="email" value="${sessionScope.userEmail}" type="text">
                <label style="margin-top: 5px ">Nhập mã OTP:</label>
                <input class="dangnhap-matkhau" name="username" type="text">
                <div class="button" style="display: flex">
                <button type="button" id="resendOtpBtn" class="resendOtp"
                        style="padding: 1px 2px; color: white; border: none; cursor: pointer;font-size: 15px;">
                    Gửi lại mã OTP
                </button>
                <button type="submit" id="activeBtn">Kích hoạt</button>
            </div>
            </form>
        </div>
    </div>
    <script>
        $(document).ready(function() {
            var canResend = true;
            $(".resendOtp").click(function(e) {
                e.preventDefault();
                if (!canResend) {
                    alert('Bạn vui lòng đợi 5 giây trước khi gửi lại mã OTP.');
                    return;
                }
                var email = $("input[name='email']").val();
                $.ajax({
                    type: 'POST',
                    url: 'resendOTP',
                    data: {
                        email: email
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            alert('Mã OTP đã được gửi lại!');
                            canResend = false;
                            setTimeout(function() {
                                canResend = true;
                            }, 5000);
                        } else {
                            alert('Đã xảy ra lỗi: ' + response.message);
                        }
                    },
                    error: function() {
                        alert('Có lỗi xảy ra khi gửi mã OTP. Vui lòng thử lại!');
                    }
                });
            });
        });
    </script>

</div>
<jsp:include page="components/footer.jsp"/>
</body>

</html>
