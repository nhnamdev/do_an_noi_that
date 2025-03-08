<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin đơn hàng</title>
    <link rel="stylesheet" href="css/oderInformation_styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
<div class="cart">
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
                        <img src="img/avt.jpg" alt="">
                    </li>
                    <li class="Search">
                        <a href="#" id="searchIcon"><i class="fa fa-search"></i></a>
                        <form action="searchProduct.jsp" method="get" id="searchForm">
                            <input id="search" name="search" type="search" placeholder="Tìm kiếm" required>
                            <button type="submit" style="display:none;">Search</button>
                        </form>
                    </li>
                    <li class="Favorite"><a href="favorite.jsp"><i
                            class="fa fa-bookmark"></i></a></li>
                    <li class="Shopping"><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                </ul>
                <div class="boxHeader" id="boxHeader">
                    <div class="imageContainer">
                        <img id="imageHeader" src="img/avt.jpg" alt="">
                    </div>
                    <h4>${sessionScope.userName}</h4>
                    <hr>
                    <a href="personal.jsp" id="infoBtn" class="info-button"><span>Xem thông
                                tin</span></a>
                    <a href="oderInformation.jsp" id="infoBtn"
                       class="info-button"><span>Đơn hàng</span></a>
                    <a href="my_account.jsp" id="logoutBtn" class="logout-button"><span>Đăng
                                xuất</span></a>
                </div>
                <div id="layoutHeader"></div>
            </div>
        </div>
    </div>
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
                            <form action="" method="post">
                                <input type="hidden" name="productId" value="${item.id}">
                                <button type="submit" class="close-button"
                                        onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                    <i class="fa fa-times-circle"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="totalPrice">
                <div class="title">Tổng tiền</div>
                <div class="price">
                    <%
                        double totalPrice = 0;
                        List<Product> cartProducts = (List<Product>) session.getAttribute("cartProducts");
                        if (cartProducts == null) {
                            cartProducts = new ArrayList<Product>();
                        }
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
    <div class="content_section_1">
        <div class="Info">
            <div class="profile-sidebar">
                <div class="profile-header">
                    <img src="img/avt.jpg" alt="">
                    <div class="profile-info">
                        <p class="username">${sessionScope.userName}</p>
                        <a href="personal.jsp" class="edit-profile">Sửa Hồ Sơ</a>
                    </div>
                </div>
                <div class="menu-item">
                    <i class="fa fa-user" aria-hidden="true"></i>
                    <a href="personal.jsp">Tài Khoản Của Tôi</a>
                </div>
                <div class="menu-item">
                    <i class="fa fa-shopping-basket" aria-hidden="true"></i>
                    <a href="#">Đơn Mua Hàng</a>
                </div>
            </div>
        </div>

        <div class="section">
            <div class="tab-menu">
                <button class="tab-link active" onclick="showTab('all')">Tất cả</button>
                <button class="tab-link" onclick="showTab('pending')">Chờ xử lý</button>
                <button class="tab-link" onclick="showTab('wait-delivery')">Chờ giao hàng</button>
                <button class="tab-link" onclick="showTab('shipping')">Vận chuyển</button>
                <button class="tab-link" onclick="showTab('completed')">Hoàn thành</button>
                <button class="tab-link" onclick="showTab('cancelled')">Hủy đơn</button>
            </div>
            <div class="search-bar">
                <input type="text" placeholder="Tìm kiếm sản phẩm...">
            </div>

            <div class="product">
                <!-- Chờ xử lý -->
                <div class="order-section-product pending" id="pending-orders">
                    <h2>Chờ xử lý</h2>
                    <c:forEach var="order" items="${orderList}">
                        <c:if test="${order.pending == 0}">
                            <a href="waitingOrder.jsp?pid=${order.id}" style="text-decoration: none; color: inherit;">
                                <div class="order-card">
                                    <img src="${order.img}" alt="Product Image">
                                    <div class="order-details">
                                        <h3>${order.nameProduct}</h3>
                                        <p>Số lượng: ${order.quantity}</p>
                                        <p>Mã đơn hàng: ${order.id}</p>
                                        <p class="price">Giá: ${order.price}đ</p>
                                    </div>
                                    <div class="order-actions">
                                        <button class="can-click">Hủy đơn</button>
                                    </div>
                                </div>
                            </a>
                        </c:if>
                    </c:forEach>
                </div>

                <!-- Chờ giao hàng -->
                <div class="order-section-product wait-delivery" id="wait-delivery-orders">
                    <h2>Chờ giao hàng</h2>
                    <c:forEach var="order" items="${orderList}">
                        <c:if test="${order.pending == 1}">
                            <a href="wait_delivery.jsp?pid=${order.id}" style="text-decoration: none; color: inherit;">
                                <div class="order-card">
                                    <img src="${order.img}" alt="Product Image">
                                    <div class="order-details">
                                        <h3>${order.nameProduct}</h3>
                                        <p>Số lượng: ${order.quantity}</p>
                                        <p>Mã đơn hàng: ${order.id}</p>
                                        <p class="price">Giá: ${order.price}đ</p>
                                    </div>
                                    <div class="order-actions">
                                        <button class="disabled">Đang chờ giao hàng</button>
                                    </div>
                                </div>
                            </a>
                        </c:if>
                    </c:forEach>
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
    <script src="js/oderInformation_script.js"></script>
</body>

</html>
