<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 25/12/2024
  Time: 05:48:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
  <script src="js/showHeader.js"></script>
  <div class="overlay" id="overlay"></div>
  <script src="js/showCart.js"></script>
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
        <%
          String success = (String) request.getAttribute("success");
          String error = (String) request.getAttribute("error");
          if(success != null) {
        %>
        <script>
          alert("<%= success %>");
        </script>
        <% } else if(error != null) { %>
        <script>
          alert("<%= error %>");
        </script>
        <% } %>
        <form action="register" method="post">
          <label for="fullname">Họ và tên:</label>
          <input type="text" id="fullname" name="full_name" required class="hienthi">

          <label for="birthdate">Ngày sinh:</label>
          <input type="text" id="birthdate" name="birth_day" required class="hienthi">

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

          <div class="hienmatkhau">
            <input type="checkbox" id="show_password" onclick="togglePassword()">
            <label>Hiện mật khẩu</label>
            <input type="checkbox" id="agree_terms" required>
            <label>Tôi đồng ý tạo tài khoản</label>
          </div>

          <button type="submit">Đăng ký</button>
          <div class="lostpass" style="margin-left: 150px;">
            <a href="login.jsp">Đăng nhập </a>
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
  </script>

  <jsp:include page="components/footer.jsp" />
</div>
</body>
</html>

