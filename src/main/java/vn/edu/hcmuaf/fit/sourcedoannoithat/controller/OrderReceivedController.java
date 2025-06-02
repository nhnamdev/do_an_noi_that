package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.OrderDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order.Order;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order.OrderItem;

import java.io.IOException;
import java.util.List;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.CartDao;

@WebServlet(name = "OrderReceivedController", value = "/orderReceived")
public class OrderReceivedController extends HttpServlet {
    private OrderDao orderDao = new OrderDao();
    private CartDao cartDao = new CartDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userIdLogin");

        if (userID == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Lấy order_id từ session (được set từ CheckoutController hoặc VNPayReturnController)
        Integer lastOrderId = (Integer) session.getAttribute("lastOrderId");
        Integer lastInvoiceId = (Integer) session.getAttribute("lastInvoiceId");

        if (lastOrderId == null) {
            // Nếu không có order_id, chuyển về trang chủ
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        try {
            // Lấy thông tin đơn hàng từ database
            Order orderInfo = orderDao.getOrderById(lastOrderId);
            if (orderInfo == null) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // Lấy danh sách sản phẩm trong đơn hàng
            List<OrderItem> orderItems = orderDao.getOrderItemsByOrderId(lastOrderId);

            // Set attributes để hiển thị trong JSP
            request.setAttribute("orderInfo", orderInfo);
            request.setAttribute("orderItems", orderItems);

            // Forward đến JSP để hiển thị
            request.getRequestDispatcher("/orderReceived.jsp").forward(request, response);

            // ✅ XÓA CART SAU KHI HIỂN THỊ THÀNH CÔNG
            // Lấy thông tin về loại cart từ session trước khi xóa
            Boolean isBuyNow = (Boolean) session.getAttribute("isBuyNow");

            if (Boolean.TRUE.equals(isBuyNow)) {
                // Xóa buyNowCart - chỉ xóa session vì buyNow không lưu vào DB
                session.removeAttribute("buyNowCart");
                session.removeAttribute("isBuyNow");
                System.out.println("DEBUG OrderReceived: Removed buyNowCart (session only) after successful display");
            } else {
                // Xóa cart thường - xóa cả session và database
                session.removeAttribute("cart");

                boolean cartCleared = cartDao.clearCartByUserId(userID);
                if (cartCleared) {
                    System.out.println("DEBUG OrderReceived: Successfully cleared cart from database for user " + userID);
                } else {
                    System.out.println("DEBUG OrderReceived: Failed to clear cart from database for user " + userID);
                }
            }

            // Clear session data sau khi xóa cart
            session.removeAttribute("lastOrderId");
            session.removeAttribute("lastInvoiceId");
            session.removeAttribute("pendingOrderInfo"); // Xóa thông tin VNPay tạm thời nếu có

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi, không xóa cart để người dùng có thể thử lại
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}