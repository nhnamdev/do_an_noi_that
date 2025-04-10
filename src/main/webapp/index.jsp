<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <jsp:include page="components/header.jsp"/>

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
                <h1 style="margin-left: 0;">Lựa chọn hàng đầu</h1>
                <p style="margin-right: 0;">Tìm đồ dùng phù hợp với sở
                    thích của bạn với bộ sưu tập nội thất của chúng tôi.</p>
            </div>
            <div class="img-sanpham">
                <c:forEach var="p" items="${listProduct}">
                    <div class="img-1" style="    margin-left: 60px;">
                        <img src="${p.img}" height="287" width="287"/>
                        <p>${p.name}</p>
                        <h2>Giá: <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/> VND</h2>
                    </div>
                </c:forEach>
            </div>
            <div class="footer-slider3">
                <a href="${pageContext.request.contextPath}/shop" class="shop-now">Xem thêm</a>
            </div>
        </div>
        <div class="slider4">
            <div class="bosuutap" style="margin-left: 2%;">
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
        <jsp:include page="components/footer.jsp"/>
    </div>
</div>


</body>
</html>