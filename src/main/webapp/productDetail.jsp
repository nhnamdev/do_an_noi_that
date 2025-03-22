<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.SProduct" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.SProductDao" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>

<%
    String productId = request.getParameter("id");
    SProductDao orderDao = new SProductDao();
    SProduct sp = orderDao.getSProduct(Integer.parseInt(productId));

    session.setAttribute("productId", sp.getId());
    session.setAttribute("productName", sp.getName());
    session.setAttribute("productPrice", sp.getPrice());
    session.setAttribute("imageProduct", sp.getIndexImages(0));

%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>
    <link rel="stylesheet" href="css/productDetail.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
<div class="wrapper">
    <jsp:include page="/components/header.jsp"/>
    <div id="content">
        <div class="container">
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
                            <%--                    <% double totalPrice = 0;--%>
                            <%--                        List<Product> cartProducts = (List<Product>) session.getAttribute("cartProducts");--%>
                            <%--                        if (cartProducts == null) {--%>
                            <%--                            cartProducts = new ArrayList<Product>();--%>
                            <%--                        }--%>
                            <%--                        for (Product item : cartProducts) {--%>
                            <%--                            totalPrice += item.getPrice() * item.getQuantity();--%>
                            <%--                        }%>--%>
                            <%--                    <%= totalPrice %>--%>
                        </div>
                    </div>
                    <div class="other_choose">
                        <button class="view_cart" onclick="window.location.href='cart.jsp'">Giỏ hàng</button>
                        <button class="check_out" onclick="window.location.href='checkout.jsp'">Thanh toán</button>
                    </div>
                </div>
            </div>
            <script src="js/showCart.js"></script>
            <div class="content_section">
                <div class="breadcrumb-wrapper">
                    <div class="breadcrumb">
                        <div class="container">
                            <ul>
                                <li><a href="#">Trang chủ</a></li>
                                <li><i class="fas fa-angle-right"></i></li>
                                <li>Tất cả sản phẩm</li>
                                <li><i class="fas fa-angle-right"></i></li>
                                <li>Ghế sofa</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="product-detail">
                    <div class="product-detail-container">
                        <div class="product-image-left">
                            <div class="main-image">
                                <img src="img/sofa1.jpg" alt="Ảnh chính">
                                <button class="prev-btn"><i class="fas fa-chevron-left"></i></button>
                                <button class="next-btn"><i class="fas fa-chevron-right"></i></button>
                            </div>
                            <div class="sub-image-container">
                                <div class="sub-image active">
                                    <img src="img/sofa2.jpg" alt="Ảnh phụ active">
                                </div>
                                <div class="sub-image">
                                    <img src="img/sofa3.jpg" alt="Ảnh phụ">
                                </div>
                                <div class="sub-image">
                                    <img src="img/sofa4.jpg" alt="Ảnh phụ">
                                </div>
                            </div>
                        </div>
                        <div class="product-info-right">
                            <h1><%=sp.getName()%>
                            </h1>
                            <p class="price"><%=sp.getPrice()%>đ</p>
                            <h3>Mô tả</h3>
                            <p><%=sp.getDescription()%>
                            </p>
                            <h3>Thông số kĩ thuật:</h3>
                            <div class="specification">
                                <ul class="spe">
                                    <div class="kichthuoc">
                                        <li>Chiều dài: 200 cm</li>
                                        <li> Chiều sâu: 90 cm</li>
                                        <li> Chiều cao: 85 cm</li>
                                        <li>Chiều cao chỗ ngồi: 45 cm</li>
                                        <li>Tổng trọng lượng: 50 kg</li>
                                    </div>
                                    <div class="chatlieu">
                                        <li>Khung: Gỗ tự nhiên (gỗ thông hoặc gỗ sồi)</li>
                                        <li> Bọc: Vải nỉ cao cấp hoặc da tổng hợp</li>
                                        <li>Đệm: Bọt polyurethane có độ đàn hồi cao</li>
                                    </div>
                                </ul>
                            </div>
                            <div class="button">
                                <button class="decrease" onclick="decreaseQuantity()">-</button>
                                <span id="quantity">1</span>
                                <button class="increase" onclick="increaseQuantity()">+</button>

                                <script>
                                    let quantity = 1;

                                    function increaseQuantity() {
                                        quantity++;
                                        document.getElementById('quantity').innerText = quantity;
                                    }

                                    function decreaseQuantity() {
                                        if (quantity > 1) {
                                            quantity--;
                                            document.getElementById('quantity').innerText = quantity;
                                        }
                                    }

                                    function setQuantity() {
                                        document.getElementById('quantityInput').value = quantity;
                                    }
                                </script>
                                <form action="cart.jsp" method="post" onsubmit="setQuantity()">
                                    <input type="hidden" name="productId" value="<%= sp.getId() %>">
                                    <input type="hidden" name="productName" value="<%= sp.getName() %>">
                                    <input type="hidden" name="productPrice" value="<%= sp.getPrice() %>">
                                    <input type="hidden" name="productImage" value="<%= sp.getIndexImages(0) %>">
                                    <input type="hidden" id="quantityInput" name="quantity" value="1">
                                    <button type="submit" class="buy">Mua</button>
                                    <button type="submit" class="add">Thêm vào giỏ hàng</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="related-product">
                    <div class="related-product-container">
                        <div class="title">Sản phẩm liên quan</div>
                        <div class="section-products">
                            <div class="container">
                                <div class="row" style="margin-left: 0">
                                    <!-- Single Product -->
                                    <div class="col1">
                                        <div id="product-1" class="single-product">
                                            <div class="part-1">
                                                <img src="img/sofa10.jpg" alt="">
                                                <ul>
                                                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-plus"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-expand"></i></a></li>
                                                </ul>
                                            </div>
                                            <div class="part-2">
                                                <h3 class="product-title">Ghế sofa nhung hiện đại</h3>
                                                <h4 class="product-price">250.000đ</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Single Product -->
                                    <div class="col2">
                                        <div id="product-2" class="single-product">
                                            <div class="part-1">
                                                <span class="discount">-15%</span>
                                                <img src="img/sofa14.jpg" alt="">
                                                <ul>
                                                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-plus"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-expand"></i></a></li>
                                                </ul>
                                            </div>
                                            <div class="part-2">
                                                <h3 class="product-title">Ghế sofa đôi</h3>
                                                <h4 class="product-old-price">500.000đ</h4>
                                                <h4 class="product-price">425.000đ</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Single Product -->
                                    <div class="col3">
                                        <div id="product-3" class="single-product">
                                            <div class="part-1">
                                                <img src="img/sofa12.jpg" alt="">
                                                <ul>
                                                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-plus"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-expand"></i></a></li>
                                                </ul>
                                            </div>
                                            <div class="part-2">
                                                <h3 class="product-title">Ghế sofa bọc nệm 2 chỗ</h3>
                                                <h4 class="product-price">320.000đ</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Single Product -->
                                    <div class="col4">
                                        <div id="product-4" class="single-product">
                                            <div class="part-1">
                                                <span class="new">Mới</span>
                                                <img src="img/sofa13.jpg" alt="">
                                                <ul>
                                                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-plus"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-expand"></i></a></li>
                                                </ul>
                                            </div>
                                            <div class="part-2">
                                                <h3 class="product-title">Ghế sofa bọc nệm Nikali</h3>
                                                <h4 class="product-price">400.000đ</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/components/footer.jsp"/>
</div>
<script src="js/productDetail.js"></script>
</body>
</html>