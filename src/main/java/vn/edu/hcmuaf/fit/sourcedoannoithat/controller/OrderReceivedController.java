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
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Invoice;

import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.time.format.DateTimeFormatter;

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

        String orderIdParam = request.getParameter("orderId");
        Integer orderId = null;
        boolean isFromOrderList = false;

        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            try {
                orderId = Integer.parseInt(orderIdParam);
                isFromOrderList = true;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/orderInformation");
                return;
            }
        } else {
            orderId = (Integer) session.getAttribute("lastOrderId");
        }

        if (orderId == null) {
            if (isFromOrderList) {
                response.sendRedirect(request.getContextPath() + "/orderInformation");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
            return;
        }

        try {
            Order orderInfo = orderDao.getOrderById(orderId);
            if (orderInfo == null) {
                if (isFromOrderList) {
                    response.sendRedirect(request.getContextPath() + "/orderInformation");
                } else {
                    response.sendRedirect(request.getContextPath() + "/");
                }
                return;
            }

            if (!Objects.equals(orderInfo.getUserId(), userID)) {
                response.sendRedirect(request.getContextPath() + "/orderInformation");
                return;
            }

            List<OrderItem> orderItems = orderDao.getOrderItemsByOrderId(orderId);
            Invoice invoiceInfo = orderDao.getInvoiceByOrderId(orderId);

            String formattedOrderDate = null;
            java.util.Date orderDateAsDate = null;
            if (orderInfo.getOrderDate() != null) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                formattedOrderDate = orderInfo.getOrderDate().format(formatter);
                orderDateAsDate = java.sql.Timestamp.valueOf(orderInfo.getOrderDate());
            }

            request.setAttribute("orderInfo", orderInfo);
            request.setAttribute("orderItems", orderItems);
            request.setAttribute("invoiceInfo", invoiceInfo);
            request.setAttribute("isFromOrderList", isFromOrderList);
            request.setAttribute("formattedOrderDate", formattedOrderDate);
            request.setAttribute("orderDateAsDate", orderDateAsDate);

            request.getRequestDispatcher("/orderReceived.jsp").forward(request, response);

            if (!isFromOrderList) {
                handleNewOrderCleanup(session, userID);
            }

        } catch (Exception e) {
            if (isFromOrderList) {
                response.sendRedirect(request.getContextPath() + "/orderInformation");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
        }
    }

    private void handleNewOrderCleanup(HttpSession session, Integer userID) {
        try {
            Boolean isBuyNow = (Boolean) session.getAttribute("isBuyNow");

            if (Boolean.TRUE.equals(isBuyNow)) {
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
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}