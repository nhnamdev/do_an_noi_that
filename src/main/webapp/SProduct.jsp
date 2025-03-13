<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.SProduct" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.SProductDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đồ án web</title>
    <link rel="stylesheet" href="css/SProduct_style.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>
<div class="singleProduct">
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
    <div class="navigation_titlePage">
        <div class="container">
            <ul class="path">
                <li class="User"><a href="#">Trang chủ</a></li>
                <li><i class="fa fa-chevron-right"></i></li>
                <li class="Favorite"><a href="#">Cửa hàng</a></li>
                <li><i class="fa fa-chevron-right"></i></li>
                <div class="line_right"></div>
            </ul>
            <div class="title"><%=sp.getName()%>
            </div>
        </div>
    </div>
    <div class="content_section">
        <div class="container">
            <div class="alpha">
                <div class="card">
                    <div class="image">
                        <div class="cube-container">
                            <div class="cube initial-position">
                                <img class="cube-face-image image-1" src="<%=sp.getIndexImages(0)%>"
                                     style="width: 100%; max-width: 300px; height: 300px; object-fit: cover;">
                                <img class="cube-face-image image-2" src="<%=sp.getIndexImages(1)%>"
                                     style="width: 100%; max-width: 300px; height: 300px; object-fit: cover;">
                                <img class="cube-face-image image-3" src="<%=sp.getIndexImages(2)%>"
                                     style="width: 100%; max-width: 300px; height: 300px; object-fit: cover;">
                                <img class="cube-face-image image-4" src="<%=sp.getIndexImages(0)%>"
                                     style="width: 100%; max-width: 300px; height: 300px; object-fit: cover;">
                                <img class="cube-face-image image-5" src="<%=sp.getIndexImages(2)%>"
                                     style="width: 100%; max-width: 300px; height: 300px; object-fit: cover;">
                                <img class="cube-face-image image-6" src="<%=sp.getIndexImages(1)%>"
                                     style="width: 100%; max-width: 300px; height: 300px; object-fit: cover;">
                            </div>
                        </div>
                        <div class="image-buttons">
                            <input type="image" class="show-image-1" src="<%=sp.getIndexImages(0)%>">
                            <input type="image" class="show-image-2" src="<%=sp.getIndexImages(1)%>">
                            <input type="image" class="show-image-3" src="<%=sp.getIndexImages(2)%>">
                            <input type="image" class="show-image-4" src="<%=sp.getIndexImages(0)%>">
                            <input type="image" class="show-image-5" src="<%=sp.getIndexImages(2)%>">
                            <input type="image" class="show-image-6" src="<%=sp.getIndexImages(1)%>">
                        </div>
                        <script src="js/showList.js"></script>
                    </div>
                    <div class="profile">
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
            <div class="omega">
                <div class="relatedProduct">
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
    <jsp:include page="components/footer.jsp" />
</div>
</body>

</html>
