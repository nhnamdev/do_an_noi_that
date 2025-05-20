<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Footer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<footer style="padding-bottom: 0 !important" class="bg-light py-4">
    <div class="container">
        <div class="row">
            <div class="col-md-4 text-center text-md-start mb-3">
                <img src="${pageContext.request.contextPath}/img/logo/logo-website.jpg"
                     alt="Mona Media" class="img-fluid" style="max-width: 150px;">
                <ul class="list-unstyled mt-3">
                    <li><a href="#" class="text-decoration-none text-dark">1073/3 Cộng Hòa, P.7, Q.Tân Bình, TP.HCM</a>
                    </li>
                    <li><a href="#" class="text-decoration-none text-dark">(+84) 0313-728-397</a></li>
                    <li><a href="#" class="text-decoration-none text-dark">info@themona.global</a></li>
                </ul>
            </div>
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold">Liên kết</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-decoration-none text-dark">Chính sách hoàn trả</a></li>
                    <li><a href="#" class="text-decoration-none text-dark">Thông tin giao hàng</a></li>
                    <li><a href="#" class="text-decoration-none text-dark">Chính sách bảo mật</a></li>
                    <li><a href="#" class="text-decoration-none text-dark">Thanh toán an toàn</a></li>
                </ul>
            </div>
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold">Hỗ trợ</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-decoration-none text-dark">Customer Service</a></li>
                    <li><a href="#" class="text-decoration-none text-dark">Privacy Policy</a></li>
                    <li><a href="#" class="text-decoration-none text-dark">Terms & Condition</a></li>
                    <li><a href="#" class="text-decoration-none text-dark">Manufactures</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="bg-white text-black text-left py-2 mt-4 ">
        <p class="mb-0">&copy; Thiết kế và lập trình bởi
            <img style="width: 100px; height: 30px"
                 src="${pageContext.request.contextPath}/img/logo/logo-website.jpg"
                 alt="MonaMedia">
        </p>
    </div>
</footer>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>