<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mona - Decor</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
<div>
    <div class="contactUs">
        <jsp:include page="components/header.jsp" />

        <script src="js/showHeader.js"></script>
        <script src="js/showSearch.js"></script>

        <div class="slider1">
            <div class="easypin">
                <a href="index">
                    <img src="https://noithat-nhadep.monamedia.net/wp-content/uploads/2024/04/slider-home-furniture.jpg"
                         alt="Home Furniture">
                </a>
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
        <jsp:include page="components/footer.jsp" />
    </div>
</div>
</body>
</html>