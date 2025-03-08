<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 04/01/2025
  Time: 08:13:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="css/my_account_lostpass.css">
</head>
<body>
<div>
    <div class="header">
        <div class="container">
            <div class="left">
                <ul class="navbar-left">
                    <li class="Home"><a href="index.jsp">Trang chủ</a></li>
                    <li class="Shop"><a href="shop.jsp">Cửa hàng</a></li>
                    <li class="AboutUs"><a href="About_us.jsp">Thông tin</a></li>
                    <li class="ContactUs"><a href="contact.jsp">Liên hệ</a></li>
                </ul>
            </div>
            <div class="right">
                <ul class="navbar-right">
                    <li class="User">
                        <a href="login.jsp"><i class="fa fa-user"></i></a></li>
                    </li>
                    <li class="Search">
                        <a href="#" id="searchIcon"><i class="fa fa-search"></i></a>
                        <form id="searchForm">
                            <input id="search" type="search" placeholder="Tìm kiếm" required>
                        </form>
                    </li>
                    <li class="Favorite"><a href="#"><i class="fa fa-bookmark"></i></a></li>
                    <li class="Shopping"><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                </ul>
                <script>
                    // Lấy phần tử icon và form tìm kiếm
                    const searchIcon = document.getElementById("searchIcon");
                    const searchForm = document.getElementById("searchForm");

                    // Thêm sự kiện click cho icon tìm kiếm
                    searchIcon.addEventListener("click", function (event) {
                        event.preventDefault(); // Ngăn chặn hành động mặc định của link
                        searchForm.style.display = (searchForm.style.display === "block") ? "none" : "block";
                    });

                </script>
            </div>
        </div>
    </div>
    <div class="overlay" id="overlay"></div>
    <script src="../page_SingleProduct/showCart.js"></script>
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
                    <div class="contact">Quên mật khẩu</div>
                </div>
            </div>
        </div>
    </div>
    <div class="slider2">
        <div class="login">
            <div>
                <c:if test="${not empty success}">
                    <p style="color: green;">${success}</p>
                </c:if>
                <c:if test="${not empty error}">
                    <p style="color: red;">${error}</p>
                </c:if>
            </div>
            <form action="forgot-password" method="post">
                <h2>Quên mật khẩu</h2>
                <label for="email">Địa chỉ email</label>
                <input class="dangnhap-matkhau" type="email" name="email" id="email" required>
                <div class="butt">
                    <button type="submit">Lấy lại mật khẩu</button>
                </div>
            </form>
            <a id="quaylai" href="login.jsp">Quay lại</a>
        </div>
    </div>
</div>
<div class="content_section_2">
    <div class="container">
        <div class="item">
            <div class="card">
                <i class="fa fa-truck"></i>
            </div>
            <div class="content">
                <div class="free_delivery">
                    <h2 class="title">Miễn Phí Giao Hàng</h2>
                    <div class="content_div">Đối với các đơn hàng có giá trị trên 2.000K sẽ được miễn phí phí vận
                        chuyển
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
                    <li class="active propClone"><a href="index.jsp">Trang chủ</a></li>
                    <li class="propClone"><a href="shop.jsp">Cửa hàng</a></li>
                    <li class="propClone"><a href="About_us.jsp">Thông tin</a></li>
                    <li class="propClone"><a href="contact.jsp">Liên hệ</a></li>
                </ul>
            </div>
        </div>
        <div class="help">
            <div class="title">Hỗ trợ</div>
            <div class="link_href">
                <ul class="content">
                    <li class="active propClone"><a href="checkout.jsp">Thanh Toán</a></li>
                    <li class="propClone"><a href="returnProduct.jsp">Đổi/Trả</a></li>
                    <li class="propClone"><a href="privacy_policy.jsp">Chính sách bảo mật</a>
                    </li>
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
