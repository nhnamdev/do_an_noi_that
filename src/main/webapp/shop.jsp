<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ProductShop" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.SearchDao" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.stream.IntStream" %><%--
  Created by IntelliJ IDEA.
  User: homin
  Date: 1/8/2025
  Time: 11:53 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<ProductShop> products = null;
    SearchDao productDAO = new SearchDao();
    products = productDAO.getAllProducts();
    // Phân trang
    int totalProducts = products.size();
    int itemsPerPage = 8; // 8 sản phẩm mỗi trang
    int pageCount = (int) Math.ceil(products.size() / (double) itemsPerPage);
    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    if (currentPage < 1) {
        currentPage = 1;
    } else if (currentPage > pageCount) {
        currentPage = pageCount;
    }
    int startItem = (currentPage - 1) * itemsPerPage;
    int endItem = Math.min(startItem + itemsPerPage, products.size());
    List<ProductShop> paginatedProducts = products.subList(startItem, endItem);
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đồ án web</title>
    <link rel="stylesheet" href="css/shop_styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

</head>

<body>
<div class="home">
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
                    <li class="Shopping"><a href=""><i class="fa fa-shopping-cart"></i></a></li>
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
                    <a href="login.jsp" id="logoutBtn" class="logout-button"><span>Đăng
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
                            for (ProductShop product : paginatedProducts) {
                    %>
                    <div class="col-sm-3 p-3 col-md-3">
                        <div class="product-block">
                            <div class="product-tumb">
                                <a href="SProduct.jsp?id=<%= product.getId() %>">
                                    <img src="<%= product.getImg() %>" alt="">
                                </a>
                            </div>
                            <div class="product-detail">
                                <h4>
                                    <a href="SProduct.jsp?id=<%= product.getId() %>"><%= product.getName() %>
                                    </a>
                                </h4>
                                <div class="product-bottom_detail">
                                    <div class="price">
                                        <span class="discount-price"><%= product.getPrice() %></span>
                                    </div>
                                    <div class="product-actions">
                                        <button class="favourite-btn" data-product-id="${product.id}" onclick="addToFavorites('<%= product.getId() %>')">
                                            ❤️
                                        </button>
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
            <script>
                function toggleFavorite(productId) {
                    // Send AJAX request to server
                    fetch('favorite?action=toggle&productId=' + productId, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        }
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // Toggle heart icon color
                                const heartIcon = document.querySelector(`[data-product-id="${productId}"] .heart-icon`);
                                if (heartIcon) {
                                    heartIcon.classList.toggle('active');
                                }
                                // Show success message
                                alert(data.message);
                            } else {
                                alert('Please login to add favorites');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('An error occurred while updating favorites');
                        });
                }

                function addToFavorites(productId) {
                    console.log(productId);
                    fetch('<%= request.getContextPath() %>/addToFavorites', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: 'productId=' + encodeURIComponent(productId)
                    })
                        .then(response => response.json())
                        .then(data => {
                            console.log(data);
                            if (data.success) {
                                alert('Đã bỏ yêu thích!');
                            } else {
                                alert('Đã thêm sản phẩm yêu thích!.');
                            }
                        })
                        .catch(error => console.error('Error:', error));
                }
            </script>

            <div class="pagination-container">
                <ul class="pagination">
                    <%
                        if (currentPage > 1) {
                    %>
                    <li class="page-item">
                        <a href="?page=1" class="page-link">Đầu</a>
                    </li>
                    <li class="page-item">
                        <a href="?page=<%= currentPage - 1 %>" class="page-link">Trang trước</a>
                    </li>
                    <%
                        }

                        int displayPages = 2;
                        int startPage = Math.max(1, currentPage - displayPages);
                        int endPage = Math.min(pageCount, currentPage + displayPages);
                        if (startPage > 1) {
                    %>
                    <li class="page-item"><span class="page-link">...</span></li>
                    <%
                        }

                        for (int p = startPage; p <= endPage; p++) {
                    %>
                    <li class="page-item <%= p == currentPage ? "active" : "" %>">
                        <a href="?page=<%= p %>" class="page-link"><%= p %></a>
                    </li>
                    <%
                        }

                        // Hiển thị dấu ba chấm nếu cần
                        if (endPage < pageCount) {
                    %>
                    <li class="page-item"><span class="page-link">...</span></li>
                    <%
                        }

                        if (currentPage < pageCount) {
                    %>
                    <li class="page-item">
                        <a href="?page=<%= currentPage + 1 %>" class="page-link">Trang sau</a>
                    </li>
                    <li class="page-item">
                        <a href="?page=<%= pageCount %>" class="page-link">Cuối</a>
                    </li>
                    <%
                        }
                    %>
                </ul>
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
</body>

</html>
