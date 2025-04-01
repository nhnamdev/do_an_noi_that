<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.FavouriteDao" %><%--
  Created by IntelliJ IDEA.
  User: homin
  Date: 1/8/2025
  Time: 12:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Product> products = null;

    if (request.getSession().getAttribute("userIdLogin") != null) {
        FavouriteDao productDAO = new FavouriteDao();
        int userId = Integer.valueOf(request.getSession().getAttribute("userIdLogin").toString());
        products = productDAO.getFavoriteProducts(userId);
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đồ án web</title>
    <link rel="stylesheet" href="css/favourite_styles.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>
<div class="home">
    <jsp:include page="/components/header.jsp" />
    <script src="js/showSearch.js"></script>
    <script src="js/actionOfProfile.js"></script>
    <div class="overlay" id="overlay"></div>

    <script src="js/showCart.js"></script>
    <div class="navigation_titlePage">
        <div class="container">
            <div class="alpha">
                <img src="img/background.jpg" alt="">
            </div>
            <div class="omega">
                <h1 class="title">Ưa thích</h1>
                <div class="path">
                    <div class="home">Trang chủ</div>
                    <div class="icon">
                        <ul class="icons">
                            <li><i class="fa fa-chevron-right"></i></li>
                        </ul>
                    </div>
                    <div class="contact">Ưa thích</div>
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
                            for (Product product : products) {
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
                                    <a href="productDetail.jsp?id=<%= product.getId() %>"><%= product.getName() %>
                                    </a>
                                </h4>
                                <div class="product-bottom_detail">
                                    <div class="price">
                                        <span class="discount-price"><%= product.getPrice() %></span>
                                    </div>
                                    <div class="product-actions">
                                        <button class="favourite-btn" data-product-id="${product.id}"
                                                onclick="addToFavorites('<%= product.getId() %>')">
                                            ❌
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
                    <p>Không tìm thấy sản phẩm yêu thích nào.</p>
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
                    <a href="#" class="page-link">Trang sau</a>
                </li>
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
    <jsp:include page="components/footer.jsp" />
</div>
<script>
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
                    alert('Thành Công!');
                    location.reload();  // Reload lại trang nếu thành công
                } else {
                    alert('Error.');
                }
            })
            .catch(error => console.error('Error:', error));
    }
</script>
<script src="js/shop_script.js"></script>
<script src="js/pagination_script.js"></script>
</body>

</html>
