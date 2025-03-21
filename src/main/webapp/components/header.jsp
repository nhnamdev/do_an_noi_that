
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
        <ul class="navbar-left" style="height: 50px;padding: 0;">
          <li>
            <div class="order-1 logo-wrapper">
              <a class="logo nasa-logo-retina" href="index" title="Mona Media" rel="Trang chủ" style="margin-left: 80px;">
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
        <ul class="navbar-right" style="padding: 0">
          <c:if test="${sessionScope.loginModel==null}">

            <li class="User">
              <ul class="menu">
                <li class="menu-item">
                  <a class="login-register" href="login.jsp" style="margin-left: 10px">
                    <svg width="24" height="24" viewBox="0 0 32 32" fill="currentColor">
                      <path d="M16 3.205c-7.067 0-12.795 5.728-12.795 12.795s5.728 12.795 12.795 12.795 12.795-5.728 12.795-12.795c0-7.067-5.728-12.795-12.795-12.795zM16 4.271c6.467 0 11.729 5.261 11.729 11.729 0 2.845-1.019 5.457-2.711 7.49-1.169-0.488-3.93-1.446-5.638-1.951-0.146-0.046-0.169-0.053-0.169-0.66 0-0.501 0.206-1.005 0.407-1.432 0.218-0.464 0.476-1.244 0.569-1.944 0.259-0.301 0.612-0.895 0.839-2.026 0.199-0.997 0.106-1.36-0.026-1.7-0.014-0.036-0.028-0.071-0.039-0.107-0.050-0.234 0.019-1.448 0.189-2.391 0.118-0.647-0.030-2.022-0.921-3.159-0.562-0.719-1.638-1.601-3.603-1.724l-1.078 0.001c-1.932 0.122-3.008 1.004-3.57 1.723-0.89 1.137-1.038 2.513-0.92 3.159 0.172 0.943 0.239 2.157 0.191 2.387-0.010 0.040-0.025 0.075-0.040 0.111-0.131 0.341-0.225 0.703-0.025 1.7 0.226 1.131 0.579 1.725 0.839 2.026 0.092 0.7 0.35 1.48 0.569 1.944 0.159 0.339 0.234 0.801 0.234 1.454 0 0.607-0.023 0.614-0.159 0.657-1.767 0.522-4.579 1.538-5.628 1.997-1.725-2.042-2.768-4.679-2.768-7.555 0-6.467 5.261-11.729 11.729-11.729z"></path>
                    </svg>
                    <span>Đăng nhập / Đăng ký</span>
                  </a>
                </li>
              </ul>
            </li>
          </c:if>
          <c:if test="${sessionScope.loginModel!=null}">
            <li class="User">
              <a href="personal.jsp">
                <img src="img/avt.jpg" alt="" class="user-avatar"
                     style="width: 22px; height: 18px;border-radius: 100%;border: 2px solid lightgray;">
              </a>
            </li>
            <li class="Favorite"><a href="favorite.jsp"><i class="fa fa-bookmark"></i></a></li>
            <li class="Shopping"><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
          </c:if>
          <li class="Search">
            <a href="#" id="searchIcon"><i class="fa fa-search"></i></a>
            <form action="searchProduct.jsp" method="get" id="searchForm">
              <input id="search" name="search" type="search" placeholder="Tìm kiếm" required>
              <button type="submit" style="display:none;">Search</button>
            </form>
          </li>
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
