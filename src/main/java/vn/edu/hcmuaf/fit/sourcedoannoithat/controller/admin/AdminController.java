package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order.Order;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        session.setAttribute("isAdmin", true);

        try {
            // Dashboard
            DashboardDao dao = new DashboardDao();

            // Payment history
            PaymentHistoryDao paymentHistoryDao = new PaymentHistoryDao();
            List<Invoice> listPaymentHistory = null;
            try {
                listPaymentHistory = paymentHistoryDao.getAllPaymentInvoice();
            } catch (Exception e) {
                e.printStackTrace();
                listPaymentHistory = new ArrayList<>();
            }

            // Return products
            ReturnProductDao returnProductDao = new ReturnProductDao();
            List<ReturnProduct> list = null;
            try {
                list = returnProductDao.getReturnProduct();
            } catch (Exception e) {
                e.printStackTrace();
                list = new ArrayList<>();
            }
            String date = req.getParameter("filterDate");
            ContactDao contactDao = new ContactDao();
            List<Contact> contact = new ArrayList<>();
            List<String> names = new ArrayList<>();

            try {
                if (date != null && !date.trim().isEmpty()) {
                    contact = contactDao.getContactsByDate(date);
                } else {
                    req.setAttribute("errorMessage", "Vui lòng chọn một ngày để lọc phản hồi.");
                }
                names = contactDao.getName();
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Warranty products
            WarrantyProductDao warrantyProductDao = new WarrantyProductDao();
            List<WarrantyProduct> warrantyProduct = new ArrayList<>();
            try {
                warrantyProduct = warrantyProductDao.getListWarrantyProduct();
            } catch (Exception e) {
                e.printStackTrace();
            }

            SearchDao searchDao = new SearchDao();
            List<Product> listP = new ArrayList<>();
            try {
                listP = searchDao.getAllProducts();
            } catch (Exception e) {
                e.printStackTrace();
            }
            OrderManagementDAO orderManagementDao = null;
            List<Order> orders = new ArrayList<>();
            int pendingOrders = 0, confirmedOrders = 0, shippingOrders = 0, deliveredOrders = 0, cancelledOrders = 0;

            try {
                orderManagementDao = new OrderManagementDAO();

                String orderAction = req.getParameter("orderAction");
                String orderIdStr = req.getParameter("orderId");

                if (orderAction != null && orderIdStr != null) {
                    try {
                        int orderId = Integer.parseInt(orderIdStr);

                        switch (orderAction) {
                            case "approve":
                                boolean approveSuccess = orderManagementDao.approveOrder(orderId);
                                if (approveSuccess) {
                                    req.setAttribute("successMessage", "Đã duyệt đơn hàng thành công!");
                                } else {
                                    req.setAttribute("errorMessage", "Không thể duyệt đơn hàng!");
                                }
                                break;
                            case "reject":
                                boolean rejectSuccess = orderManagementDao.rejectOrder(orderId);
                                if (rejectSuccess) {
                                    req.setAttribute("successMessage", "Đã từ chối đơn hàng!");
                                } else {
                                    req.setAttribute("errorMessage", "Không thể từ chối đơn hàng!");
                                }
                                break;
                            case "ship":
                                boolean shipSuccess = orderManagementDao.shipOrder(orderId);
                                if (shipSuccess) {
                                    req.setAttribute("successMessage", "Đã chuyển đơn hàng sang trạng thái vận chuyển!");
                                } else {
                                    req.setAttribute("errorMessage", "Không thể cập nhật trạng thái!");
                                }
                                break;
                            case "complete":
                                boolean completeSuccess = orderManagementDao.completeOrder(orderId);
                                if (completeSuccess) {
                                    req.setAttribute("successMessage", "Đã hoàn thành đơn hàng!");
                                } else {
                                    req.setAttribute("errorMessage", "Không thể hoàn thành đơn hàng!");
                                }
                                break;
                        }
                    } catch (NumberFormatException e) {
                        req.setAttribute("errorMessage", "Mã đơn hàng không hợp lệ!");
                    }
                }

                // Get orders list
                String statusFilter = req.getParameter("statusFilter");
                String searchKeyword = req.getParameter("searchOrder");

                if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
//                    orders = orderManagementDao.searchOrders(searchKeyword);
                } else if (statusFilter != null && !statusFilter.isEmpty()) {
                    orders = orderManagementDao.getOrdersByStatus(statusFilter);
                } else {
                    orders = orderManagementDao.getAllOrdersForAdmin();
                }
                pendingOrders = orderManagementDao.getOrderCountByStatus("pending");
                confirmedOrders = orderManagementDao.getOrderCountByStatus("confirmed");
                shippingOrders = orderManagementDao.getOrderCountByStatus("shipping");
                deliveredOrders = orderManagementDao.getOrderCountByStatus("delivered");
                cancelledOrders = orderManagementDao.getOrderCountByStatus("cancelled");
            } catch (Exception e) {
                e.printStackTrace();
                orders = new ArrayList<>();
            }
            // Account management
            ProfileDao profileDao = new ProfileDao();
            List<AccountManagement> profile = new ArrayList<>();

            try {
                profile = profileDao.getAccountAdmin();

                String accountIdToDelete = req.getParameter("deleteId");
                String accountIdToLock = req.getParameter("lockId");
                String demoteIdStr = req.getParameter("demoteId");
                String promoteIdStr = req.getParameter("promoteId");
                String accountIdToUnlock = req.getParameter("unlockId");

                if (accountIdToDelete != null) {
                    profileDao.deleteAccount(Integer.parseInt(accountIdToDelete));
                }
                if (demoteIdStr != null) {
                    profileDao.demoteAccount(Integer.parseInt(demoteIdStr));
                }
                if (promoteIdStr != null) {
                    profileDao.promoteAccount(Integer.parseInt(promoteIdStr));
                }
                if (accountIdToLock != null) {
                    profileDao.lockUser(Integer.parseInt(accountIdToLock));
                }
                if (accountIdToUnlock != null) {
                    profileDao.unlockUser(Integer.parseInt(accountIdToUnlock));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            int totalUsers = 0, totalOrders = 0, totalActiveUsers = 0;
            double totalSales = 0;

            try {
                totalUsers = dao.getTotalUsers();
                totalOrders = dao.getTotalOrders();
                totalSales = dao.getTotalSales();
                totalActiveUsers = dao.getTotalActiveUsers();
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Dashboard
            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("totalOrders", totalOrders);
            req.setAttribute("totalSales", totalSales);
            req.setAttribute("totalActiveUsers", totalActiveUsers);

            // quan ly don hang
            req.setAttribute("orders", orders);
            req.setAttribute("pendingOrders", pendingOrders);
            req.setAttribute("confirmedOrders", confirmedOrders);
            req.setAttribute("shippingOrders", shippingOrders);
            req.setAttribute("deliveredOrders", deliveredOrders);
            req.setAttribute("cancelledOrders", cancelledOrders);
            req.setAttribute("currentStatusFilter", req.getParameter("statusFilter"));
            req.setAttribute("currentSearchKeyword", req.getParameter("searchOrder"));

            // cac thuoc tinh khac
            req.setAttribute("listPaymentHistory", listPaymentHistory);
            req.setAttribute("warranty", warrantyProduct);
            req.setAttribute("profile", profile);
            req.setAttribute("listP", listP);
            req.setAttribute("names", names);
            req.setAttribute("contact", contact);
            req.setAttribute("product", list);
            req.getRequestDispatcher("admin.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // Xử lý cập nhật trạng thái đơn hàng
        String orderAction = req.getParameter("orderAction");
        String orderIdStr = req.getParameter("orderId");

        if (orderAction != null && orderIdStr != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                OrderManagementDAO orderManagementDao = new OrderManagementDAO();

                boolean success = false;
                String message = "";

                switch (orderAction) {
                    case "approve":
                        success = orderManagementDao.approveOrder(orderId);
                        message = success ? "Đã duyệt đơn hàng thành công!" : "Không thể duyệt đơn hàng!";
                        break;
                    case "reject":
                        success = orderManagementDao.rejectOrder(orderId);
                        message = success ? "Đã từ chối đơn hàng!" : "Không thể từ chối đơn hàng!";
                        break;
                    case "ship":
                        success = orderManagementDao.shipOrder(orderId);
                        message = success ? "Đã chuyển đơn hàng sang trạng thái vận chuyển!" : "Không thể cập nhật trạng thái!";
                        break;
                    case "complete":
                        success = orderManagementDao.completeOrder(orderId);
                        message = success ? "Đã hoàn thành đơn hàng!" : "Không thể hoàn thành đơn hàng!";
                        break;
                }
                if (success) {
                    req.getSession().setAttribute("successMessage", message);
                } else {
                    req.getSession().setAttribute("errorMessage", message);
                }

            } catch (NumberFormatException e) {
                req.getSession().setAttribute("errorMessage", "Mã đơn hàng không hợp lệ!");
            } catch (Exception e) {
                e.printStackTrace();
                req.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống!");
            }
        }
        resp.sendRedirect("admin");
    }
}