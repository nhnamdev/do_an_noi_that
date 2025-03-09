<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đồ án web</title>
  <link rel="stylesheet" href="css/checkout_styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

</head>

<body>
<div class="checkOut">
  <jsp:include page="/components/header.jsp" />
  <script src="js/showSearch.js"></script>
  <script src="js/showHeader.js"></script>
  <script src="js/actionOfProfile.js"></script>
  <div class="overlay" id="overlay"></div>
  <div class="info-box" id="infoBox">
    <div class="container">
      <h3>Thông tin giỏ hàng</h3>
      <div class="listProduct">
        <div class="row1">
          <div class="alpha">
            <img src="img/sofa15.jpg" alt>
          </div>
          <div class="omega">
            <div class="name">Asgaard sofa</div>
            <div class="sumPrice">
              <div class="quantity">1 X</div>
              <div class="price">220.000</div>
            </div>
          </div>
          <div class="beta">
            <button class="close-button">
              <i class="fa fa-times-circle"></i>
            </button>
          </div>
        </div>
        <div class="row2">
          <div class="alpha">
            <img src="img/sofa16.jpg" alt>
          </div>
          <div class="omega">
            <div class="name">Upholstered Sofa</div>
            <div class="sumPrice">
              <div class="quantity">2 X</div>
              <div class="price">450.000</div>
            </div>
          </div>
          <div class="beta">
            <button class="close-button">
              <i class="fa fa-times-circle"></i>
            </button>
          </div>
        </div>
      </div>
      <div class="totalPrice">
        <div class="title">Tổng tiền</div>
        <div class="price">1.120.000đ</div>
      </div>
      <div class="other_choose">
        <button class="view_cart" onclick="window.location.href='../page_Cart/cart.html'">Giỏ hàng</button>
        <button class="check_out" onclick="window.location.href='../page_CheckOut/checkout.html'">Thanh toán
        </button>
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
        <h1 class="title">Thanh toán</h1>
        <div class="path">
          <div class="home">Trang chủ</div>
          <div class="icon">
            <ul class="icons">
              <li><i class="fa fa-chevron-right"></i></li>
            </ul>
          </div>
          <div class="contact">Thanh toán</div>
        </div>
      </div>
    </div>
  </div>
  <div class="content_section_1">
    <div class="row">
      <div class="billing_details col-7">
        <h2>Thông tin giao hàng</h2>
        <div class="input-group">
          <div class="input_name">
            <div class="first_name">
              <label for="first_name">Họ</label>
              <input type="text" id="first_name">
            </div>
            <div class="last_name">
              <label for="last_name">Tên</label>
              <input type="text" id="last_name">
            </div>
          </div>
          <div class="input_street">
            <label for="input_street">Tên đường</label>
            <input type="text" id="input_street">
          </div>
          <div class="input_distric">
            <label for="input_distric">Huyện</label>
            <input type="text" id="input_distric">
          </div>
          <div class="input_rovince">
            <label for="input_rovince">Tỉnh</label>
            <input type="text" id="input_rovince">
          </div>
          <div class="input_phone">
            <label for="input_phone">Số điện thoại</label>
            <input type="text" id="input_phone">
          </div>
          <div class="input_email">
            <label for="input_email">Email</label>
            <input type="email" id="input_email">
          </div>
        </div>
      </div>

      <div class="payment_method col-5">
        <div class="order-table">
          <table>
            <tr>
              <th>Mặt Hàng</th>
              <th>Thành Tiền</th>
            </tr>
            <tr>
              <td>Ghế Sofa x1</td>
              <td>2.500.000</td>
            </tr>
            <tr>
              <td><strong>Tổng Tiền</strong></td>
              <td><strong>2.500.000</strong></td>
            </tr>
          </table>
        </div>
        <h3>Phương thức thanh toán</h3>
        <div class="payment-option">
          <input type="radio" id="payment" name="payment_method">
          <label for="payment">Chuyển khoản ngân hàng</label>
        </div>
        <div class="payment-option">
          <input type="radio" id="cash_on_delivery" name="payment_method">
          <label for="cash_on_delivery">Thanh toán tiền mặt</label>
        </div>
        <div class="place-order">
          <button onclick="window.location.href='../waitingOrder/waitingOrder.html'">Thanh Toán</button>
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
</div>
</body>

</html>
