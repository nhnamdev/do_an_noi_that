<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
<div>
    <div class="contactUs">
        <jsp:include page="/WEB-INF/header.jsp" />
        <script src="js/showHeader.js"></script>
        <script src="js/showSearch.js"></script>

        <div class="slider1">
            <div class="text">
                <h1>Ghế đôi</h1>
                <a href="#" class="shop-now">Mua ngay</a>
            </div>
            <div class="img">
                <img src="assets_duc/img/ghesalon.jpg" height="650" width="650" alt="Sliding Image"
                     class="image-slide-in"/>
            </div>
        </div>
        <div class="slider2">
            <div class="img-left">
                <img src="assets_duc/img/banphu.png" height="450" width="450"/>
                <h1>Bàn phụ</h1>
                <a href="#" class="shop-now">Xem thêm</a>
            </div>
            <div class="img-right">
                <img src="assets_duc/img/sofa-don-vai-1.png" height="450" width="450"/>
                <h1>Ghế phụ</h1>
                <a href="#" class="shop-now1">Xem thêm</a>
            </div>
        </div>
        <div class="slider3">
            <div class="header1">
                <h1>Lựa chọn hàng đầu</h1>
                <p>Tìm đồ dùng phù hợp với sở
                    thích của bạn với bộ sưu tập nội thất của chúng tôi.</p>
            </div>
            <div class="img-sanpham">
                <div class="img-1">
                    <img src="assets_duc/img/Trenton%20modular%20sofa_3%201.png" height="287" width="287"/>
                    <p>Ghế đơn Sofa mô-đun Trenton_3</p>
                    <h2>Giá: 25.000.000</h2>
                </div>
                <div class="img-2">
                    <img src="assets_duc/img/Granite%20dining%20table%20with%20dining%20chair%201.png" height="185"
                         width="255"/>
                    <p>Bàn ăn đá granite kèm ghế</p>
                    <h2>Giá: 15.000.000</h2>
                </div>
                <div class="img-3">
                    <img src="assets_duc/img/Outdoor%20bar%20table%20and%20stool%201.png" height="247" width="250"/>
                    <p>Bàn ghế quầy bar ngoài trời</p>
                    <h2>Giá: 10.000.000</h2>
                </div>
                <div class="img-4">

                    <img src="assets_duc/img/Plain%20console%20with%20teak%20mirror%201.png" height="174"
                         width="240"/>
                    <p>Bảng điều khiển đơn giản với gương bằng gỗ tếch</p>
                    <h2>Giá: 5.000.000</h2>
                </div>
            </div>
            <div class="footer-slider3">
                <a href="#" class="shop-now">Xem thêm</a>
            </div>
        </div>
        <div class="slider4">
            <div class="bosuutap">
                <img src="assets_duc/img/Asgaard%20sofa%201.png" height="799" width="947"/>
            </div>
            <div class="bosuutap-text">
                <h3>Bộ sưu tập mới</h3>
                <h2>Asgaard sofa</h2>
                <a href="">
                    <button>Mua ngay</button>
                </a>
            </div>
        </div>
        <div class="slider5">
            <div class="slider5-text">
                <h2>Instagram</h2>
                <p>Theo dõi của hàng của chúng tôi qua Instagram</p>
                <a href="#">
                    <button>Theo dõi</button>
                </a>
            </div>
        </div>
        <div class="footer">
            <div class="container">
                <div class="user">
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
                            <li class="active propClone"><a href="checkout.jsp">Thanh Toán</a></li>
                            <li class="propClone"><a href="returnProduct.jsp">Đổi/Trả</a></li>
                            <li class="propClone"><a href="privacy_policy.jsp">Chính sách bảo
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
</div>
</body>
</html>