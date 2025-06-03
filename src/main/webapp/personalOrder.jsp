<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin đơn hàng</title>
    <link href="https://fonts.googleapis.com/css?family=Fira+Sans+Condensed:300,400,600i&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/personal_style.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <style>
        .order-list-container {
            background: white;
            border: 1px solid lightgray;
            overflow: hidden;
        }

        .order-list-header {
            background: whitesmoke;
            color: #333;
            padding: 15px 20px;
            border-bottom: 1px solid lightgray;
        }

        .order-list-header h2 {
            margin: 0;
            font-size: 20px;
            color: #333;

        }

        .order-item {
            border-bottom: 1px solid #eee;
            padding: 15px 20px;
            transition: background-color 0.2s ease;
        }

        .order-item:hover {
            background-color: whitesmoke;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .order-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
        }

        .order-info {
            flex: 1;
        }

        .order-number {
            font-size: 16px;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;

        }

        .order-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            color: #6c757d;
            font-size: 13px;
        }

        .order-detail-item {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .order-detail-item i {
            width: 14px;
            color: #6c757d;
        }

        .order-status-section {
            text-align: center;
            min-width: 100px;
        }

        .order-status {
            padding: 4px 8px;
            border: 1px solid #ccc;
            background: white;
            color: #333;
            font-size: 11px;
            display: inline-block;
            margin-bottom: 8px;
        }

        .status-pending {
            background-color: #f8f9fa;
            color: #333;
        }

        .status-confirmed {
            background-color: #f8f9fa;
            color: #333;
        }

        .status-shipping {
            background-color: #f8f9fa;
            color: #333;
        }

        .status-delivered {
            background-color: #f8f9fa;
            color: #333;
        }

        .status-cancelled {
            background-color: #f8f9fa;
            color: #333;
        }

        .order-amount {
            font-size: 14px;
            font-weight: bold;
            color: #333;

        }

        .order-actions {
            display: flex;
            flex-direction: column;
            gap: 6px;
            min-width: 120px;
        }

        .action-btn {
            padding: 6px 10px;
            border: 1px solid lightgray;
            text-decoration: none;
            text-align: center;
            font-size: 11px;
            cursor: pointer;
            background: white;
            color: #6c757d;

        }

        .btn-detail:hover, .btn-cancel:hover {
            background-color: whitesmoke;
            text-decoration: none;
            color: #333;
        }

        .btn-disabled {
            background-color: #f8f9fa;
            border-color: lightgray;
            color: #6c757d;
            cursor: not-allowed;
        }

        .no-orders {
            text-align: center;
            padding: 40px 20px;
            color: #6c757d;
        }

        .no-orders i {
            font-size: 36px;
            color: #ccc;
            margin-bottom: 15px;
            display: block;
        }

        .back-button {
            display: inline-block;
            padding: 8px 15px;
            background-color: whitesmoke;
            color: #6c757d;
            text-decoration: none;
            border: 1px solid lightgray;
            margin-bottom: 15px;

        }

        .back-button:hover {
            background-color: #333;
            color: white;
            text-decoration: none;
        }

        .order-summary {
            background: whitesmoke;
            padding: 10px;
            margin-top: 10px;
            display: none;
            border: 1px solid lightgray;
        }

        .order-summary.show {
            display: block;
        }

        .product-count {
            color: #6c757d;
            cursor: pointer;
        }

        .product-count:hover {
            text-decoration: underline;
            color: #333;
        }

        .product-item {
            display: flex;
            justify-content: space-between;
            margin: 5px 0;
            padding: 5px;
            background: white;
            border: 1px solid lightgray;
            font-size: 12px;
        }

        /* Pagination Styles */
        .pagination-container {
            padding: 20px;
            text-align: center;
            border-top: 1px solid lightgray;
            background: whitesmoke;
        }

        .pagination {
            display: inline-flex;
            list-style: none;
            margin: 0;
            padding: 0;
            gap: 5px;
        }

        .pagination li {
            display: inline-block;
        }

        .pagination a, .pagination span {
            display: block;
            padding: 6px 10px;
            text-decoration: none;
            border: 1px solid lightgray;
            background: white;
            color: #6c757d;
            font-size: 12px;

        }

        .pagination a:hover {
            background: whitesmoke;
            text-decoration: none;
            color: #333;
        }

        .pagination .current {
            background: #333;
            color: white;
            border-color: #333;
        }

        .pagination .disabled {
            color: #ccc;
            background: #f8f9fa;
            cursor: not-allowed;
        }

        @media (max-width: 768px) {
            .order-row {
                flex-direction: column;
                gap: 10px;
            }

            .order-details {
                grid-template-columns: 1fr;
            }

            .order-actions {
                flex-direction: row;
                justify-content: center;
            }
        }

        /* Thêm các style này vào phần <style> trong JSP của bạn */

        /* Smooth transitions cho loading */
        .loading-transition {
            opacity: 0.7;
            transition: opacity 0.3s ease;
        }

        /* Animation cho spinner */
        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }

        /* Cải thiện pagination */
        .pagination {
            display: inline-flex;
            list-style: none;
            margin: 0;
            padding: 0;
            gap: 3px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .pagination li {
            display: inline-block;
        }

        .pagination a, .pagination span {
            display: block;
            padding: 8px 12px;
            text-decoration: none;
            border: 1px solid #ddd;
            background: white;
            color: #666;
            font-size: 13px;

            transition: all 0.2s ease;
            border-radius: 4px;
            min-width: 20px;
            text-align: center;
        }

        .pagination a:hover {
            background: #f8f9fa;
            text-decoration: none;
            color: #333;
            border-color: #adb5bd;
            transform: translateY(-1px);
        }

        .pagination .current {
            background: #007bff;
            color: white;
            border-color: #007bff;
            font-weight: 600;
        }

        .pagination .disabled {
            color: #ccc;
            background: #f8f9fa;
            cursor: not-allowed;
            border-color: #e9ecef;
        }

        /* Cải thiện order items */
        .order-item {
            border-bottom: 1px solid #eee;
            padding: 20px;
            transition: all 0.3s ease;
            background: white;
        }

        .order-item:hover {
            background-color: #f8f9fa;
            transform: translateX(2px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        /* Action buttons cải tiến */
        .action-btn {
            padding: 8px 12px;
            border: 1px solid #ddd;
            text-decoration: none;
            text-align: center;
            font-size: 12px;
            cursor: pointer;
            background: white;
            color: #666;
            transition: all 0.2s ease;
            border-radius: 4px;
            display: inline-block;
        }

        .action-btn:hover {
            background-color: #f8f9fa;
            text-decoration: none;
            color: #333;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .btn-disabled {
            background-color: #f8f9fa !important;
            border-color: #ddd !important;
            color: #999 !important;
            cursor: not-allowed !important;
            transform: none !important;
            box-shadow: none !important;
        }

        /* Loading states */
        .action-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            pointer-events: none;
        }

        /* Order summary animation */
        .order-summary {
            background: #f8f9fa;
            padding: 15px;
            margin-top: 10px;
            display: none;
            border: 1px solid #e9ecef;
            border-radius: 4px;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                max-height: 0;
                padding: 0 15px;
            }
            to {
                opacity: 1;
                max-height: 200px;
                padding: 15px;
            }
        }

        /* Product count hover effect */
        .product-count {
            color: #007bff;
            cursor: pointer;
            transition: all 0.2s ease;
            padding: 2px 4px;
            border-radius: 3px;
        }

        .product-count:hover {
            background-color: #007bff;
            color: white;
            transform: scale(1.05);
        }

        /* Status badges cải tiến */
        .order-status {
            padding: 6px 12px;
            border: none;
            background: #e9ecef;
            color: #495057;
            font-size: 11px;
            display: inline-block;
            margin-bottom: 8px;
            border-radius: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-confirmed {
            background-color: #cce5ff;
            color: #004085;
        }

        .status-shipping {
            background-color: #d4edda;
            color: #155724;
        }

        .status-delivered {
            background-color: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        /* Responsive improvements */
        @media (max-width: 768px) {
            .pagination {
                gap: 2px;
            }

            .pagination a, .pagination span {
                padding: 6px 8px;
                font-size: 12px;
                min-width: 16px;
            }

            .order-item {
                padding: 15px;
            }

            .order-actions {
                flex-direction: column;
                gap: 8px;
            }

            .action-btn {
                font-size: 11px;
                padding: 6px 10px;
            }
        }

        /* Error và success states */
        .error-state {
            color: #dc3545;
            text-align: center;
            padding: 40px 20px;
        }

        .success-state {
            color: #28a745;
            text-align: center;
            padding: 20px;
        }

        /* No orders state cải tiến */
        .no-orders {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }

        .no-orders i {
            font-size: 48px;
            color: #dee2e6;
            margin-bottom: 20px;
            display: block;
        }

        .no-orders h3 {
            margin-bottom: 10px;
            color: #495057;
        }

        .no-orders p {
            margin-bottom: 20px;
            color: #6c757d;
        }

        /* Pagination info styling */
        #pagination-info {
            margin-top: 12px;
            font-size: 13px;
            color: #6c757d;
            text-align: center;
        }

        #pagination-info strong {
            color: #495057;
        }
    </style>
</head>
<body>
<div class="personal">
    <jsp:include page="/components/header.jsp"/>
    <script src="js/showSearch.js"></script>
    <script src="js/actionOfProfile.js"></script>
    <script src="js/showCart.js"></script>

    <div class="navigation_titlePage">
        <div class="container">
            <div class="alpha">
                <img src="img/background.jpg" alt="">
            </div>
            <div class="omega">
                <h1 class="title">Đơn hàng của tôi</h1>
                <div class="path">
                    <div class="home">Trang chủ</div>
                    <div class="icon">
                        <ul class="icons">
                            <li><i class="fa fa-chevron-right"></i></li>
                        </ul>
                    </div>
                    <div class="contact">Đơn hàng</div>
                </div>
            </div>
        </div>
    </div>

    <div class="content_section">
        <div class="container">
            <div class="alpha">
                <div class="avt">
                    <img src="img/avt/avt.jpg" alt="">
                    <div class="welcomeName">
                        <h5>Welcome<br><strong>${sessionScope.userName}</strong></h5>
                    </div>
                </div>
                <a href="personal.jsp" class="button">
                    <div class="address"><h5><i class="fa fa-home"></i>TRANG TÀI KHOẢN</h5></div>
                </a>
                <div class="address" style="background-color: whitesmoke;">
                    <h5><i class="fa fa-box"></i> ĐƠN HÀNG</h5>
                </div>
                <a href="contact.jsp" class="button">
                    <div class="address"><h5><i class="fa fa-location-dot"></i> ĐỊA CHỈ</h5></div>
                </a>
                <a href="shop?onlyFavorite=true" class="button">
                    <div class="address"><h5><i class="fa fa-arrow-rotate-left"></i> ƯA THÍCH</h5></div>
                </a>
                <a href="personal.jsp" class="button">
                    <div class="address"><h5><i class="fa fa-person"></i> TÀI KHOẢN</h5></div>
                </a>
                <a href="changePassword.jsp" class="button">
                    <div class="address"><h5><i class="fa fa-lock"></i> ĐỔI MẬT KHẨU</h5></div>
                </a>
                <div class="address" onclick="document.getElementById('logoutForm').submit();">
                    <h5><i class="fa fa-right-from-bracket"></i> ĐĂNG XUẤT</h5>
                    <form id="logoutForm" action="logout" method="post">
                        <button type="submit" class="button" style="display: none;"></button>
                    </form>
                </div>
            </div>

            <div class="omega">
                <a href="personal.jsp" class="back-button">
                    ← Quay lại tài khoản
                </a>

                <div class="order-list-container">
                    <div class="order-list-header">
                        <h2>Danh sách đơn hàng</h2>
                        <p style="margin: 5px 0 0 0; color: #666; font-size: 13px;">Quản lý và theo dõi tình trạng đơn
                            hàng của bạn</p>
                    </div>
                    <div id="order-list-content">
                    </div>
                    <div id="pagination-container" class="pagination-container" style="display: none;">
                        <ul class="pagination" id="pagination-list">
                        </ul>
                        <div id="pagination-info" style="margin-top: 10px; font-size: 12px; color: #666;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="components/footer.jsp"/>
</div>
<script src="js/personalOrder.js"></script>
</body>
</html>