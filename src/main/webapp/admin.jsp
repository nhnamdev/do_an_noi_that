<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.AccountManagement" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProfileDao" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ProductShop" %>
<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.SearchDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Integer role = (Integer) session.getAttribute("role");
    if (role == null || role != 1) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<%
    String searchQuery = request.getParameter("search");
    List<AccountManagement> acc = null;

    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        ProfileDao productDAO = new ProfileDao();
        acc = productDAO.searchAccounts(searchQuery);
    }
%>
<!DOCTYPE html>

<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đồ án web</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>
<jsp:include page="/admin/sidebarAdmin.jsp" />
<div class="content">
    <div id="mailBox2" class="detail">
        <h2>Thống kê phản hồi</h2>
        <form action="" method="get">
            <label for="filterDate">Chọn ngày:</label>
            <input type="date" name="filterDate" id="filterDate"/>

            <button type="submit" id="filterFeedback">Lọc phản hồi</button>
        </form>
        <div id="filteredResults">
            <h3>Kết quả lọc:</h3>
            <table border="1">
                <tr>
                    <th>Tên</th>
                    <th>Email</th>
                    <th>Chủ đề</th>
                    <th>Nội dung</th>
                </tr>
                <c:forEach items="${contact}" var="ct">
                    <tr>
                        <td>${ct.name}</td>
                        <td>${ct.email}</td>
                        <td>${ct.topic}</td>
                        <td>${ct.content}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>

    </div>
    <div id="mailBox3" class="detail">
        <h2>Tin nhắn</h2>
        <div class="chat-container">
            <div class="customer-list">
                <ul id="customerList">
                    <c:forEach items="${names}" var="n">
                        <li class="customer" onclick="location.href='admin?name=${n}'" style="cursor: pointer;">
                            <img src="img/avt.jpg" alt=""/>
                            <span>${n}</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div id="messagesContainer">
                <h3>Hộp thư</h3>
                <ul id="messagesList">
                    <c:if test="${not empty selectedContent}">
                        <c:forEach items="${selectedContent}" var="content">
                            <li>${content}</li>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
    <div id="showPL1" class="detail">
        <h1>Danh Sách Yêu Cầu</h1>
        <table>
            <thead>
            <tr>
                <th>Đổi/Trả</th>
                <th>Hình ảnh</th>
                <th>Mã đơn hàng</th>
                <th>Ngày Mua</th>
                <th>Lý Do</th>
                <th>Mô tả thêm</th>
                <th>Trạng Thái</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach items="${product}" var="rp">
                <tr>
                    <td>${rp.status}</td>
                    <td>${rp.imageLink}</td>
                    <td>${rp.orderCode}</td>
                    <td>${rp.purchaseDate}</td>
                    <td>${rp.reason}</td>
                    <td>${rp.description}</td>
                    <td class="status">Đang chờ xử lý</td>
                    <td>
                        <div class="action-buttons">
                            <button class="btn approve" onclick="handleApprove(this)">Duyệt</button>
                            <button class="btn reject" onclick="handleReject(this)">Từ Chối</button>
                            <button class="btn details" onclick="handleDetails(this)">Chi Tiết</button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <script src="js/return.js"></script>
    </div>
    <div id="showPL2" class="detail">
        <h1>Tình trạng đơn hàng</h1>
        <table>
            <thead>
            <tr>
                <th>Mã Đơn Hàng</th>
                <th>Tên sản phẩm</th>
                <th>Khách Hàng</th>
                <th>Ngày Đặt</th>
                <th>Tình Trạng</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${order}" var="o">
                <tr>
                    <td>${o.id}</td>
                    <td>${o.nameProduct}</td>
                    <td>${o.name}</td>
                    <td>${o.dateOrder}</td>
                    <td class="status">
                        <c:choose>
                            <c:when test="${o.pending == 0}">Chờ xử lý</c:when>
                            <c:when test="${o.pending == 1}">Chờ giao hàng</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <div class="action-buttons">
                            <c:if test="${o.pending == 0}">
                                <form action="" method="post">
                                    <input type="hidden" name="name" value="${o.name}">
                                    <input type="hidden" name="pid" value="${o.id}">
                                    <button type="submit" class="btn approve">Duyệt</button>
                                </form>
                            </c:if>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div id="manageList2" class="detail">
        <div class="search-section">
            <form action="admin.jsp" method="get" id="searchForm">
                <input type="search" id="search" name="search" placeholder="Nhập tên tài khoản tìm kiếm"
                       class="search-input">
                <select class="filter-select">
                    <option>Tài khoản</option>
                </select>
                <button type="submit" class="btn search-btn">Tìm</button>
            </form>
        </div>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Tài khoản</th>
                <th>Họ và Tên</th>
                <th>Email</th>
                <th>Số điện thoại</th>
                <th>Địa chỉ</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>
            <%
                String accountIdToDelete = request.getParameter("deleteId");
                if (accountIdToDelete != null) {
                    ProfileDao profileDao = new ProfileDao();
                    profileDao.deleteAccount(Integer.parseInt(accountIdToDelete));
                    response.sendRedirect("admin.jsp");
                    return;
                }
                List<AccountManagement> profile;
                String searchKeyword = request.getParameter("search");
                ProfileDao profileDao = new ProfileDao();
                if (searchKeyword != null && !searchKeyword.isEmpty()) {
                    profile = profileDao.searchAccounts(searchKeyword);
                    if (profile.isEmpty()) {
            %>
            <tr>
                <td colspan="7">Không tìm thấy tài khoản nào.</td>
            </tr>
            <%
                    }
                } else {
                    profile = profileDao.getAccountAdmin();
                }
                for (AccountManagement pr : profile) {
            %>
            <tr>
                <td><%= pr.getId() %>
                </td>
                <td><%= pr.getUsername() %>
                </td>
                <td><%= pr.getName() %>
                </td>
                <td><%= pr.getEmail() %>
                </td>
                <td><%= pr.getPhoneNumber() %>
                </td>
                <td><%= pr.getAddress() %>
                </td>
                <td>
                    <div class="action-buttons">
                        <a href="admin.jsp?deleteId=<%= pr.getId() %>" class="btn reject" style="text-decoration: none;"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản này?');">xóa</a>
                    </div>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <script src="js/customer-management.js"></script>
    </div>
    <div id="productsManagement" class="detail">
        <h2>Kho hàng</h2>

        <div class="header-actions">
            <div class="search-bar">
                <form action="admin.jsp" method="get">
                    <input type="text" id="searchInput" name="search" placeholder="Tìm kiếm sản phẩm..."/>
                    <button type="submit" id="searchButton"><i class="fa fa-search"></i></button>
                </form>
            </div>
            <button id="addProductButton">Thêm Sản Phẩm</button>
            <button id="exportFileButton">Xuất File</button>
        </div>

        <div id="editForm" style="display: none;">
            <form>
                <label for="editProductName">Tên Sản Phẩm:</label>
                <input type="text" id="editProductName" required>
                <label for="editSellingPrice">Giá Bán:</label>
                <input type="number" id="editSellingPrice" required>
                <label for="editCostPrice">Hình ảnh</label>
                <input type="text" id="editCostPrice" required>
                <button type="submit">Lưu</button>
                <button type="button" id="cancelEdit">Hủy</button>
            </form>
        </div>

        <div id="addProductPanel">
            <div class="panel-content">
                <h3>Thêm Sản Phẩm</h3>
                <form action="" method="post">
                    <label for="productName">Tên Sản Phẩm:</label>
                    <input type="text" id="productName" name="name" required/>

                    <label for="sellingPrice">Giá Bán:</label>
                    <input type="text" id="sellingPrice" name="price" required/>

                    <label for="costPrice">Hình ảnh(URL):</label>
                    <input type="text" id="costPrice" name="image" required/>


                    <button type="submit">Thêm</button>
                    <button type="button" id="closePanelButton">Hủy</button>
                </form>
            </div>
        </div>

        <div id="productTableContainer">
            <table id="productTable">
                <thead>
                <tr>
                    <th>Mã SP</th>
                    <th>Tên SP</th>
                    <th>Giá Bán</th>
                    <th>Hình ảnh</th>
                    <th>Đã bán</th>
                    <th>Hành Động</th>
                </tr>
                <tbody>
                <%
                    String searchKW = request.getParameter("search");
                    String pageParam = request.getParameter("page");
                    int pages = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
                    int pageSize = 10;

                    SearchDao productDao = new SearchDao();
                    int totalProducts = 0;

                    List<ProductShop> listP;
                    if (searchKW != null && !searchKW.isEmpty()) {
                        totalProducts = productDao.getTotalProductsBySearch(searchKW);
                        listP = productDao.searchProducts(searchKW);
                    } else {
                        totalProducts = productDao.getTotalProducts();
                        listP = productDao.getProductsByPage(pages, pageSize);
                    }


                    int totalPages = (int) Math.ceil((double) totalProducts / pageSize);


                    String productIdToDelete = request.getParameter("deletepId");
                    if (productIdToDelete != null) {
                        productDao.deleteProduct(Integer.parseInt(productIdToDelete));
                        response.sendRedirect("admin.jsp");
                        return;
                    }

                    for (ProductShop product : listP) {
                %>
                <tr>
                    <td><%= product.getId() %>
                    </td>
                    <td><%= product.getName() %>
                    </td>
                    <td><%= product.getPrice() %>
                    </td>
                    <td><%= product.getImg() %>
                    </td>
                    <td><%= product.getQuantitySold() %>
                    </td>
                    <td>
                        <a href="admin.jsp?deletepId=<%= product.getId() %>"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');"
                           class="btn deleteButton">Xóa</a>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>

        </div>
        <div id="paginationInfo">
            Hiển thị <%= (pages - 1) * pageSize + 1 %> -
            <%= Math.min(pages * pageSize, totalProducts) %> trên tổng số <%= totalProducts %> sản phẩm
        </div>

        <div id="paginationControls">
            <%
                if (totalProducts > 0) {
                    if (pages > 1) {
            %>
            <a href="admin.jsp?page=<%= pages - 1 %>&search=<%= (searchKW != null) ? searchKW : "admin.jsp" %>">Trước</a>

            <%
                }

                for (int i = 1; i <= totalPages; i++) {
            %>
            <a href="admin.jsp?page=<%= i %>&search=<%= (searchKW != null) ? searchKW : "admin.jsp" %>"
               class="<%= (i == pages) ? "active" : "" %>">
                <%= i %>
            </a>

            <%
                }

                if (pages < totalPages) {
            %>
            <a href="admin.jsp?page=<%= pages + 1 %>&search=<%= (searchKW != null) ? searchKW : "admin.jsp" %>">Tiếp</a>
            <%
                }
            } else {
            %>
            <p>Không có sản phẩm nào để hiển thị.</p>
            <%
                }
            %>
        </div>

    </div>

    <div id="warranty-container" class="detail">
        <div class="admin.jspsection">
            <h2>Danh Sách Nội Thất Bảo Hành</h2>
            <table class="warranty-table">
                <thead>
                <tr>
                    <th>Email Khách Hàng</th>
                    <th>Tên Sản Phẩm</th>
                    <th>Ngày Bảo Hành</th>
                    <th>Ngày Hết Bảo Hành</th>
                    <th>Trạng Thái</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${warranty}">
                    <tr>
                        <td>${item.email}</td>
                        <td>${item.name}</td>
                        <td>${item.warrantyDate}</td>
                        <td>${item.warrantyExpiryDate}</td>
                        <td class="${item.status == 'Còn bảo hành' ? 'hoan-tat' : 'dang-bao-hanh'}">
                                ${item.status}
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="js/about-management.js"></script>
<script src="js/showDetail.js"></script>
<script src="js/survey.js"></script>
<script src="js/revenue.js"></script>
<script src="js/productManagement.js"></script>
</body>
</html>