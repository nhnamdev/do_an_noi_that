
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Title</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top shadow-sm">
  <div class="container">
    <a class="navbar-brand" href="index" style="padding-top: 0;">
      <img src="//noithat-nhadep.monamedia.net/wp-content/uploads/2024/04/1-e1713930644851.png" alt="Mona Media" class="header_logo" width="120">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link" href="index">Trang chủ</a></li>
        <li class="nav-item"><a class="nav-link" href="shop">Cửa hàng</a></li>
        <li class="nav-item"><a class="nav-link" href="news.jsp">Tin tức</a></li>
        <li class="nav-item"><a class="nav-link" href="About_us.jsp">Thông tin</a></li>
        <li class="nav-item"><a class="nav-link" href="contact.jsp">Liên hệ</a></li>
      </ul>
      <ul class="navbar-nav ms-auto">
        <c:if test="${sessionScope.loginModel==null && sessionScope.googleAccount == null}">
          <li class="nav-item">
            <a class="nav-link" href="login.jsp">
              <i class="fas fa-user"></i> Đăng nhập / Đăng ký
            </a>
          </li>
        </c:if>
        <c:if test="${sessionScope.loginModel!=null || sessionScope.googleAccount != null}">
          <li class="nav-item">
            <a class="nav-link" href="personal.jsp">
              <img src="img/avt.jpg" class="rounded-circle" width="22">
            </a>
          </li>
          <li class="nav-item"><a class="nav-link" href="favorite.jsp"><i class="fa fa-bookmark"></i></a></li>
          <li class="nav-item"><a class="nav-link" href="cart.jsp"><i class="fa fa-shopping-cart"></i></a></li>
        </c:if>
        <li class="nav-item">
          <a class="nav-link" href="#" id="searchIcon"><i class="fa fa-search"></i></a>
        </li>
      </ul>
    </div>
  </div>
</nav>
<%--Lam phan tim kiem vao day roi hien len--%>
<%--<form class="d-none position-absolute bg-white p-3 border rounded" id="searchForm" style="top: 70px; right: 10%;">--%>
<%--  <input class="form-control" type="search" name="search" placeholder="Tìm kiếm" required>--%>
<%--  <button class="btn btn-primary mt-2" type="submit">Search</button>--%>
<%--</form>--%>

<script>
  document.getElementById("searchIcon").addEventListener("click", function(event) {
    event.preventDefault();
    let searchForm = document.getElementById("searchForm");
    searchForm.classList.toggle("d-none");
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
