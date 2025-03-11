<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 11/12/2024
  Time: 02:57:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="css/my_account.css">
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div>
    <jsp:include page="/components/header.jsp" />
    <script src="js/showSearch.js"></script>
    <script src="js/showHeader.js"></script>
    <script src="js/actionOfProfile.js"></script>
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
                    <div class="contact">Đăng nhập</div>
                </div>
            </div>
        </div>
    </div>
    <div class="slider2">
        <div class="login">
            <form action="login" method="post">
                <h2>Đăng nhập</h2>
                <label>Tên đăng nhập</label>
                <input class="dangnhap-matkhau" name="username" type="text">
                <label>Mật khẩu</label>
                <input class="dangnhap-matkhau" name="password" id="password" type="password" placeholder="">
                <div class="hienmatkhau">
                    <label id="hienmatkhau"><input type="checkbox" name="agree" value="yes"> Ghi nhớ đăng nhập</label>

                    <label>
                        <input type="checkbox" onclick="togglePassword()"> Hiện mật khẩu
                    </label>
                </div>

                <button type="submit">Đăng nhập</button>
                <div class="lostpass">
                    <a href="my_account_lostpass.jsp">Quên mật khẩu?</a>
                    <a href="register.jsp">Đăng ký tài khoản?</a>
                </div>
            </form>
        </div>



        <div class="register">
            <div class="login">
                <h2>Đăng ký</h2>
                <label>Địa chỉ email</label>
                <textarea cols="50" rows="2" required></textarea>
                <label>Số điện thoại</label>
                <textarea cols="50" rows="2" required></textarea>
                <label>Địa chỉ </label>
                <textarea cols="50" rows="2" required></textarea>
                <label>Tên đăng nhập</label>
                <textarea cols="50" rows="2" required></textarea>

                <label>Mật khẩu</label>
                <textarea cols="50" rows="2" required></textarea>
                <label>Xác nhận mật khẩu</label>
                <textarea cols="50" rows="2" required></textarea>
                <label><input type="checkbox" name="agree" value="yes"> Tôi đồng ý tạo tài khoản</label>

                <div class="button">
                    <button>Đăng ký</button>
                </div>

            </div>

        </div>
    </div>
    <script>
        function togglePassword() {
            const passwordField = document.getElementById("password");
            passwordField.type = passwordField.type === "password" ? "text" : "password";
        }
    </script>
</div>
<div class="content_section_2">
    <div class="container">
        <div class="item">
            <div class="card">
                <i class="fa fa-truck"></i>
            </div>
            <div class="content">
                <div class="free_delivery">
                    <h2 class="title">Miễn Phí Giao Hàng</h2>
                    <div class="content_div">Đối với các đơn hàng có giá trị trên 2.000K sẽ được miễn phí phí vận
                        chuyển
                    </div>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="card">
                <i class="fa fa-rotate-left"></i>
            </div>
            <div class="content">
                <div class="return">
                    <h2 class="title">Hỗ Trợ Đổi/Trả Hàng</h2>
                    <div class="content_div">Nếu hàng hóa có vấn đề sẽ hỗ trợ đổi trả trong vòng 90 ngày</div>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="card">
                <i class="fa fa-credit-card"></i>
            </div>
            <div class="content">
                <div class="secure_payment">
                    <h2 class="title">Thanh Toán An Toàn</h2>
                    <div class="content_div">100% thanh toán an toàn và bảo mật thông tin khách hàng</div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="footer">
    <div class="container">
        <div class="profile">
            <div class="title">Thông tin</div>
            <div class="content">Cửa hàng nội thất HTĐ của chúng tôi mang đến nhiều sản phẩm chất lượng,
                từ sofa, bàn ghế đến decor độc đáo. Chúng tôi cam kết giúp bạn tạo không gian sống tiện
                nghi và phong cách. Hãy cùng làm mới ngôi nhà của bạn!
            </div>
        </div>
        <div class="link">
            <div class="title">Liên kết</div>
            <div class="link_href">
                <ul class="content">
                    <li class="active propClone"><a href="../page_Home/index.html">Trang chủ</a></li>
                    <li class="propClone"><a href="../page_Shop/shop.html">Cửa hàng</a></li>
                    <li class="propClone"><a href="../page_AboutUs/About_us.html">Thông tin</a></li>
                    <li class="propClone"><a href="../page_ContactUs/contact.html">Liên hệ</a></li>
                </ul>
            </div>
        </div>
        <div class="help">
            <div class="title">Hỗ trợ</div>
            <div class="link_href">
                <ul class="content">
                    <li class="active propClone"><a href="checkout.jsp">Thanh Toán</a></li>
                    <li class="propClone"><a href="returnProduct.jsp">Đổi/Trả</a></li>
                    <li class="propClone"><a href="privacy_policy.jsp">Chính sách bảo mật</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="footer_bottom">
    <div class="container">
        <div class="icon">
            <ul class="icons">
                <li><i class="fa fa-copyright"></i></li>
            </ul>
        </div>
        <div class="content"> Bản quyền của nhóm 6 - bộ môn Lập trình Web</div>
    </div>
</div>
</body>

</html>
