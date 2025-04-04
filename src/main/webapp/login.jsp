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
    <link rel="stylesheet" href="css/login.css">
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
                    <div class="contact">Đăng nhập</div>
                </div>
            </div>
        </div>
    </div>
    <div class="slider2" style="background-color: #fff; height: 700px">
        <div class="login" style="margin: auto; width: 460px;">
            <h2 style="margin-left: 120px;">Đăng nhập</h2>
            <form action="login" method="post"
                  style="margin-right: 32px;width: 426px;border: 2px dashed #6bae0e;padding-left: 30px; padding-bottom: 20px">
                <c:if test="${not empty error}">
                    <div style="color: red; font-weight: bold; width: 360px;">
                            ${error}
                    </div>
                </c:if>
                <label style="margin-top: 5px ">Tên đăng nhập</label>
                <input class="dangnhap-matkhau" name="username" type="text">
                <label>Mật khẩu</label>
                <input class="dangnhap-matkhau" name="password" id="password" type="password" placeholder="">
                <div class="hienmatkhau">
                    <label id="hienmatkhau"><input type="checkbox" name="agree" value="yes"> Ghi nhớ đăng nhập</label>

                    <label>
                        <input type="checkbox" onclick="togglePassword()"> Hiện mật khẩu
                    </label>
                </div>
                <!-- Google reCAPTCHA -->
                <div class="g-recaptcha" data-sitekey="6Lek8vsqAAAAAGlMWAnGATelPA7HXTFyfZZaRK1K"></div>
                <div style="text-align: center; margin-top: 20px; display: flex; align-items: center;">
                    <hr style="width: 100px; border: 1px solid #000; margin-right: 10px;">
                    <h5 style="margin: 0; color: gray;">Đăng nhập với</h5>
                    <hr style="width: 100px; border: 1px solid #000; margin-left: 10px;">
                </div>
                <div class="loginOther" style="display: flex; margin-top: 10px;">
                    <div class="google" style="margin-right: 50px;margin-left: 50px;">
                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid
&redirect_uri=http://localhost:8080/source_do_an_noi_that_war/login?provider=google
&response_type=code
&client_id=313036133777-qlvuragc9njih90ffl86jj1gdlp0450d.apps.googleusercontent.com
&approval_prompt=force"
                           style="background-color: #4285F4; color: white; padding: 10px 10px; text-decoration: none; border-radius: 5px; display: inline-block;">
                            <i class="fab fa-google" style="margin-right: 8px;"></i> Google
                        </a>
                    </div>
                    <div class="facebook">
                        <a href="https://www.facebook.com/v19.0/dialog/oauth?
client_id=1298925587857868
&redirect_uri=http://localhost:8080/source_do_an_noi_that_war/login?provider=facebook"
                           style="background-color: #3b5998; color: white; padding: 10px 10px; text-decoration: none; border-radius: 5px; display: inline-block;">
                            <i class="fab fa-facebook-f" style="margin-right: 8px;"></i> Facebook
                        </a>
                    </div>
                </div>
                <button type="submit" style="margin-left: 54px;">Đăng nhập</button>
            </form>
            <div class="lostpass" style="margin-left: 48px;">
                <a class="a_quenmatkhau" href="my_account_lostpass.jsp">Quên mật khẩu?</a>
                <a class="a_dangki" href="register.jsp">Đăng ký tài khoản?</a>
            </div>
        </div>
    </div>

</div>
<jsp:include page="components/footer.jsp"/>
<script>
    function togglePassword() {
        const passwordField = document.getElementById("password");
        passwordField.type = passwordField.type === "password" ? "text" : "password";
    }
</script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
</body>

</html>
