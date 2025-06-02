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

        // Lấy order_id từ session
        Integer lastOrderId = (Integer) session.getAttribute("lastOrderId");
        Integer lastInvoiceId = (Integer) session.getAttribute("lastInvoiceId");

        if (lastOrderId == null) {
            // Nếu không get dc order_id, chuyển về trang chủ
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

            List<OrderItem> orderItems = orderDao.getOrderItemsByOrderId(lastOrderId);

            request.setAttribute("orderInfo", orderInfo);
            request.setAttribute("orderItems", orderItems);

            request.getRequestDispatcher("/orderReceived.jsp").forward(request, response);

            // Lấy thông tin về loại đặt hàng từ session trước khi xóa
            Boolean isBuyNow = (Boolean) session.getAttribute("isBuyNow");

            if (Boolean.TRUE.equals(isBuyNow)) {
                // Xóa mua ngay session vì mua ngay không lưu vào DB
                session.removeAttribute("buyNowCart");
                session.removeAttribute("isBuyNow");
            } else {
                session.removeAttribute("cart");
                cartDao.clearCartByUserId(userID);
            }

            session.removeAttribute("lastOrderId");
            session.removeAttribute("lastInvoiceId");
            session.removeAttribute("pendingOrderInfo");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}