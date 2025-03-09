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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>
<div class="contactUs">
    <jsp:include page="/components/header.jsp" />
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
                        <div class="address">
                            <ul class="bottom-icons">
                                <li><i class="fa fa-compass"></i></li>
                            </ul>
                            <div class="title">Địa chỉ
                                <div class="content">Tòa RD306, Trường Đại học Nông Lâm TP.HCM<br> Khu phố 6, Phường
                                    Linh
                                    Trung, TP. Thủ Đức,<br> TP. Hồ Chí Minh
                                </div>
                            </div>
                        </div>
                        <div class="phone">
                            <ul class="bottom-icons">
                                <li><i class="fa fa-mobile"></i></li>
                            </ul>
                            <div class="title">Số hotline
                                <div class="content">Mobile: +(84) 793450529<br>Mobile: +(84) 933454194<br>Mobile:
                                    +(84)
                                    327562363
                                </div>
                            </div>
                        </div>
                        <div class="workingTime">
                            <ul class="bottom-icons">
                                <li><i class="fa fa-hourglass-half"></i></li>
                            </ul>
                            <div class="title">Thời gian làm việc
                                <div class="content">Thứ bảy: 12:15 - 14:45</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="omega">
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
</body>

</html>
