
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Title</title>
    <link rel="stylesheet" href="/css/style.css">
  </head>
  <body>
  <div class="header">
    <div class="container">
      <div class="left">
        <ul class="navbar-left">
          <li>
            <div class="order-1 logo-wrapper">
              <a class="logo nasa-logo-retina" href="index" title="Mona Media" rel="Trang chủ">
              <img src="//noithat-nhadep.monamedia.net/wp-content/uploads/2024/04/1-e1713930644851.png"
                   alt="Mona Media"
                   class="header_logo"
                   srcset="//noithat-nhadep.monamedia.net/wp-content/uploads/2024/04/1-e1713930644851.png 1x,
                         //noithat-nhadep.monamedia.net/wp-content/uploads/2024/04/1-e1713930644851.png 2x">
              </a>
            </div>
          </li>
          <li class="Home"><a href="index">Trang chủ</a></li>
          <li class="Shop"><a href="shop.jsp">Cửa hàng</a></li>
          <li class="AboutUs"><a href="About_us.jsp">Thông tin</a></li>
          <li class="ContactUs"><a href="contact.jsp">Liên hệ</a></li>
        </ul>
      </div>
      <div class="right">
        <ul class="navbar-right">
          <c:if test="${sessionScope.loginModel==null}">
            <li class="User">
              <a href="login.jsp"><i class="fa fa-user"></i></a></li>
          </c:if>
          <c:if test="${sessionScope.loginModel!=null}">
            <li class="User">
              <a href="personal.jsp">
                <img src="img/avt.jpg" alt="" class="user-avatar"
                     style="width: 22px; height: 18px;border-radius: 100%;border: 2px solid lightgray;">
              </a>
            </li>
          </c:if>
          <li class="Search">
            <a href="#" id="searchIcon"><i class="fa fa-search"></i></a>
            <form action="searchProduct.jsp" method="get" id="searchForm">
              <input id="search" name="search" type="search" placeholder="Tìm kiếm" required>
              <button type="submit" style="display:none;">Search</button>
            </form>
          </li>
          <li class="Favorite"><a href="favorite.jsp"><i class="fa fa-bookmark"></i></a></li>
          <li class="Shopping"><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
        </ul>


      </div>
      <script>
        const searchIcon = document.getElementById("searchIcon");
        const searchForm = document.getElementById("searchForm");

        searchIcon.addEventListener("click", function (event) {
          event.preventDefault();
          searchForm.style.display = (searchForm.style.display === "block") ? "none" : "block";
        });

      </script>
    </div>
  </div>
  </body>
</html>
