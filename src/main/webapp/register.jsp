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
  <div class="slider2">
    <div class="register">
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
  <div class="content_section_2">
    <div class="container">
      <div class="item">
        <div class="card">
          <i class="fa fa-truck"></i>
        </div>
        <div class="content">
          <div class="free_delivery">
            <h2 class="title">Miễn Phí Giao Hàng</h2>
            <div class="content_div">Đối với các đơn hàng có giá trị trên 2.000K sẽ được miễn phí phí
              vận chuyển
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
            <li class="active propClone"><a href="../page_CheckOut/checkout.html">Thanh Toán</a></li>
            <li class="propClone"><a href="../page_ReturnProduct/returnProduct.html">Đổi/Trả</a></li>
            <li class="propClone"><a href="../page_PrivacyPolicy/privacy_policy.html">Chính sách bảo
              mật</a></li>
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
</div>
</body>
</html>

