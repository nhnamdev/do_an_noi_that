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
    <title>Đăng nhập</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="css/login.css">
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
    <div class="slider2" style="background-color: #fff; height: 590px">
        <div class="login" style="margin: auto; width: 460px;">
            <h2 style="margin-left: 120px;">Đăng nhập</h2>
            <form action="login" method="post" style="margin-right: 32px;width: 426px;border: 2px dashed #6bae0e;padding-left: 30px; padding-bottom: 20px">

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

                <button type="submit" style="margin-left: 54px;">Đăng nhập</button>

            </form>
            <div class="lostpass" style="margin-left: 48px;">
                <a class="a_quenmatkhau" href="my_account_lostpass.jsp">Quên mật khẩu?</a>
                <a class="a_dangki" href="register.jsp">Đăng ký tài khoản?</a>
            </div>
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

</div>
<jsp:include page="components/footer.jsp" />
<script>
    function togglePassword() {
        const passwordField = document.getElementById("password");
        passwordField.type = passwordField.type === "password" ? "text" : "password";
    }
</script>
</body>

</html>
