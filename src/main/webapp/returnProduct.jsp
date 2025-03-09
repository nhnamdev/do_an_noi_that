<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: homin
  Date: 12/21/2024
  Time: 12:52 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Đồ án web</title>
    <link rel="stylesheet" href="css/returnProduct_style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>
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
        <div class="alpha">
            <img src="img/background.jpg" alt="">
        </div>
        <div class="omega">
            <h1 class="title">Đổi / Trả</h1>
            <div class="path">
                <div class="home">Trang chủ</div>
                <div class="icon">
                    <ul class="icons">
                        <li><i class="fa fa-chevron-right"></i></li>
                    </ul>
                </div>
                <div class="contact">Đổi trả sản phẩm</div>
            </div>
        </div>
    </div>
</div>
<div class="content_section_1">
    <div class="container">
        <div class="title">
            <div class="labelTitle">Hỗ trợ đổi trả sản phẩm</div>
            <div class="more_information">Chúng tôi chân thành xin lỗi vì sự bất tiện mà bạn gặp phải. Chúng tôi rất
                trân trọng sự tin tưởng của bạn<br> và sẵn sàng hỗ trợ bạn trong quá trình đổi/trả hàng hóa để mang
                lại
                sự
                hài lòng tối đa.
            </div>
        </div>
        <div class="content">
            <form id="contact_form" method="post" action="returnProduct" pix-confirm="hidden_pix_6">
                <input type="hidden" id="status" name="status" value="Đổi">
                <div class="button-container">
                    <button class="button btn-doi" id="btn-doi" onclick="setStatus('Đổi')">Đổi</button>
                    <button class="button btn-tra" id="btn-tra" onclick="setStatus('Trả')">Trả</button>
                </div>
                <script>
                    function setStatus(value) {
                        const statusInput = document.getElementById('status');
                        statusInput.value = value;
                        changeColor(value === 'Đổi' ? 'btn-doi' : 'btn-tra');
                    }
                    function changeColor(activeBtnId) {
                        const btnDoi = document.getElementById('btn-doi');
                        const btnTra = document.getElementById('btn-tra');
                        btnDoi.classList.remove('active');
                        btnTra.classList.remove('active');
                        document.getElementById(activeBtnId).classList.add('active');
                    }
                </script>
                <div class="addPicture">
                    <label for="file-input" class="upload-button">
                        <i class="fa fa-camera"></i>Thêm ảnh
                    </label>
                    <input type="file" name="file-input" id="file-input" accept="image/*" onchange="handleFile(event)" required>
                    <script src="js/addPicture.js"></script>
                </div>
                <div class="filename-display" id="filenameDisplay"></div>
                <div class="inputID">
                    <input type="text" name="id" id="id" placeholder="Mã đơn hàng" required>
                </div>
                <div class="inputDate">
                    <div class="date-picker">
                        <input type="text" name="date-input" id="date-input" placeholder="Chọn ngày đặt mua" required>
                    </div>

                    <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.9/flatpickr.min.js"></script>
                    <script>
                        flatpickr("#date-input", {
                            dateFormat: "Y-m-d",
                            allowInput: true,
                            onChange: function (selectedDates, dateStr, instance) {
                                console.log("Ngày đã chọn: ", dateStr);
                            }
                        });
                        document.getElementById('calendar-icon').onclick = function () {
                            document.getElementById('date-input')._flatpickr.open();
                        };
                    </script>
                </div>
                <div class="select_st">
                    <select id="countries" name="countries" class="pix_text">
                        <option value="">Vui lòng chọn lí do</option>
                        <option value="Sản phẩm không giống mô tả">Sản phẩm không giống mô tả</option>
                        <option value="Sản phẩm bị lỗi kỹ thuật">Sản phẩm bị lỗi kỹ thuật</option>
                        <option value="Sản phẩm không chắc chắn,ổn định">Sản phẩm không chắc chắn,ổn định</option>
                        <option value="Sản phẩm có mùi lạ">Sản phẩm có mùi lạ</option>
                        <option value="Sản phẩm không có phụ kiện đi kèm">Sản phẩm không có phụ kiện đi kèm</option>
                        <option value="Sản phẩm bị lỗi kỹ thuật">Sản phẩm bị lỗi kỹ thuật</option>
                        <option value="Khiếu nại về độ bền">Khiếu nại về độ bền</option>
                        <option value="Vấn đề về bảo hành">Vấn đề về bảo hành</option>
                        <option value="Khác">Khác</option>
                    </select>
                </div>
                <div class="message-container">
                        <textarea name="message" id="message" placeholder="Mô tả về lỗi của sản phẩm..."
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
                        chuyển</div>
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
</body>

</html>
