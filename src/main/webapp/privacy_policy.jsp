<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: homin
  Date: 1/8/2025
  Time: 12:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chính sách bảo mật</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
  <link rel="stylesheet" href="css/privacy_policy.css">
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
        <h1 class="title">Chính sách bảo mật</h1>
        <div class="path">
          <div class="home">Trang chủ</div>
          <div class="icon">
            <ul class="icons">
              <li><i class="fa fa-chevron-right"></i></li>
            </ul>
          </div>
          <div class="contact">Chính sách bảo mật</div>
        </div>
      </div>
    </div>
  </div>
  <div class="chinhsachbaomat">
    <div class="container">
      <div class="heading">
        <p class="title">Chính sách bảo mật</p>
      </div>
      <div class="content" ms-role="block">
        <p class="title-content">
          Chính sách bảo mật
        </p>
        <div class="des-con">
          <p>
            Chính sách bảo mật này giải thích cách chúng tôi thu thập, sử dụng, chia sẻ dữ liệu cá nhân
            của
            bạn
            khi bạn sử dụng các dịch vụ được cung cấp trên các trang web và ứng dụng của chúng tôi hoặc
            tương
            tác với chúng tôi.
            Dữ liệu cá nhân là bất kỳ thông tin nào về bạn mà bạn có thể được nhận dạng hoặc có thể nhận
            dạng
            được. Điều này có thể bao gồm các thông tin như:
          </p>

          <ul ms-role="list">
            <li ms-role="item">
              <p>Tên, ngày sinh, địa chỉ email, số điện thoại, số điện
                thoại di động.</p>
            </li>
            <li ms-role="item">
              <p>Thông tin về địa chỉ giao hàng (nơi ở, sinh sống).</p>
            </li>
            <li ms-role="item">
              <p>Thông tin liên quan đến cách bạn sử dụng và tương tác với các trang web, ứng dụng và
                dịch
                vụ
                của
                chúng tôi.
                Đôi khi các trang web và ứng dụng của chúng tôi có thể chứa các liên kết đến các
                trang
                web
                và
                dịch
                vụ không thuộc nhóm dịch vụ của <strong>NỘI THẤT HĐT</strong>. Các trang web và dịch
                vụ
                này có chính
                sách
                bảo
                mật
                của riêng họ. Nếu bạn nhấp vào liên kết đến các trang web và ứng dụng không phải của
                <strong>NỘI THẤT HĐT</strong>,
                bạn nên đọc chính sách bảo mật được hiển thị trên trang web của họ.
              </p>
            </li>
          </ul>


        </div>
        <p class="title-content">
          Chúng tôi là ai và cách liên hệ với chúng tôi
        </p>
        <div class="des-con">
          Đại Học Nông Lâm, phường Linh Trung , thành phố Thủ Đức là nơi lưu trữ dữ liệu của bạn. Điều này
          có
          nghĩa là chúng tôi chịu trách nhiệm quyết
          định cách thức và lý do chúng tôi giữ và sử dụng dữ liệu cá nhân của bạn. Nếu bạn muốn liên hệ
          trực
          tiếp với chúng tôi, bạn có thể tìm thấy chi tiết liên hệ của chúng tôi tại đây:
          <strong>"điền thẻ html trang liên hệ."</strong>
        </div>
        <p class="title-content">
          Các loại dữ liệu cá nhân chúng tôi thu thập về bạn:
        </p>
        <div class="des-con">
          <p>
            Chúng tôi thu thập dữ liệu cá nhân của bạn khi bạn truy cập các trang web và ứng dụng của
            chúng
            tôi, đăng ký sản phẩm hoặc dịch vụ, đóng góp cho <strong>NỘI THẤT HĐT</strong> hoặc khi bạn
            tương tác với chúng
            tôi. Chúng tôi sẽ chỉ thu thập dữ liệu cá nhân của bạn theo luật hiện hành. Chúng tôi thu
            thập
            dữ liệu cá nhân của bạn theo nhiều cách khác nhau:
          </p>
          <ul ms-role="list">
            <li ms-role="item">
              <p> Trực tiếp từ bạn, khi bạn đăng ký dịch vụ của chúng tôi và khi bạn duyệt các
                trang web của chúng tôi hoặc sử dụng các ứng dụng của chúng tôi</p>
            </li>
            <li ms-role="item">
              <p>Dữ liệu cá nhân chúng tôi tạo ra về bạn, ví dụ: dữ liệu cá nhân mà chúng tôi sử dụng
                để
                xác
                thực bạn hoặc dữ liệu cá nhân ở dạng địa chỉ IP của bạn hoặc tùy chọn của bạn</p>
            </li>
            <li ms-role="item">
              <p> Dữ liệu cá nhân mà chúng tôi thu thập từ các bên thứ ba, ví dụ: dữ liệu cá nhân giúp
                chúng
                tôi chống gian lận hoặc chúng tôi thu thập, với sự cho phép của bạn, khi bạn tương
                tác
                với
                các tài khoản mạng xã hội của mình</p>

            </li>


          </ul>
          <p>Khi bạn đăng ký tài khoản <strong>NỘI THẤT HĐT</strong> trên <a
                  href="register.jsp">đăng ký tài
            khoản</a> chúng tôi thu thập:</p>

          <ul ms-role="list">
            <li ms-role="item">
              <p>Tên của bạn</p>
            </li>
            <li ms-role="item">
              <p>Địa chỉ email của bạn</p>
            </li>
            <li ms-role="item">
              <p>Địa chỉ cư trú hoặc địa chỉ thanh toán của bạn.</p>
            </li>
            <li ms-role="item">
              <p>Số điện thoại liên hệ của bạn.</p>
            </li>


          </ul>

          <p>
            Bạn có thể thay đổi hoặc xóa các chi tiết này bằng cách sử dụng chức năng cài đặt Thông tin
            cá
            nhân trong tài khoản <strong>NỘI THẤT HĐT</strong> của mình.
          </p>
          <p>
            Dữ liệu cá nhân chúng tôi tạo ra về bạn
          </p>
          <p>
            Khi bạn đăng ký tài khoản báo Thanh Niên, chúng tôi chỉ định cho bạn một số ID duy nhất mà
            chúng
            tôi sử dụng để nhận dạng bạn khi bạn đăng nhập vào các dịch vụ của chúng tôi. Điều này sẽ
            nhận
            ra bạn nếu bạn đăng nhập bằng cùng một tài khoản trên một thiết bị mới hoặc thông qua một
            ứng
            dụng khác, chẳng hạn như ứng dụng <strong>NỘI THẤT HĐT</strong> trên thiết bị di động.
            Khi bạn sử dụng các trang web hoặc ứng dụng của chúng tôi, chúng tôi cũng có thể sử dụng
            cookie
            hoặc công nghệ tương tự để thu thập thêm dữ liệu, bao gồm:
          </p>
          <ul ms-role="list">
            <li ms-role="item">
              <p> Địa chỉ IP của bạn - một mã số để xác định thiết bị của bạn, cùng với quốc gia, khu
                vực
                hoặc
                thành
                phố nơi bạn ở</p>

            </li>
            <li ms-role="item">
              <p> Thông tin về cách bạn tương tác với các dịch vụ của chúng tôi</p>
            </li>
            <li ms-role="item">
              <p> Lịch sử duyệt web của bạn về nội dung bạn đã truy cập trên các trang web của chúng
                tôi,
                bao
                gồm cả
                cách bạn được giới thiệu đến các trang web của chúng tôi qua các trang web khác</p>
            </li>
            <li ms-role="item">
              <p>
                Thông tin chi tiết về máy tính, thiết bị di động, TV, máy tính bảng hoặc các thiết
                bị
                khác
                của bạn,
                ví dụ: ID thiết bị duy nhất, nhà cung cấp hoặc ID quảng cáo duy nhất và các trình
                duyệt
                được
                sử dụng
                để truy cập nội dung của chúng tôi
              </p>

            </li>

          </ul>
          <ul ms-role="list">
            <li ms-role="item">
              <p>Dữ liệu thu thập từ Facebook, Google, Zalo: Khi bạn đăng nhập bằng thông tin đăng
                nhập từ
                các tài khoản này, <strong>NỘI THẤT HĐT</strong> sẽ
                nhận được các thông tin công khai từ hồ sơ của bạn bao gồm:
                họ tên, địa chỉ email (xác thực hoặc chưa).</p>
            </li>
            <li ms-role="item">
              <p>Sử dụng dữ liệu cá nhân: Thông tin này sẽ được dùng để tạo hồ sơ tài khoản báo Thanh
                Niên
                của bạn.
                Nếu bạn xóa ứng dụng <strong>NỘI THẤT HĐT</strong> từ cài đặt Facebook, Google, hoặc
                Zalo, <strong>NỘI THẤT HĐT</strong> sẽ không còn
                quyền truy cập vào dữ liệu mới từ tài khoản của bạn,
                nhưng vẫn lưu giữ các thông tin đã nhận được trước đó khi bạn tạo tài khoản lần đầu.
              </p>
            </li>
          </ul>
          <p class="title-content">
            Cách chúng tôi thu thập dữ liệu cá nhân
          </p>

          <p>Chúng tôi thu thập dữ liệu cá nhân khi bạn:</p>
          <ul ms-role="list">
            <li ms-role="item">Đăng ký tài khoản trên <a href="register.jsp">đăng ký
              tài
              khoản</a> của
              <strong>NỘI THẤT HĐT</strong>
            </li>
            <li ms-role="item">Thanh toán mua bất kỳ sản phẩm / dịch vụ nào khác</li>
            <li ms-role="item">Sử dụng thiết bị di động để truy cập nội dung của chúng tôi</li>
            <li ms-role="item"> Truy cập và tương tác với bất kỳ trang web và ứng dụng nào của chúng tôi
            </li>
            <li ms-role="item">Thông qua cookie và công nghệ tương tự khác</li>
            <li ms-role="item">Khi bạn liên hệ với chúng tôi qua email, mạng xã hội, ứng dụng của chúng
              tôi
              hoặc các công nghệ tương tự
            </li>
          </ul>

          <p class="title-content">
            Cách chúng tôi sử dụng dữ liệu cá nhân của bạn
          </p>

          <p>Chúng tôi chỉ sử dụng dữ liệu cá nhân được thu thập thông qua các trang web và ứng dụng của
            mình
            khi chúng tôi có lý do chính đáng và cơ sở pháp lý để làm như vậy. Chúng tôi xác định các cơ
            sở
            pháp lý dựa trên các mục đích mà chúng tôi đã thu thập dữ liệu cá nhân của bạn.</p>

          <p class="title-content">
            Cookie và các công nghệ tương tự
          </p>
          <p> Khi bạn truy cập các trang web của chúng tôi hoặc khi bạn sử dụng các ứng dụng của chúng
            tôi,
            chúng
            tôi có thể tự động thu thập dữ liệu cá nhân từ bạn bằng cách sử dụng cookie hoặc các công
            nghệ
            tương
            tự. Cookie là một tệp nhỏ có thể được đặt trên thiết bị của bạn cho phép chúng tôi nhận ra
            và
            ghi
            nhớ bạn.</p>

          <p>Chúng tôi sử dụng cookie theo nhiều cách để cải thiện trải nghiệm của bạn trên trang web của
            chúng
            tôi, bao gồm:</p>
          <ul ms-role="list">
            <li ms-role="item"> Giữ cho bạn đăng nhập</li>
            <li ms-role="item"> Hiểu cách bạn sử dụng trang web của chúng tôi</li>
            <li ms-role="item"> Hiển thị cho bạn các nội dung có liên quan đến bạn</li>
            <li ms-role="item"> Hiển thị cho bạn các sản phẩm và dịch vụ của <strong>NỘI THẤT
              HĐT</strong>
              phù hợp với bạn
            </li>
            <li ms-role="item"> Làm việc với các đối tác để cung cấp cho bạn quảng cáo phù hợp</li>
          </ul>

          <p class="title-content">
            Liên hệ với chúng tôi để biết thông tin về cách chúng tôi sử dụng dữ liệu cá nhân của bạn
          </p>

          <p>
            Nếu bạn có bất kỳ câu hỏi nào về cách chúng tôi sử dụng dữ liệu cá nhân của bạn hoặc nếu bạn
            lo
            lắng về cách dữ liệu cá nhân của bạn được sử dụng, vui lòng liên hệ với chúng tôi tại Đại
            học
            Nông Lâm,
            phường Linh Trung, thành phố Thủ Đức. Hoặc, gửi email tới email của chúng tôi <a
                  href="mailto:chutoanduc2059">nhom6webnoithat@gmail.com</a>
          </p>
          <p class="title-content">
            Các thay đổi đối với chính sách bảo mật này </p>
          <p>Nếu chúng tôi quyết định thay đổi chính sách bảo mật của mình, chúng tôi sẽ đăng các thay đổi
            ở
            đây. Nếu những thay đổi là quan trọng, chúng tôi cũng có thể chọn gửi email cho tất cả người
            dùng đã đăng ký của chúng tôi với các chi tiết mới
            Cập nhật lần cuối: ngày 11 tháng 11 năm 2024</p>
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