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
          <div style="color: red; font-weight: bold;">
              ${error}
          </div>
        </c:if>
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
            <a class="a_dangnhap" href="login.jsp">Đăng nhập </a>
          </div>
        </form>


      </div>
    </div>
  </div>
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      let form = document.querySelector("form");

      if (form) {
        form.addEventListener("submit", function (event) {
          if (!validateForm()) {
            event.preventDefault(); // ✅ Ngăn chặn form gửi đi
          }
        });
      }
    });
    function validateForm() {
      let isValid = true;

      function getInputValue(id) {
        let element = document.getElementById(id);
        return element ? element.value.trim() : "";
      }

      let fullName = getInputValue("fullname");
      let birthDate = getInputValue("birthdate");
      let email = getInputValue("email");
      let phone = getInputValue("phone");
      let address = getInputValue("address");
      let username = getInputValue("username");
      let password = getInputValue("password");
      let confirmPassword = getInputValue("confirm_password");

      // Regex kiểm tra
      let nameRegex = /^[A-Za-zÀ-Ỹà-ỹ\s]{2,}$/;
      let birthDateRegex = /^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[0-2])[-/.](19|20)\d{2}$/;
      let emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
      let phoneRegex = /^0\d{9}$/;
      let addressRegex = /^[A-Za-z0-9\s,.\-]{5,}$/;
      let usernameRegex = /^[a-zA-Z0-9_]{5,20}$/;
      let passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;

      // Hàm hiển thị lỗi và chặn gửi form
      function showError(message) {
        alert(message);
        isValid = false;
      }

      // Kiểm tra input
      if (!fullName || !nameRegex.test(fullName)) showError("Họ và tên không hợp lệ!");
      if (!birthDate || !birthDateRegex.test(birthDate)) showError("Ngày sinh phải có định dạng dd/mm/yyyy hoặc dd-mm-yyyy.");
      if (!email || !emailRegex.test(email)) showError("Email không hợp lệ!");
      if (!phone || !phoneRegex.test(phone)) showError("Số điện thoại phải có 10 chữ số và bắt đầu bằng 0!");
      if (!address || !addressRegex.test(address)) showError("Địa chỉ không hợp lệ!");
      if (!username || !usernameRegex.test(username)) showError("Tên đăng nhập từ 5-20 ký tự, chỉ chứa chữ, số, dấu gạch dưới!");
      if (!password || !passwordRegex.test(password)) showError("Mật khẩu phải có ít nhất 6 ký tự, 1 chữ hoa, 1 số, 1 ký tự đặc biệt!");
      if (password !== confirmPassword) showError("Mật khẩu xác nhận không khớp!");

      return isValid; // Trả về false nếu có lỗi, chặn form gửi đi
    }



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

