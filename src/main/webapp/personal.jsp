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
    <title>Đồ án web</title>
    <link href="https://fonts.googleapis.com/css?family=Fira+Sans+Condensed:300,400,600i&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/personal_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>
<div class="personal">

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
                <h1 class="title">Thông tin</h1>
                <div class="path">
                    <div class="home">Trang chủ</div>
                    <div class="icon">
                        <ul class="icons">
                            <li><i class="fa fa-chevron-right"></i></li>
                        </ul>
                    </div>
                    <div class="contact">Thông tin</div>
                </div>
            </div>
        </div>
    </div>
    <div class="content_section">
        <div class="container">
            <div class="title">
                <div>Tài khoản của bạn</div>
            </div>
            <div class="line"></div>
            <div class="container rounded bg-white mt-5 mb-5">
                <div class="row">
                    <div class="col-md-3 border-right">
                        <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                            <div class="imageContainer">
                                <img id="image" src="img/avt.jpg" alt="">
                                <div class="overlayCamera">
                                    <i class="fa fa-camera" id="uploadIcon"></i>
                                </div>
                            </div>
                            <input type="file" id="fileInputIcon" accept="image/*" style="display: none;">
                            <script>
                                const uploadBtnAvt = document.getElementById('uploadIcon');
                                const fileInputAvt = document.getElementById('fileInputIcon');
                                const imageAvt = document.getElementById('image');
                                uploadBtnAvt.addEventListener('click', () => {
                                    fileInputAvt.click();
                                });
                                fileInputAvt.addEventListener('change', (event) => {
                                    const file = event.target.files[0];
                                    if (file) {
                                        const reader = new FileReader();
                                        reader.onload = function (e) {
                                            imageAvt.src = e.target.result;
                                        }
                                        reader.readAsDataURL(file);
                                    }
                                });
                            </script>
                            <h3 class="font-weight-bold">${sessionScope.userName}</h3>
                            <div class="service">
                                <ul>
                                    <li>
                                        <i class="fa-solid fa-shopping-cart"></i>
                                        <h4>Sản phẩm trong giỏ: <%
                                            int cartSize = (cartProducts != null) ? cartProducts.size() : 0; // Kiểm tra null và lấy kích thước
                                        %>
                                            <%= cartSize %></h4>
                                    </li>

                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5 border-right">
                        <div class="p-3 py-5">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h2 class="text-right">Cài đặt thông tin</h2>
                            </div>
                            <form action="index" method="post">
                                <div class="col-md-6 editable">
                                    <h5 class="labels">Tên khách hàng:</h5>
                                    <p id="userName">${sessionScope.userName}</p>
                                    <input type="text" name="userNameInput" id="userNameInput" style="display:none;"/>
                                </div>
                                <div class="col-md-6 editable">
                                    <h5 class="labels">Ngày sinh:</h5>
                                    <p id="userBirthday">${sessionScope.userBirthday}</p>
                                    <input type="text" name="userBirthdayInput" id="userBirthdayInput" style="display:none;"/>
                                </div>
                                <div class="col-md-12 editable">
                                    <h5 class="labels">Số điện thoại:</h5>
                                    <p id="userPhone">${sessionScope.userPhone}</p>
                                    <input type="text" name="userPhoneInput" id="userPhoneInput" style="display:none;"/>
                                </div>
                                <div class="col-md-12 editable">
                                    <h5 class="labels">Địa chỉ:</h5>
                                    <p id="userAddress">${sessionScope.userAddress}</p>
                                    <input type="text" name="userAddressInput" id="userAddressInput" style="display:none;"/>
                                </div>
                                <div class="col-md-12 editable">
                                    <h5 class="labels">Email:</h5>
                                    <p id="userEmail">
                                        <a href="mailto:${sessionScope.userEmail}">
                                            ${sessionScope.userEmail}
                                        </a>
                                    </p>
                                    <input type="email" name="userEmailInput" id="userEmailInput" style="display:none;"/>
                                </div>
                                <button class="saveBtn" type="submit" style="display:none;">Lưu thông tin</button>
                                <button class="editBtn" type="button">Chỉnh sửa</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        document.querySelector('.editBtn').addEventListener('click', function () {
            document.querySelectorAll('.editable').forEach((editable) => {
                const p = editable.querySelector('p');
                const input = editable.querySelector('input');
                if (p && input) {
                    input.value = p.innerText;
                    p.style.display = 'none';
                    input.style.display = 'block';
                }
            });

            document.querySelector('.saveBtn').style.display = 'block';
            this.style.display = 'none';
        });

        document.querySelector('.saveBtn').addEventListener('click', function () {
            document.querySelectorAll('.editable').forEach((editable) => {
                const p = editable.querySelector('p');
                const input = editable.querySelector('input');
                if (p && input) {
                    p.innerText = input.value;
                    input.style.display = 'none';
                    p.style.display = 'block';
                }
            });
            this.style.display = 'none';
            document.querySelector('.editBtn').style.display = 'block';
        });
    </script>


    <div class="content_section_2">
        <div class="container">
            <div class="item">
                <div class="card">
                    <i class="fa fa-truck"></i>
                </div>
                <div class="content">
                    <div class="free_delivery">
                        <h2 class="title">Miễn Phí Giao Hàng</h2>
                        <div class="content_div">Đối với các đơn hàng có giá trị trên 2.000K sẽ được miễn phí phí vận
                            chuyển
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
            <div class="user">
                <h2 class="title">Thông tin</h2>
                <div class="content">Cửa hàng nội thất HTĐ của chúng tôi mang đến nhiều sản phẩm chất lượng,
                    từ sofa, bàn ghế đến decor độc đáo. Chúng tôi cam kết giúp bạn tạo không gian sống tiện
                    nghi và phong cách. Hãy cùng làm mới ngôi nhà của bạn!
                </div>
            </div>
            <div class="link">
                <h2 class="title">Liên kết</h2>
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
                <h2 class="title">Hỗ trợ</h2>
                <div class="link_href">
                    <ul class="content">
                        <li class="active propClone"><a href="checkout.jsp">Thanh Toán</a></li>
                        <li class="propClone"><a href="returnProduct.jsp">Đổi/Trả</a></li>
                        <li class="propClone"><a href="privacy_policy.jsp">Chính sách bảo mật</a>
                        </li>
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
