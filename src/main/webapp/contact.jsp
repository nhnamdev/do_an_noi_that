<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Product> cartProducts = (List<Product>) session.getAttribute("cartProducts");
    if (cartProducts == null) {
        cartProducts = new ArrayList<Product>();
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đồ án web</title>
    <link rel="stylesheet" href="css/contact_style.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css"/>
    <script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"></script>
</head>

<body>
<div class="contactUs">
    <jsp:include page="/components/header.jsp"/>
    <script src="js/showSearch.js"></script>
    <script src="js/showHeader.js"></script>
    <script src="js/actionOfProfile.js"></script>
    <div class="overlay" id="overlay"></div>
    <div class="info-box" id="infoBox">
        <div class="container">
            <h3>Thông tin giỏ hàng</h3>
            <div class="listProduct">
                <c:forEach var="item" items="${sessionScope.cartProducts}">
                    <div class="row1">
                        <div class="alpha">
                            <img src="${item.image}" alt="">
                        </div>
                        <div class="omega">
                            <div class="name">${item.name}</div>
                            <div class="sumPrice">
                                <div class="quantity">${item.quantity} X</div>
                                <div class="price">${item.price * item.quantity}đ</div>
                            </div>
                        </div>
                        <div class="beta">
                            <button class="close-button">
                                <i class="fa fa-times-circle"></i>
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="totalPrice">
                <div class="title">Tổng tiền</div>
                <div class="price">
                    <%
                        double totalPrice = 0;
                        for (Product item : cartProducts) {
                            totalPrice += item.getPrice() * item.getQuantity();
                        }

                    %>
                    <%= totalPrice %>đ
                </div>
            </div>
            <div class="other_choose">
                <button class="view_cart" onclick="window.location.href='cart.jsp'">Giỏ hàng</button>
                <button class="check_out" onclick="window.location.href='checkout.jsp'">Thanh toán</button>
            </div>
        </div>
    </div>
    <script src="js/showCart.js"></script>
    <div class="navigation_titlePage">
        <div class="container">
            <div class="alpha">
                <img src="img/background.jpg" alt="">
            </div>
            <div class="omega">
                <h1 class="title">Liên hệ</h1>
                <div class="path">
                    <div class="home">Trang chủ</div>
                    <div class="icon">
                        <ul class="icons">
                            <li><i class="fa fa-chevron-right"></i></li>
                        </ul>
                    </div>
                    <div class="contact">Liên hệ</div>
                </div>
            </div>
        </div>
    </div>
    <div class="content_section_1">
        <div class="container">
            <div class="title">
                <div class="labelTitle">Liên Hệ Với Chúng Tôi</div>
                <div class="more_information">Để biết thêm thông tin về sản phẩm và dịch vụ của chúng tôi. Vui lòng
                    gửi
                    Email cho chúng tôi.<br> Đội ngũ nhân viên của chúng tôi luôn sẵn sàng hỗ trợ bạn. Đừng ngần
                    ngại!
                </div>
            </div>
            <div class="content">
                <div class="alpha">
                    <div class="profileShop">
                        <iframe
                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.2587181495715!2d106.78530537590657!3d10.867916257497754!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752763da4787b9%3A0x5e4f93c5d6c4da68!2zxJDhuqFpIGjhu41jIE7DtG5nIEzDom0!5e0!3m2!1svi!2s!4v1742479268570!5m2!1svi!2s"
                                width="100%" height="660"
                                style="border:0; margin-top: 20px ;margin-left:10px ;margin-bottom: 10px;"
                                allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                </div>
                <div class="omega">
                    <div class="profile-Shop">
                        <div class="phone">
                            <div class="title">Số hotline
                                <div class="content">Mobile: +(84) 793451527
                                </div>
                            </div>
                        </div>
                        <div class="address">
                            <div class="title">Địa chỉ
                                <div class="content">Trường Đại học Nông Lâm TP.HCM, Phường
                                    Linh Trung, TP. Hồ Chí Minh
                                </div>
                            </div>

                        </div>
                    </div>
                    <form id="contact_form" method="post" action="contact" pix-confirm="hidden_pix_6">
                        <div class="inputName">
                            <label class="fullName">Họ và tên</label>
                            <input type="text" name="name" id="name" value="${sessionScope.userName}" required>
                        </div>
                        <div class="inputEmail">
                            <label for="email">Địa chỉ email</label>
                            <input type="email" name="email" id="email" value="${sessionScope.userEmail}" required>
                        </div>
                        <div class="inputSubject">
                            <label for="Subject">Chủ đề</label>
                            <input type="text" name="subject" id="subject" placeholder="Tùy chọn">
                        </div>
                        <div class="message-container">
                            <label for="message">Lời nhắn</label>
                            <textarea name="message" id="message" placeholder="Xin chào! Tôi muốn hỏi bạn về..."
                                      required></textarea>
                        </div>
                        <span class="send_btn">
                                <button type="submit" class="submit_btn">
                                    <span class="text">Gửi</span>
                                </button>
                            </span>
                    </form>
                </div>
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
    <jsp:include page="components/footer.jsp"/>
</div>
</body>

</html>
