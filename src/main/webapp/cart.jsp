<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.SProduct" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Integer productId = (Integer) session.getAttribute("productId");
    String productName = (String) session.getAttribute("productName");
    Double productPrice = (Double) session.getAttribute("productPrice");
    String productImg = (String) session.getAttribute("imageProduct");
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    String productPriceStr = (productPrice != null) ? String.format("%.2f", productPrice) : "Không có giá";

    List<Product> cartProducts = (List<Product>) session.getAttribute("cartProducts");
    if (cartProducts == null) {
        cartProducts = new ArrayList<>();
    }

    boolean productExists = false;
    for (Product item : cartProducts) {
        if (item.getId() == productId && item.getName().equals(productName)) {
            item.setQuantity(item.getQuantity() + quantity);
            productExists = true;
            break;
        }
    }

    if (!productExists) {
        Product newProduct = new Product();
        newProduct.setId(productId);
        newProduct.setName(productName);
        newProduct.setPrice(Double.parseDouble(productPriceStr));
        newProduct.setImage(productImg);

        newProduct.setQuantity(1);
        cartProducts.add(newProduct);
    }

    session.setAttribute("cartProducts", cartProducts);
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đồ án web</title>
    <link rel="stylesheet" href="css/cart_styles.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
<div class="cart">
    <jsp:include page="/components/header.jsp" />
    <script src="js/showSearch.js"></script>
    <script src="js/showHeader.js"></script>
    <script src="js/actionOfProfile.js"></script>
    <div class="overlay" id="overlay"></div>
    <div class="info-box" id="infoBox">
        <div class="container">
            <h3>Thông tin giỏ hàng</h3>
            <div class="listProduct">
                <c:choose>
                    <c:when test="${not empty sessionScope.cartProducts}">
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
                    </c:when>
                    <c:otherwise>
                        <div class="empty-cart">Giỏ hàng của bạn đang trống.</div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="totalPrice">
                <div class="title">Tổng tiền</div>
                <div class="price">
                    <%
                        double totalPrice = 0;
                        for (Product item : cartProducts) {
                            totalPrice += item.getPrice() * item.getQuantity();
                        }
                        session.setAttribute("totalPrice", totalPrice);

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
                <h1 class="title">Giỏ Hàng</h1>
                <div class="path">
                    <div class="home">Trang chủ</div>
                    <div class="icon">
                        <ul class="icons">
                            <li><i class="fa fa-chevron-right"></i></li>
                        </ul>
                    </div>
                    <div class="contact">Giỏ Hàng</div>
                </div>
            </div>
        </div>
    </div>
    <div class="content_section_1">
        <form action="cart" method="post">
            <div class="row">
                <div class="billing_details col-8">
                    <table class="table">
                        <thead class="table-success">
                        <tr>
                            <th>Mặt Hàng</th>
                            <th>Đơn Giá</th>
                            <th>Số Lượng</th>
                            <th>Số Tiền</th>
                            <th>Xoá</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${sessionScope.cartProducts}">
                            <tr>
                                <td>${item.name}</td>
                                <td>${item.price}đ</td>
                                <td>
                                        ${item.quantity}
                                </td>
                                <td>${item.price * item.quantity}đ</td>
                                <td>
                                    <button class="delete">Xoá</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="order-summary col-4">
                    <div class="order-title">
                        Thông tin đơn hàng
                    </div>
                    <div class="order-total">
                        Tổng tiền (<span id="total-items">${cartProducts.size()}</span>): <span
                            id="total-price">${sessionScope.totalPrice}đ</span>
                        <button type="submit" class="btn-pay" onclick="window.location.href='checkOut.jsp'">Thanh
                            Toán
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <jsp:include page="components/footer.jsp" />
</div>

<script src="js/cart.js"></script>
</body>

</html>
