<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
  <jsp:include page="/components/header.jsp" />
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
          <label for="fullname" style="margin-top: 0;">Họ và tên:</label>
          <input type="text" id="fullname" name="full_name" required class="hienthi">

          <label for="birthdate">Ngày sinh:</label>
          <input type="date" id="birthdate" name="birth_day" required class="hienthi">

          <label for="email">Địa chỉ email:</label>
          <input type="email" id="email" name="email" required class="hienthi">

          <label for="phone">Số điện thoại:</label>
          <input type="text" id="phone" name="phone_number" required class="hienthi">

          <label for="address">Địa chỉ:</label>
          <input type="text" id="address" name="address" class="hienthi">

          <label for="username">Tên đăng nhập:</label>
          <input type="text" id="username" name="username" required class="hienthi">

          <label for="password">Mật khẩu:</label>
          <input type="password" id="password" name="password" required class="hienthi">

          <label for="confirm_password">Xác nhận mật khẩu:</label>
          <input type="password" id="confirm_password" name="confirm_password" required class="hienthi">

          <div class="hienmatkhau" style="margin-top: 22px;">
            <input type="checkbox" id="show_password" onclick="togglePassword()">
            <label>Hiện mật khẩu</label>
            <input type="checkbox" id="agree_terms" required>
            <label>Tôi đồng ý tạo tài khoản</label>
          </div>

          <button type="submit">Đăng ký</button>
          <div class="lostpass" style="margin-left: 150px;">
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

  <jsp:include page="components/footer.jsp" />
</div>
</body>
</html>

