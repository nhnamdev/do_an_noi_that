<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đồ án web</title>
    <link rel="stylesheet" href="css/contact_style.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css"/>
    <script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"></script>
</head>

<body>
<div class="contactUs">
    <jsp:include page="/components/header.jsp"/>
    <script src="js/showSearch.js"></script>
    <script src="js/actionOfProfile.js"></script>
    <div class="overlay" id="overlay"></div>

    <div class="navigation_titlePage">
        <div class="container">
            <div class="alpha">
                <img src="img/background.jpg" alt="">
            </div>
            <div class="omega">
                <h1 class="title">Liên hệ</h1>
                <div class="path">
                    <div class="home">Trang chủ</div>
                    <div class="icon">
                        <ul class="icons">
                            <li><i class="fa fa-chevron-right"></i></li>
                        </ul>
                    </div>
                    <div class="contact">Liên hệ</div>
                </div>
            </div>
        </div>
    </div>
    <div class="content_section_1">
        <div class="container">
            <div class="title">
                <div class="labelTitle">Liên Hệ Với Chúng Tôi</div>
                <div class="more_information">Để biết thêm thông tin về sản phẩm và dịch vụ của chúng tôi. Vui lòng
                    gửi
                    Email cho chúng tôi.<br> Đội ngũ nhân viên của chúng tôi luôn sẵn sàng hỗ trợ bạn. Đừng ngần
                    ngại!
                </div>
            </div>
            <div class="content">
                <div class="alpha">
                    <div class="profileShop">
                        <iframe
                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.2587181495715!2d106.78530537590657!3d10.867916257497754!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752763da4787b9%3A0x5e4f93c5d6c4da68!2zxJDhuqFpIGjhu41jIE7DtG5nIEzDom0!5e0!3m2!1svi!2s!4v1742479268570!5m2!1svi!2s"
                                width="100%" height="660"
                                style="border:0; margin-top: 20px ;margin-left:10px ;margin-bottom: 10px;"
                                allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                </div>
                <div class="omega">
                    <div class="profile-Shop">
                        <div class="phone">
                            <div class="title">Số hotline
                                <div class="content">Mobile: +(84) 793451527
                                </div>
                            </div>
                        </div>
                        <div class="address">
                            <div class="title">Địa chỉ
                                <div class="content">Trường Đại học Nông Lâm TP.HCM, Phường
                                    Linh Trung, TP. Hồ Chí Minh
                                </div>
                            </div>

                        </div>
                    </div>
                    <form id="contact_form" method="post" action="contact" pix-confirm="hidden_pix_6">
                        <div class="inputName">
                            <label class="fullName">Họ và tên</label>
                            <input type="text" name="name" id="name" value="${sessionScope.userName}" required>
                        </div>
                        <div class="inputEmail">
                            <label for="email">Địa chỉ email</label>
                            <input type="email" name="email" id="email" value="${sessionScope.userEmail}" required>
                        </div>
                        <div class="inputSubject">
                            <label for="Subject">Chủ đề</label>
                            <input type="text" name="subject" id="subject" placeholder="Tùy chọn">
                        </div>
                        <div class="message-container">
                            <label for="message">Lời nhắn</label>
                            <textarea name="message" id="message" placeholder="Xin chào! Tôi muốn hỏi bạn về..."
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
    </div>
    <jsp:include page="components/footer.jsp"/>
</div>
</body>

</html>
