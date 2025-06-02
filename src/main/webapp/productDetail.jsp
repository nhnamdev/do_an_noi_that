<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm | ${product.name}</title>
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
                        <button class="check_out" onclick="window.location.href='cartCheckout.jsp'">Thanh toán</button>
                    </div>
                </div>
            </div>
            <script src="js/showCart.js"></script>
            <div class="content_section">
                <div class="breadcrumb-wrapper">
                    <div class="breadcrumb">
                        <div class="container">
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/index">Trang chủ</a></li>
                                <li><i class="fas fa-angle-right"></i></li>
                                <li><a href="${pageContext.request.contextPath}/shop">Tất cả sản phẩm</a></li>
                                <li><i class="fas fa-angle-right"></i></li>
                                <li>${product.name}</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="product-detail">
                    <div class="product-detail-container">
                        <div class="product-image-left">
                            <div class="main-image">
                                <c:choose>
                                    <c:when test="${not empty mainImage}">
                                        <c:set var="imagePath"
                                               value='${pageContext.request.contextPath}/img/sanpham/${mainImage}'/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="imagePath"
                                               value='${pageContext.request.contextPath}/img/sanpham/${product.image}'/>
                                    </c:otherwise>
                                </c:choose>

                                <img src="${imagePath}" alt="${product.name}" id="mainImage">
                                <button class="prev-btn"><i class="fas fa-chevron-left"></i></button>
                                <button class="next-btn"><i class="fas fa-chevron-right"></i></button>
                            </div>

                            <div class="sub-image-container">
                                <div class="sub-image active">
                                    <c:choose>
                                        <c:when test="${not empty mainImage}">
                                            <c:set var="imagePath"
                                                   value="${pageContext.request.contextPath}/img/sanpham/${mainImage}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="imagePath"
                                                   value="${pageContext.request.contextPath}/img/sanpham/${product.image}"/>
                                        </c:otherwise>
                                    </c:choose>

                                    <img src="${imagePath}" alt="${product.name}">
                                </div>
                                <c:forEach var="image" items="${subImages}" varStatus="status">
                                    <div class="sub-image">
                                        <img src="${pageContext.request.contextPath}/img/sanpham/${image}"
                                             alt="Ảnh phụ ${status.index + 1}">
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="product-info-right">
                            <h2>${product.name}</h2>
                            <div class="rating-container">
                                <div class="sold">${product.quantitySold} Đã Bán</div>
                            </div>
                            <div class="product-price">
                                <span class="current-price">
                                    <f:formatNumber type="currency" value="${product.price}"
                                                    pattern="#,###đ"/>
                                </span>
                                <span class="old-price"></span>
                                <span class="discount-tag"></span>
                            </div>
                            <div class="shipping-info">
                                <div class="shipping-label">Vận Chuyển</div>
                                <div class="shipping-content">
                                    <div class="shipping-icon">
                                        <i class="fa-solid fa-truck"></i>
                                    </div>
                                    <div class="shipping-text">
                                        <div class="shipping-note">
                                            Miễn phí vận chuyển cho đơn hàng trên 2.000.000đ
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="product-describe">
                                <div class="product-description">
                                    <p>${detail.productDescribe}</p>
                                </div>
                            </div>
                            <div class="quantity-section">
                                <div class="quantity-label">Tình trạng: <span>${detail.stockStatus}</span></div>
                                <div class="quantity-controls">
                                    <button class="quantity-btn decrease" onclick="decreaseQuantity()">-</button>
                                    <span id="quantity">1</span>
                                    <button class="quantity-btn increase" onclick="increaseQuantity()">+</button>
                                </div>
                                <%--script cho so luong san pham --%>
                                <script>
                                    let quantity = 1;

                                    function increaseQuantity() {
                                        quantity++;
                                        document.getElementById('quantity').innerText = quantity;
                                        document.getElementById('quantityInput').value = quantity;
                                        document.getElementById('quantityInputBuyNow').value = quantity;
                                    }

                                    function decreaseQuantity() {
                                        if (quantity > 1) {
                                            quantity--;
                                            document.getElementById('quantity').innerText = quantity;
                                            document.getElementById('quantityInput').value = quantity;
                                            document.getElementById('quantityInputBuyNow').value = quantity;
                                        }
                                    }
                                </script>
                            </div>
                            <div class="action-buttons">
                                <form action="${pageContext.request.contextPath}/cart/addToCart" method="post"
                                      class="button-form">
                                    <input type="hidden" name="id" value="${product.id}">
                                    <input type="hidden" name="quantity" id="quantityInput" value="1">
                                    <button type="submit" class="add-to-cart-btn">
                                        <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/checkout/" method="post"
                                      class="button-form">
                                    <input type="hidden" name="id" value="${product.id}">
                                    <input type="hidden" name="quantity" id="quantityInputBuyNow" value="1">
                                    <input type="hidden" name="buyNow" value="true">
                                    <button type="submit" class="buy-btn">
                                        <i class="fas fa-shopping-bag"></i> Mua ngay
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="product-info-detail">
                    <div class="tab-navigation">
                        <button class="tab-btn active" data-tab="tab-detail">Thông tin chi tiết</button>
                        <button class="tab-btn" data-tab="tab-policy">Chính sách bán hàng</button>
                        <button class="tab-btn" data-tab="tab-instructor">Hướng dẫn mua hàng</button>
                    </div>
                    <div class="tab-content">
                        <div id="tab-detail" class="tab-pane active">
                            <h3 class="detail-title">
                                Mô tả chi tiết
                            </h3>
                            <table class="detail-info-table">
                                <tr class="info-row">
                                    <th class="material-label">Chất liệu:</th>
                                    <td class="material-value">${detail.material}</td>
                                </tr>
                                <tr class="info-row">
                                    <th class="material-label">Thương hiệu:</th>
                                    <td class="material-value">${detail.brand}</td>
                                </tr>
                                <tr class="info-row">
                                    <th class="material-label">Màu sắc:</th>
                                    <td class="material-value">${detail.color}</td>
                                </tr>
                                <tr class="info-row">
                                    <th class="material-label">Kích thước:</th>
                                    <td class="material-value">${detail.length} x ${detail.width}
                                        x ${detail.height} </td>
                                </tr>
                                <tr class="info-row">
                                    <th class="material-label">Tính năng:</th>
                                    <td class="material-value">${detail.feature}
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="tab-policy" class="tab-pane">
                            <div class="policy-container">
                                <p>Cảm ơn quý khách đã quan tâm và truy cập vào website. Chúng tôi tôn trọng và cam kết
                                    sẽ bảo mật những thông tin mang tính riêng tư của Quý khách.</p>

                                <p>Chính sách bảo mật sẽ giải thích cách chúng tôi tiếp nhận, sử dụng và (trong trường
                                    hợp nào đó) tiết lộ thông tin cá nhân của Quý khách.</p>

                                <p>Bảo vệ dữ liệu cá nhân và gây dựng được niềm tin cho quý khách là vấn đề rất quan
                                    trọng với chúng tôi. Vì vậy, chúng tôi sẽ dùng tên và các thông tin khác liên quan
                                    đến quý khách tuân thủ theo nội dung của Chính sách bảo mật. Chúng tôi chỉ thu thập
                                    những thông tin cần thiết liên quan đến giao dịch mua bán.</p>

                                <p>Chúng tôi sẽ giữ thông tin của khách hàng trong thời gian luật pháp quy định hoặc cho
                                    mục đích nào đó. Quý khách có thể truy cập vào website và trình duyệt mà không cần
                                    phải cung cấp chi tiết cá nhân. Lúc đó, Quý khách đang ẩn danh và chúng tôi không
                                    thể biết bạn là ai nếu Quý khách không đăng nhập vào tài khoản của mình.</p>

                                <h3>1. Thu thập thông tin cá nhân</h3>

                                <p>- Chúng tôi thu thập, lưu trữ và xử lý thông tin của bạn cho quá trình mua hàng và
                                    cho những thông báo sau này liên quan đến đơn hàng, và để cung cấp dịch vụ, bao gồm
                                    một số thông tin cá nhân: danh hiệu, tên, giới tính, ngày sinh, email, địa chỉ, địa
                                    chỉ giao hàng, số điện thoại, fax, chi tiết thanh toán, chi tiết thanh toán bằng thẻ
                                    hoặc chi tiết tài khoản ngân hàng.</p>

                                <p>- Chúng tôi sẽ dùng thông tin quý khách đã cung cấp để xử lý đơn đặt hàng, cung cấp
                                    các dịch vụ và thông tin yêu cầu thông qua website và theo yêu cầu của bạn.</p>

                                <p>- Hơn nữa, chúng tôi sẽ sử dụng các thông tin đó để quản lý tài khoản của bạn; xác
                                    minh và thực hiện giao dịch trực tuyến, nhận diện khách vào web, nghiên cứu nhân
                                    khẩu học, gửi thông tin bao gồm thông tin sản phẩm và dịch vụ. Nếu quý khách không
                                    muốn nhận bất cứ thông tin tiếp thị của chúng tôi thì có thể từ chối bất cứ lúc
                                    nào.</p>

                                <p>- Chúng tôi có thể chuyển tên và địa chỉ cho bên thứ ba để họ giao hàng cho bạn (ví
                                    dụ cho bên chuyển phát nhanh hoặc nhà cung cấp).</p>

                                <p>- Chi tiết đơn đặt hàng của bạn được chúng tôi lưu giữ nhưng vì lí do bảo mật nên
                                    chúng tôi không công khai trực tiếp được. Tuy nhiên, quý khách có thể tiếp cận thông
                                    tin bằng cách đăng nhập tài khoản trên web. Tại đây, quý khách sẽ thấy chi tiết đơn
                                    đặt hàng của mình, những sản phẩm đã nhận và những sản phẩm đã gửi và chi tiết
                                    email, ngân hàng và bản tin mà bạn đặt theo dõi dài hạn.</p>

                                <h3>2. Bảo mật</h3>

                                <p>- Chúng tôi có biện pháp thích hợp về kỹ thuật và an ninh để ngăn chặn truy cập trái
                                    phép hoặc trái pháp luật hoặc mất mát hoặc tiêu hủy hoặc thiệt hại cho thông tin của
                                    bạn.</p>

                                <p>- Chúng tôi khuyên quý khách không nên đưa thông tin chi tiết về việc thanh toán với
                                    bất kỳ ai bằng e-mail, chúng tôi không chịu trách nhiệm về những mất mát quý khách
                                    có thể gánh chịu trong việc trao đổi thông tin của quý khách qua internet hoặc
                                    email.</p>

                                <p>- Quý khách tuyệt đối không sử dụng bất kỳ chương trình, công cụ hay hình thức nào
                                    khác để can thiệp vào hệ thống hay làm thay đổi cấu trúc dữ liệu. Nghiêm cấm việc
                                    phát tán, truyền bá hay cổ vũ cho bất kỳ hoạt động nào nhằm can thiệp, phá hoại hay
                                    xâm nhập vào dữ liệu của hệ thống website. Mọi vi phạm sẽ bị tước bỏ mọi quyền lợi
                                    cũng như sẽ bị truy tố trước pháp luật nếu cần thiết.</p>

                                <p>- Mọi thông tin giao dịch sẽ được bảo mật nhưng trong trường hợp có quan phán pháp
                                    luật yêu cầu, chúng tôi sẽ buộc phải cung cấp những thông tin này cho các cơ quan
                                    pháp luật.</p>

                                <h3>3. Quyền lợi khách hàng</h3>

                                <p>- Quý khách có quyền yêu cầu truy cập vào dữ liệu cá nhân của mình, có quyền yêu cầu
                                    chúng tôi sửa lại những sai sót trong dữ liệu của bạn mà không mất phí. Bất cứ lúc
                                    nào bạn cũng có quyền yêu cầu chúng tôi ngưng sử dụng dữ liệu cá nhân của bạn cho
                                    mục đích tiếp thị.</p>
                            </div>
                        </div>
                        <div id="tab-instructor" class="tab-pane">
                            <div class="instructor-container">
                                <p><strong>Bước 1:</strong>
                                    Truy cập website và lựa chọn sản phẩm cần mua để mua hàng
                                </p>
                                <p><strong>Bước 2:</strong>
                                    Click và sản phẩm muốn mua, màn hình hiển thị ra pop up với
                                    các lựa chọn sau
                                </p>
                                <p>Nếu bạn muốn tiếp tục mua hàng: Bấm vào phần tiếp tục mua hàng để lựa chọn thêm sản
                                    phẩm vào giỏ hàng</p>
                                <p>Nếu bạn muốn xem giỏ hàng để cập nhật sản phẩm: Bấm vào xem giỏ hàng</p>
                                Nếu bạn muốn đặt hàng và thanh toán cho sản phẩm này vui lòng bấm vào: Đặt hàng và
                                thanh toán
                                <p><strong>Bước 3:</strong>
                                    Lựa chọn thông tin tài khoản thanh toán
                                </p>

                                <p>Nếu bạn đã có tài khoản vui lòng nhập thông tin tên đăng nhập là email và mật khẩu
                                    vào mục đã có tài khoản trên hệ thống</p>
                                <p>Nếu bạn chưa có tài khoản và muốn đăng ký tài khoản vui lòng điền các thông tin cá
                                    nhân để tiếp tục đăng ký tài khoản. Khi có tài khoản bạn sẽ dễ dàng theo dõi được
                                    đơn hàng của mình</p>
                                <p>Nếu bạn muốn mua hàng mà không cần tài khoản vui lòng nhấp chuột vào mục đặt hàng
                                    không cần tài khoản</p>

                                <p><strong>Bước 4:</strong>
                                    Điền các thông tin của bạn để nhận đơn hàng, lựa chọn hình
                                    thức thanh toán và vận chuyển cho đơn hàng của mình
                                </p>
                                <p><strong>Bước 5:</strong>
                                    Xem lại thông tin đặt hàng, điền chú thích và gửi đơn hàng
                                </p>

                                <p>Sau khi nhận được đơn hàng bạn gửi chúng tôi sẽ liên hệ bằng cách gọi điện lại để
                                    xác nhận lại đơn hàng và địa chỉ của bạn.</p>
                                <p> Trân trọng cảm ơn.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="related-product">
                    <div class="related-product-container">
                        <div class="related-product-title">Sản phẩm liên quan</div>
                        <div class="section-products">
                            <div class="container">
                                <div class="row" style="margin-left: 0">
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