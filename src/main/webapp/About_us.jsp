
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
  <script src="js/actionOfProfile.js"></script>
  <div class="overlay" id="overlay"></div>
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
  <div class="slider2" style="height: 100%; width: 1200px; margin: 0 auto">

      <div class="column column-33">
        <h3 class="heading"style="margin: 0" >Chào mừng</h3>
        <p class="text">
          Chào mừng bạn đến với website của chúng tôi – nơi tự hào cung cấp những sản phẩm nội thất tuyệt đẹp và chất lượng hàng đầu.
          Chúng tôi tận hưởng việc thể hiện sự sáng tạo và đam mê trong việc tạo ra không gian sống đẹp, tiện nghi và thoải mái cho khách hàng.
        </p>
        <p class="text">
          Chúng tôi cam kết cung cấp cho bạn những sản phẩm chất lượng cao từ những nguyên liệu tốt nhất và công nghệ sản xuất tiên tiến nhất.
          Từ các bộ sofa êm ái, bàn ăn hiện đại, đèn trang trí sáng tạo đến giường ngủ thoải mái và tủ quần áo thông minh,
          chúng tôi không ngừng nỗ lực để đáp ứng mọi nhu cầu của bạn.
        </p>
      </div>
      <div class="column column-66">
        <div class="banner" style="background-image: url('https://noithat-nhadep.monamedia.net/wp-content/uploads/2024/04/slider-home-furniture.jpg');margin-top: 70px;">
        </div>
      </div>
  </div>
  <section class="testimonials">
    <div class="container">
      <h2 class="section-title"><span>KHÁCH HÀNG NÓI GÌ VỀ CHÚNG TÔI</span></h2>

      <div class="testimonials-content">
        <article class="testimonial">
          <p class="testimonial-text">
            Là Startup mới đi vào hoạt động, không có nhiều chi phí để setup văn phòng. Nhờ TOZ, Vinafly đã hoàn thiện được khu văn phòng với giá thành siêu hợp lý. Cảm ơn các bạn.
          </p>
          <div class="testimonial-info">
            <img class="testimonial-img" src="https://noithattoz.com/wp-content/uploads/2020/03/906590_933333016686391_1136874957417962322_o-1-300x300.jpg" alt="Mr.Thắng">
            <div>
              <h3 class="testimonial-name">Mr.Thắng</h3>
              <p class="testimonial-title">CEO, Vinafly</p>
            </div>
          </div>
        </article>

        <article class="testimonial">
          <blockquote class="testimonial-text">
            TOZ giao hàng rất nhanh. Văn phòng mình cần thi công gấp, vừa gọi điện lúc sáng thì chiều các bạn đã mang hàng đến lắp đặt. Nhân viên nhiệt tình, cẩn thận.
          </blockquote>
          <div class="testimonial-info">

            <img class="testimonial-img" src="https://noithattoz.com/wp-content/uploads/2020/03/906590_933333016686391_1136874957417962322_o-1-300x300.jpg" alt="Mr. Minh">
            <div>
              <h3 class="testimonial-name">Mr. Minh</h3>
              <p class="testimonial-title">HR Manager, Bloomgo</p>
            </div>
          </div>
        </article>
      </div>

      <div class="client-logos">
        <img src="https://noithattoz.com/wp-content/uploads/2020/03/5s.png" alt="Logo 5s">
        <img src="https://noithattoz.com/wp-content/uploads/2020/03/blomgo.png" alt="Logo Bloomgo">
        <img src="https://noithattoz.com/wp-content/uploads/2020/05/logo-dddd.png" alt="Logo DDDD">
        <img src="https://noithattoz.com/wp-content/uploads/2020/03/vpbank.png" alt="Logo VPBank">
        <img src="https://noithattoz.com/wp-content/uploads/2020/03/vin.png" alt="Logo Vin">
        <img src="https://noithattoz.com/wp-content/uploads/2020/03/riki-logo.png" alt="Logo Riki">
      </div>
    </div>
  </section>

  <jsp:include page="components/footer.jsp" />
</div>
</body>

</html>
