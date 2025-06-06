<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin</title>
</head>
<body>
<div class="sidebar">
    <div class="header">
        <h3>Admin</h3>
    </div>
    <!--hộp thư -->
    <button class="btn" onclick="showDetail('main_contentt')">Trang chủ</button>
    <button class="btn" onclick="mailBoxList();changeColor(this)">Hộp thư</button>
    <ul id="mailBoxList" class="nested-list">
        <li onclick="showDetail('mailBox2')">Thống kê phản hồi</li>
    </ul>
    <!--quản lý -->
    <button class="btn" onclick="manageList();changeColor(this)">Quản lý</button>
    <ul id="manageList" class="nested-list">
        <li onclick="showDetail('orderManagement')">Đơn đặt hàng
            <span class="badge badge-warning ms-2" id="pendingOrdersBadge">${pendingOrders}</span>
        </li>
        <%--        <ul id="showProductList" class="nested-list">--%>
        <li onclick="showDetail('showPL1')">Yêu cầu hoàn tiền/hủy đơn</li>
        <%--        </ul>--%>
        <li onclick="showDetail('manageList2')">Khách hàng</li>
    </ul>

    <button class="btn" onclick="showDetail('warranty-container');changeColor(this)">Bảo hành</button>
    <a href="${pageContext.request.contextPath}/mod" class="btn">
        </i> Mod
    </a>
    <a href="${pageContext.request.contextPath}/logout" class="btn">
        </i> Đăng xuất
    </a>


</div>
<script src="../js/about-management.js"></script>
<script src="../js/showDetail.js"></script>
<script src="../js/survey.js"></script>
<script src="../js/revenue.js"></script>
<script src="../js/productManagement.js"></script>
</body>
</html>
