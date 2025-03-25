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
          <div class="contact">Đổi mật khẩu</div>
        </div>
      </div>
    </div>
  </div>
  <div class="slider2" style="background-color: #fff; height: 650px">
    <div class="register" style="margin: 64px auto auto auto;border: 2px dashed #6bae0e; height: 300px;">
      <h3 style="text-align: center; ">Đổi mật khẩu</h3>
      <div class="login">
        <c:if test="${not empty error}">
          <div style="color: red; font-weight: bold;">
              ${error}
          </div>
        </c:if>
        <form action="updateProfile" method="post">
          <label for="username">Tên đăng nhập:</label>
          <input type="text" id="username" name="username" value="${sessionScope.userNameAccount}" required class="hienthi">

          <label for="oldPassword">Mật khẩu cũ:</label>
          <input type="password" id="oldPassword" name="password" required class="hienthi">

          <label for="newPassword">Mật khẩu mới:</label>
          <input type="password" id="newPassword" name="confirm_password" required class="hienthi">

          <div class="hienmatkhau" style="margin-top: 22px;">
            <input type="checkbox" id="show_password" onclick="togglePassword()">
            <label>Hiện mật khẩu</label>
          </div>

          <button type="submit">Đổi mật khẩu</button>
          <div class="lostpass" style="margin-left: 150px;">
            <a class="a_dangnhap" href="login.jsp">Đăng nhập </a>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script>
    function togglePassword() {
      const passwordField = document.getElementById("oldPassword");
      const confirmPasswordField = document.getElementById("newPassword");
      const type = passwordField.type === "password" ? "text" : "password";
      passwordField.type = type;
      confirmPasswordField.type = type;
    }

  </script>

  <jsp:include page="components/footer.jsp" />
</div>
</body>
</html>

