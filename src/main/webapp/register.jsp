<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đồ án web</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="css/register.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div>
    <jsp:include page="/components/header.jsp"/>
    <div class="overlay" id="overlay"></div>
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
                    <div class="contact">Đăng ký</div>
                </div>
            </div>
        </div>
    </div>
    <div class="slider2" style="background-color: #fff; height: 910px">
        <div class="register" style="margin: 64px auto auto auto;border: 2px dashed #6bae0e; height: 646px;">
            <h3 style="text-align: center; ">Đăng Ký</h3>
            <div class="login">
                <c:if test="${not empty error}">
                    <div style="color: red; font-weight: 100;font-size: 10px">
                            ${error}
                    </div>
                </c:if>
                <form action="register" method="post">
                    <label for="fullname">Họ và tên:</label>
                    <input type="text" id="fullname" name="full_name" required class="hienthi">
                    <small>Ít nhất 2 ký tự, có thể chứa dấu tiếng Việt.</small>

                    <label for="email">Địa chỉ email:</label>
                    <input type="email" id="email" name="email" required class="hienthi">
                    <small>Ví dụ: example@gmail.com</small>

                    <label for="phone">Số điện thoại:</label>
                    <input type="text" id="phone" name="phone_number" required class="hienthi">
                    <small>Bắt đầu bằng 0 và gồm đúng 10 chữ số.</small>

                    <label for="username">Tên đăng nhập:</label>
                    <input type="text" id="username" name="username" required class="hienthi">
                    <small>5-20 ký tự, chỉ gồm chữ, số hoặc dấu gạch dưới (_).</small>

                    <label for="password">Mật khẩu:</label>
                    <input type="password" id="password" name="password" required class="hienthi">
                    <small>Tối thiểu 6 ký tự, gồm 1 chữ hoa, 1 số, 1 ký tự đặc biệt.</small>

                    <label for="confirm_password">Xác nhận mật khẩu:</label>
                    <input type="password" id="confirm_password" name="confirm_password" required class="hienthi">
                    <small>Phải khớp với mật khẩu phía trên.</small>

                    <div class="hienmatkhau" style="margin-top: 22px;">
                        <input type="checkbox" id="show_password" onclick="togglePassword()">
                        <label>Hiện mật khẩu</label>
                        <br>
                        <input type="checkbox" id="agree_terms" required>
                        <label>Tôi đồng ý tạo tài khoản</label>
                    </div>

                    <button type="submit">Đăng ký</button>

                    <div class="lostpass" style="margin-left: 145px;">
                        <a class="a_dangnhap" href="login.jsp">Đăng nhập </a>
                    </div>
                </form>


            </div>
        </div>
    </div>
    <script>

        function togglePassword() {
            // Lấy cả hai trường mật khẩu và xác nhận mật khẩu
            const passwordField = document.getElementById("password");
            const confirmPasswordField = document.getElementById("confirm_password");

            // Đổi type của cả hai trường
            const type = passwordField.type === "password" ? "text" : "password";
            passwordField.type = type;
            confirmPasswordField.type = type;
        }

        //Block coppy paste
        document.addEventListener("DOMContentLoaded", function () {
            let passwordFields = document.querySelectorAll("input[type='password']");

            passwordFields.forEach(function (field) {
                field.addEventListener("copy", function (e) {
                    e.preventDefault();
                    alert("Không thể sao chép mật khẩu!");
                });

                field.addEventListener("cut", function (e) {
                    e.preventDefault();
                    alert("Không thể cắt mật khẩu!");
                });

                field.addEventListener("paste", function (e) {
                    e.preventDefault();
                    alert("Không thể dán vào ô mật khẩu!");
                });
            });
        });

    </script>

    <jsp:include page="components/footer.jsp"/>
</div>
</body>
</html>

