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
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

</head>

<body>
<div>
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
  <div class="slider2" style="height: 100%">
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
  <jsp:include page="components/footer.jsp" />
</div>
</body>

</html>
