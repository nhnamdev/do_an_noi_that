<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Order" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.OrderDao" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String productId = request.getParameter("pid");
    OrderDao orderDao = new OrderDao();
    Order o = orderDao.getOrderById(Integer.parseInt(productId));
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Đang giao hàng</title>
    <link rel="stylesheet" href="css/waitingOrder_styles.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>
<div>
    <jsp:include page="/components/header.jsp" />
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
    <div class="Info">
        <div class="profile-sidebar">
            <div class="profile-header">
                <img src="img/avt.jpg" alt="">
                <div class="profile-info">
                    <p class="username">${sessionScope.userName}</p>
                    <a href="personal.jsp" class="edit-profile">Sửa Hồ Sơ</a>
                </div>
            </div>
            <div class="menu-item-1">
                <i class="fa fa-user" aria-hidden="true"></i>
                <a href="personal.jsp">Tài Khoản Của Tôi</a>

            </div>
            <div class="menu-item-2">
                <i class="fa fa-shopping-basket" aria-hidden="true"></i>
                <a href="oderInformation.jsp">Đơn Mua Hàng</a>

            </div>


        </div>

        <div class="page">
            <div class="timeline">
                <div class="step active">
                    <div class="step-icon">
                        <i class="fa fa-history" aria-hidden="true"></i>
                    </div>
                    <div class="step-text">Đã Đặt</div>
                    <div class="step-date">${selectedOrder.dateOrder}</div>
                </div>

                <div class="step active">
                    <div class="step-icon">
                        <i class="fa fa-credit-card-alt" aria-hidden="true"></i>
                    </div>
                    <div class="step-text">Đã Xác Nhận</div>
                    <div class="step-date"></div>
                </div>

                <div class="step active">
                    <div class="step-icon">
                        <i class="fa fa-truck" aria-hidden="true"></i>
                    </div>
                    <div class="step-text">Chờ Lấy Hàng</div>
                    <div class="step-date"></div>
                </div>

                <div class="step">
                    <div class="step-icon">
                        <i class="fa fa-cube" aria-hidden="true"></i>
                    </div>
                    <div class="step-text">Đang Giao</div>
                    <div class="step-date"></div>
                </div>

                <div class="step">
                    <div class="step-icon">
                        <i class="fa fa-star" aria-hidden="true"></i>
                    </div>
                    <div class="step-text">Đánh Giá</div>
                    <div class="step-date"></div>
                </div>
            </div>
            <!-- Thêm vào sau div class="timeline" -->
            <div class="info-deli">
                <div class="delivery-info">

                    <div class="delivery-estimate">
                        <h3>Dự kiến giao hàng</h3>
                        <p><%=o.getDateOrder()%></p>
                    </div>

                    <div class="order-details">
                        <div class="order-header">
                            <div class="order-id">Mã đơn hàng: <%=o.getId()%></div>
                            <div class="order-date">Ngày đặt: <%=o.getDateOrder()%></div>
                        </div>

                        <div class="shipping-info">
                            <div class="info-section">
                                <h3>Thông tin món hàng</h3>
                                <div class="info-content">
                                    <p><%=o.getNameProduct()%></p>
                                    <p>Số lượng: <%=o.getQuantity()%></p>
                                    <p>Mã đơn hàng: <%=o.getId()%></p>
                                    <p class="price">Giá: <%=o.getPrice()%>đ</p>
                                </div>
                            </div>
                            <div class="info-section-2">
                                <h3>Thông tin người nhận</h3>
                                <div class="info-content">
                                    <p>${sessionScope.userName}</p>
                                    <p>${sessionScope.userPhone}</p>
                                    <p>${sessionScope.userAddress}</p>
                                </div>
                            </div>
                        </div>
                    </div>
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
    <jsp:include page="components/footer.jsp" />
</div>
</body>

</html>
