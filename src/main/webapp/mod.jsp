<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Mod</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%--    <link rel="stylesheet" href="css/admin_style.css">--%>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <%--tesst--%>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport"/>
    <!-- Fonts and icons -->
    <script src="assets/js/plugin/webfont/webfont.min.js"></script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="assets/css/plugins.min.css"/>
    <link rel="stylesheet" href="assets/css/kaiadmin.min.css"/>
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="assets/css/demo.css"/>
    <%--    tesst--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_style.css">
    <%--DATATABLE--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
    <%--DATATABLE--%>
</head>
<body>
<jsp:include page="/mod/sidebarMod.jsp"/>
<%--CONTENT MAIN ADMIN --%>
<div class="content" style="margin-left: 18%">
    <div class="page-inner" id="main_contentt" >
        <div class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
            <div>
                <h3 class="fw-bold mb-3">Dashboard</h3>
                <h6 class="op-7 mb-2">Mod Dashboard</h6>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-icon">
                                <div class="icon-big text-center icon-primary bubble-shadow-small">
                                    <i class="fas fa-users"></i>
                                </div>
                            </div>
                            <div class="col col-stats ms-3 ms-sm-0">
                                <div class="numbers">
                                    <p class="card-category">Tài Khoản</p>
                                    <h4 class="card-title">1,294</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-icon">
                                <div class="icon-big text-center icon-info bubble-shadow-small">
                                    <i class="fas fa-user-check"></i>
                                </div>
                            </div>
                            <div class="col col-stats ms-3 ms-sm-0">
                                <div class="numbers">
                                    <p class="card-category">Bảo Hành</p>
                                    <h4 class="card-title">1303</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-icon">
                                <div class="icon-big text-center icon-success bubble-shadow-small">
                                    <i class="fas fa-luggage-cart"></i>
                                </div>
                            </div>
                            <div class="col col-stats ms-3 ms-sm-0">
                                <div class="numbers">
                                    <%--   Lay tu hoa don--%>
                                    <p class="card-category">Tổng Doanh Thu</p>
                                    <h4 class="card-title">$ 1,345</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-icon">
                                <div class="icon-big text-center icon-secondary bubble-shadow-small">
                                    <i class="far fa-check-circle"></i>
                                </div>
                            </div>
                            <div class="col col-stats ms-3 ms-sm-0">
                                <div class="numbers">
                                    <%--   Lay tu Order--%>
                                    <p class="card-category">Tổng Đơn Hàng</p>
                                    <h4 class="card-title">576</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6 col-md-6">
                <div class="card card-stats card-round">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-icon">
                                <div class="icon-big text-center icon-primary bubble-shadow-small">
                                    <i class="fa-solid fa-cart-plus"></i>
                                </div>
                            </div>
                            <div class="col col-stats ms-3 ms-sm-0">
                                <div class="numbers">
                                    <p class="card-category">Sản Phẩm Bán Chạy</p>
                                    <h4 class="card-title">1,294</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-6">
                <div class="card card-stats card-round">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-icon">
                                <div class="icon-big text-center icon-info bubble-shadow-small">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                </div>
                            </div>
                            <div class="col col-stats ms-3 ms-sm-0">
                                <div class="numbers">
                                    <p class="card-category">Sản Phẩm Bán Ế</p>
                                    <h4 class="card-title">1303</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
        <%--            Transaction History--%>
        <div class="row">
            <div class="col-md-12">
                <div class="card card-round">
                    <div class="card-header">
                        <div class="card-head-row card-tools-still-right">
                            <div class="card-title">Transaction History</div>
                            <div class="card-tools">
                                <div class="dropdown">
                                    <button id="btnExportPDF" class="btn btn-primary">Print</button>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <!-- Projects table -->
                            <table id="transactionTable" class="table align-items-center mb-0">

                                <thead class="thead-light">
                                <tr>
                                    <th scope="col">Payment Number</th>
                                    <th scope="col" class="text-end">Date & Time</th>
                                    <th scope="col" class="text-end">Amount</th>
                                    <th scope="col" class="text-end">Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="item" items="${listPaymentHistory}">
                                    <tr>
                                        <th scope="row">
                                            <button class="btn btn-icon btn-round btn-success btn-sm me-2">
                                                <i class="fa fa-check"></i>
                                            </button>
                                            Payment from #${item.userName}
                                        </th>
                                        <td class="text-end">${item.paymentTime}</td>
                                        <td class="text-end">$${item.amountPaid}</td>
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${item.status == 'success'}">
                                                    <span class="badge badge-success">Completed</span>
                                                </c:when>
                                                <c:when test="${item.status == 'pending'}">
                                                    <span class="badge badge-warning">Pending</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-danger">Failed</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--            End Transaction History--%>
    </div>
    <%--END CONTENT MAIN ADMIN --%>
</div>
</body>
</html>
