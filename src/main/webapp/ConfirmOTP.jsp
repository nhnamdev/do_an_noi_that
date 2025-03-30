
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
    <div class="login" style="margin: auto; width: 460px;">
      <h2 style="margin-left: 120px;">Kích hoạt tài khoản</h2>
      <form action="confirm" method="post" style="margin-right: 32px;width: 426px;border: 2px dashed #6bae0e;padding-left: 30px; padding-bottom: 20px">
        <c:if test="${not empty error}">
          <div style="color: red; font-weight: bold; width: 360px;">
              ${error}
          </div>
        </c:if>
        <label style="margin-top: 5px ">Nhập mã OTP:</label>
        <input class="dangnhap-matkhau" name="username" type="text">
        <button type="submit" style="margin-left: 54px;">Kích hoạt</button>
      </form>
    </div>
  </div>

</div>
<jsp:include page="components/footer.jsp" />
</body>

</html>
