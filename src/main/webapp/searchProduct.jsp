<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ProductShop" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.SearchDao" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%
    String searchQuery = request.getParameter("search");
    List<ProductShop> products = null;

    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        SearchDao productDAO = new SearchDao();
        products = productDAO.searchProducts(searchQuery);
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đồ án web</title>
    <link rel="stylesheet" href="css/shop_styles.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

</head>

<body>
<div class="home">
    <jsp:include page="/components/header.jsp" />
    <script src="js/showSearch.js"></script>
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
                <button class="check_out" onclick="window.location.href='cartCheckout.jsp'">Thanh toán</button>
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
                <h1 class="title">Cửa hàng</h1>
                <div class="path">
                    <div class="home">Trang chủ</div>
                    <div class="icon">
                        <ul class="icons">
                            <li><i class="fa fa-chevron-right"></i></li>
                        </ul>
                    </div>
                    <div class="contact">Cửa hàng</div>
                </div>
            </div>
        </div>
    </div>
    <div class="content_section_1">
        <div class="sub_navbar">
            <div class="container">
                <div class="sub_nav_left">
                    <span class="filter_text"></span>
                </div>
            </div>
        </div>

        <div class="product-list">

            <div class="container-fluid">
                <div class="row">
                    <%
                        if (products != null && !products.isEmpty()) {
                            for (ProductShop product : products) {
                    %>
                    <div class="col-sm-3 p-3 col-md-3">
                        <div class="product-block">
                            <div class="product-tumb">
                                <a href="productDetail.jsp?id=<%= product.getId() %>">
                                    <img src="<%= product.getImg() %>" alt="">
                                </a>
                            </div>
                            <div class="product-detail">
                                <h4>
                                    <a href="productDetail.jsp?id=<%= product.getId() %>"><%= product.getName() %></a>
                                </h4>
                                <div class="product-bottom_detail">
                                    <div class="price">
                                        <span class="discount-price"><%= product.getPrice() %></span>
                                    </div>
                                    <div class="product-actions">
                                        <span class="heart-icon red">&#9829;</span>
                                    </div>
                                    <div class="sold-quantity">
                                        Đã bán: <%= product.getQuantitySold() %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <p>Không tìm thấy sản phẩm nào.</p>
                    <%
                        }
                    %>
                    </div>
                </div>
            </div>

            <div class="pagination-container">
                <ul class="pagination">
                    <li class="page-item disabled">
                        <a href="#" class="page-link">Trang trước</a>
                    </li>
                    <li class="page-item active">
                        <a href="#" class="page-link">1</a>
                    </li>
                    <li class="page-item">
                        <a href="#" class="page-link">2</a>
                    </li>
                    <li class="page-item">
                        <a href="#" class="page-link">3</a>
                    </li>
                    <li class="page-item">
                        <a href="#" class="page-link">Trang sau</a>
                    </li>
                </ul>
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
                            vận chuyển</div>
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
<script src="js/shop_script.js"></script>
<script src="js/pagination_script.js"></script>
</body>

</html>

