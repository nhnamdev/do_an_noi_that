<%--
  Created by IntelliJ IDEA.
  User: homin
  Date: 1/8/2025
  Time: 12:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Thông tin</title>
  <link rel="stylesheet" href="css/About_us.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

</head>

<body>
<div>
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
  <div class="slider2">
    <ol style="--length: 5" role="list">
      <li style="--i: 1">
        <h3>HẢI ĐỨC THÔNG</h3>
        <p>Thành lập vào tháng 06/2022 như một phần của Đại Học Nông Lâm
          - một công ty với gần 02 năm kinh nghiệm trong lĩnh
          vực sản xuất và xuất khẩu nội thất, HTĐ không ngừng
          phát triển và vươn xa ra thị trường quốc tế như Mỹ, Nhật,
          Hàn Quốc,... Với sứ mệnh mang đến các <i>sản phẩm 100% sản
            xuất tại Việt Nam</i>, HTĐ <strong>cam kết</strong> duy trì tiêu chuẩn quốc
          tế về chất lượng, đảm bảo an toàn sức khỏe với chi phí hợp lý.</p>
      </li>
      <li style="--i: 2">
        <h3>NỘI THẤT</h3>
        <p>Mỗi sản phẩm của HTĐ không chỉ là đồ nội thất,
          mà còn là những <strong>câu chuyện</strong>, cảm xúc được <strong>gửi gắm</strong>
          trong từng chi tiết, với mong muốn truyền tải thông
          điệp <strong>"trao gửi yêu thương trong từng không gian sống.
            "</strong> Bằng cách kết hợp giữa tính tiện ích và sự thân thiện
          với môi trường, HTĐ luôn hướng đến việc tạo ra những sản
          phẩm mang đậm dấu ấn riêng biệt trong từng không gian sống.</p>
      </li>
      <li style="--i: 3">
        <h3>HƯỚNG ĐẾN GIÁ TRỊ BỀN VỮNG</h3>
        <p><i>“Tính bền vững”</i> là một khái niệm định nghĩa sự phát triển về
          mọi mặt nhưng vẫn đảm bảo sự tồn tại phát triển ở trạng thái
          cân bằng. Mang khái niệm <strong>“bền vững”</strong> vào trong sản phẩm - dịch
          vụ nội thất là bước đi tiên phong và đầy thách thức mà HTĐ luôn
          không ngừng nỗ lực nhằm lan toả, truyền cảm hứng về một lối sống
          tích cực, tiêu dùng bền vững hơn <i>vì một tương lai của hành tinh
            xanh.</i></p>
      </li>
      <li style="--i: 4">
        <h3>THÂN THIỆN VỚI MÔI TRƯỜNG</h3>
        <p>HTĐ với xuất phát điểm mong muốn lan tỏa thông điệp
          <strong>"Sống xanh"</strong>, luôn cam kết rằng mỗi sản phẩm nội thất
          mang đến cho khách hàng đều bắt nguồn từ nguồn nguyên
          liệu gỗ <strong>đạt chuẩn FSC</strong> – được khai thác từ các khu rừng
          có quy trình trồng lại. HTĐ nhận thức rõ rằng, là một
          doanh nghiệp nói chung và trong lĩnh vực nội thất nói
          riêng, trách nhiệm với cộng đồng và môi trường xanh là
          điều cần thiết. Giá trị tích cực này không chỉ là của
          riêng HTĐ, mà mỗi khách hàng khi sử dụng sản phẩm của
          HTĐ đều góp phần nhân rộng và duy trì giá trị bền vững
          này cho tương lai.
        </p>
      </li>
      <li style="--i: 5">
        <h3>AN TOÀN SỨC KHỎE</h3>
        <p>
          Nguyên liệu an toàn, thân thiện với môi trường -
          Sơn và chất phủ không chứa VOC -
          Thiết kế thông thoáng, không chứa formaldehyde -
          Công nghệ chống nấm mốc và vi khuẩn.
        </p>
      </li>
    </ol>

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
              vận
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
              mật</a>
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
