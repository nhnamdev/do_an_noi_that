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
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Locale;

@WebServlet(name = "OrderController", value = "/orderInformation")
public class OrderController extends HttpServlet {
    private OrderDao orderDao = new OrderDao();
    private static final int ORDERS_PER_PAGE = 2;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userIdLogin");

        if (userID == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String ajaxRequest = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(ajaxRequest);

        if (isAjax) {
            handleAjaxRequest(request, response, userID);
        } else {
            handleNormalRequest(request, response, userID);
        }
    }

    private void handleAjaxRequest(HttpServletRequest request, HttpServletResponse response, Integer userID) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String pageParam = request.getParameter("page");
            int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

            int offset = (currentPage - 1) * ORDERS_PER_PAGE;
            int totalOrders = orderDao.getTotalOrdersByUserId(userID);
            int totalPages = (int) Math.ceil((double) totalOrders / ORDERS_PER_PAGE);

            List<Order> orderList = orderDao.getOrdersByUserIdWithPagination(userID, offset, ORDERS_PER_PAGE);

            Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<>();
            for (Order order : orderList) {
                List<OrderItem> items = orderDao.getOrderItemsByOrderId(order.getOrderId());
                orderItemsMap.put(order.getOrderId(), items);
            }

            NumberFormat formatter = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

            if (orderList.isEmpty()) {
                out.println("<div class=\"no-orders\">");
                out.println("    <i class=\"fa fa-shopping-bag\"></i>");
                out.println("    <h3>Bạn chưa có đơn hàng nào</h3>");
                out.println("    <p>Hãy khám phá và mua sắm những sản phẩm tuyệt vời của chúng tôi!</p>");
                out.println("    <a href=\"shop\" class=\"back-button\" style=\"margin-top: 15px;\">");
                out.println("        Mua sắm ngay");
                out.println("    </a>");
                out.println("</div>");
            } else {
                for (Order order : orderList) {
                    List<OrderItem> orderItems = orderItemsMap.get(order.getOrderId());

                    out.println("<div class=\"order-item\">");
                    out.println("    <div class=\"order-row\">");
                    out.println("        <div class=\"order-info\">");
                    out.println("            <div class=\"order-number\">");
                    out.println("                #" + (order.getOrderNumber() != null ? order.getOrderNumber() : "N/A"));
                    out.println("            </div>");
                    out.println("            <div class=\"order-details\">");

                    out.println("                <div class=\"order-detail-item\">");
                    out.println("                    <i class=\"fa fa-calendar\"></i>");
                    out.println("                    <span>");
                    if (order.getOrderDate() != null) {
                        out.println(order.getOrderDate().format(dateFormatter));
                    } else {
                        out.println("Không xác định");
                    }
                    out.println("                    </span>");
                    out.println("                </div>");

                    out.println("                <div class=\"order-detail-item\">");
                    out.println("                    <i class=\"fa fa-user\"></i>");
                    out.println("                    <span>" + (order.getCustomerName() != null ? order.getCustomerName() : "Không xác định") + "</span>");
                    out.println("                </div>");
                    out.println("                <div class=\"order-detail-item\">");
                    out.println("                    <i class=\"fa fa-phone\"></i>");
                    out.println("                    <span>" + (order.getCustomerPhone() != null ? order.getCustomerPhone() : "Không xác định") + "</span>");
                    out.println("                </div>");
                    out.println("                <div class=\"order-detail-item\">");
                    out.println("                    <i class=\"fa fa-box\"></i>");
                    out.println("                    <span class=\"product-count\" onclick=\"toggleOrderSummary(" + order.getOrderId() + ")\">");
                    out.println("                        " + (orderItems != null ? orderItems.size() : 0) + " sản phẩm");
                    out.println("                    </span>");
                    out.println("                </div>");
                    out.println("            </div>");

                    out.println("            <div class=\"order-summary\" id=\"summary-" + order.getOrderId() + "\">");
                    out.println("                <strong>Sản phẩm trong đơn hàng:</strong>");
                    if (orderItems != null) {
                        for (OrderItem item : orderItems) {
                            out.println("                <div class=\"product-item\">");
                            out.println("                    <span>" + item.getProductName() + " x" + item.getQuantity() + "</span>");
                            out.println("                    <span style=\"color: #333; font-weight: bold;\">");
                            out.println("                        " + formatter.format(item.getTotalPrice()) + "đ");
                            out.println("                    </span>");
                            out.println("                </div>");
                        }
                    }
                    out.println("            </div>");
                    out.println("        </div>");

                    out.println("        <div class=\"order-status-section\">");
                    String status = order.getOrderStatus() != null ? order.getOrderStatus() : "pending";
                    String statusText = getStatusText(status);
                    out.println("            <span class=\"order-status status-" + status + "\">" + statusText + "</span>");
                    out.println("            <div class=\"order-amount\">");
                    out.println("                " + formatter.format(order.getTotalAmount()) + "đ");
                    out.println("            </div>");
                    out.println("        </div>");

                    out.println("        <div class=\"order-actions\">");
                    out.println("            <a href=\"orderReceived?orderId=" + order.getOrderId() + "\" class=\"action-btn btn-detail\">");
                    out.println("                Xem chi tiết");
                    out.println("            </a>");

                    if ("pending".equals(status)) {
                        out.println("            <button onclick=\"cancelOrder(" + order.getOrderId() + ")\" class=\"action-btn btn-cancel\">");
                        out.println("                Hủy đơn");
                        out.println("            </button>");
                    } else {
                        String actionText = getActionText(status);
                        out.println("            <span class=\"action-btn btn-disabled\">");
                        out.println("                " + actionText);
                        out.println("            </span>");
                    }
                    out.println("        </div>");
                    out.println("    </div>");
                    out.println("</div>");
                }
            }
            out.println("<!--PAGINATION_INFO:" + currentPage + ":" + totalPages + ":" + totalOrders + "-->");
        } catch (Exception e) {
            out.println("<div class=\"no-orders\">");
            out.println("    <h3>Có lỗi xảy ra khi tải dữ liệu</h3>");
            out.println("    <p>Error: " + e.getMessage() + "</p>");
            out.println("</div>");
        }
    }

    private void handleNormalRequest(HttpServletRequest request, HttpServletResponse response, Integer userID) throws ServletException, IOException {
        try {
            String pageParam = request.getParameter("page");
            int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

            int offset = (currentPage - 1) * ORDERS_PER_PAGE;
            int totalOrders = orderDao.getTotalOrdersByUserId(userID);
            int totalPages = (int) Math.ceil((double) totalOrders / ORDERS_PER_PAGE);

            List<Order> orderList = orderDao.getOrdersByUserIdWithPagination(userID, offset, ORDERS_PER_PAGE);

            Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<>();
            for (Order order : orderList) {
                List<OrderItem> items = orderDao.getOrderItemsByOrderId(order.getOrderId());
                orderItemsMap.put(order.getOrderId(), items);
            }
            request.setAttribute("orderList", orderList);
            request.setAttribute("orderItemsMap", orderItemsMap);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalOrders", totalOrders);

            request.getRequestDispatcher("personalOrder.jsp").forward(request, response);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/personal.jsp");
        }
    }

    private String getStatusText(String status) {
        switch (status) {
            case "pending":
                return "Chờ xác nhận";
            case "confirmed":
                return "Đã xác nhận";
            case "shipping":
                return "Đang giao hàng";
            case "delivered":
                return "Đã giao hàng";
            case "cancelled":
                return "Đã hủy";
            default:
                return "Chờ xử lý";
        }
    }

    private String getActionText(String status) {
        switch (status) {
            case "cancelled":
                return "Đã hủy";
            case "delivered":
                return "Hoàn thành";
            default:
                return "Đang xử lý";
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("cancel".equals(action)) {
            String orderIdParam = request.getParameter("orderId");
            if (orderIdParam != null) {
                try {
                    int orderId = Integer.parseInt(orderIdParam);
                    boolean success = orderDao.cancelOrder(orderId);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    if (success) {
                        response.getWriter().write("{\"success\": true, \"message\": \"Đơn hàng đã được hủy thành công\"}");
                    } else {
                        response.getWriter().write("{\"success\": false, \"message\": \"Không thể hủy đơn hàng\"}");
                    }
                    return;
                } catch (NumberFormatException e) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"success\": false, \"message\": \"ID đơn hàng không hợp lệ\"}");
                    return;
                }
            }
        }

        doGet(request, response);
    }
}