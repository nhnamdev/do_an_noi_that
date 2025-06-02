package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.VNPay;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.OrderDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.CartDisplayItem;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Invoice;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order.Order;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order.OrderItem;
import vn.edu.hcmuaf.fit.sourcedoannoithat.service.VNPayService;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

@WebServlet("/vnpayReturn")
public class VNPayReturnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    OrderDao orderDao = new OrderDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        VNPayService Config = new VNPayService();
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userIdLogin");

        try (PrintWriter out = response.getWriter()) {
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements(); ) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);

            if (signValue.equals(vnp_SecureHash)) {
                String paymentCode = request.getParameter("vnp_TransactionNo");
                String tempTxnRef = request.getParameter("vnp_TxnRef");

                boolean transSuccess = false;
                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) { //thanh toan thanh cong xoa het san pham trong cart
                    transSuccess = true;
                }

                System.out.println("DEBUG VNPay: Transaction status = " + transSuccess);
                System.out.println("DEBUG VNPay: User ID = " + userID);

                if (transSuccess && userID != null) {
                    try {
                        // Lấy thông tin order từ session
                        Map<String, String> orderInfo = (Map<String, String>) session.getAttribute("pendingOrderInfo");
                        System.out.println("DEBUG VNPay: Pending order info = " + (orderInfo != null));

                        if (orderInfo != null) {
                            // Lấy cart để xử lý
                            HashMap<String, CartDisplayItem> cartToProcess = getCartToProcess(session);
                            System.out.println("DEBUG VNPay: Cart size = " + (cartToProcess != null ? cartToProcess.size() : 0));

                            if (cartToProcess != null && !cartToProcess.isEmpty()) {
                                // Tạo Order
                                Order order = createOrderFromInfo(userID, orderInfo, cartToProcess);

                                // Lưu Order và nhận order_id
                                int orderId = orderDao.createOrderAndGetId(order);
                                System.out.println("DEBUG VNPay: Order created with ID = " + orderId);

                                if (orderId > 0) {
                                    // Tạo Invoice với order_id thật
                                    Invoice invoice = new Invoice();
                                    invoice.setOrderId(orderId);
                                    invoice.setTotal(Double.parseDouble(orderInfo.get("totalBill")));
                                    invoice.setDiscount(0);
                                    invoice.setFinalAmount(Double.parseDouble(orderInfo.get("totalBill")));
                                    invoice.setPaymentMethod(1); // 1 = VNPay
                                    invoice.setVoucherId(0);
                                    invoice.setStatus("success");
                                    invoice.setTransactionCode(paymentCode);

                                    // Lưu Invoice
                                    int invoiceId = orderDao.insertOrder(invoice);
                                    System.out.println("DEBUG VNPay: Invoice created with ID = " + invoiceId);

                                    if (invoiceId > 0) {
                                        // ✅ THÀNH CÔNG - KHÔNG XÓA CART Ở ĐÂY
                                        // Cart sẽ được xóa trong OrderReceivedController sau khi hiển thị thành công

                                        // Lưu thông tin để hiển thị
                                        session.setAttribute("lastOrderId", orderId);
                                        session.setAttribute("lastInvoiceId", invoiceId);

                                        // Xóa thông tin tạm thời VNPay
                                        session.removeAttribute("pendingOrderInfo");

                                        System.out.println("DEBUG VNPay: Order and Invoice created successfully");
                                    }
                                }
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        System.out.println("DEBUG VNPay: Exception occurred: " + e.getMessage());
                        transSuccess = false; // Nếu có lỗi thì coi như thất bại
                    }
                }

                // Forward đến paymentReturn.jsp với kết quả
                request.setAttribute("transResult", transSuccess);
                request.getRequestDispatcher("paymentReturn.jsp").forward(request, response);
            } else {
                // Invalid signature
                System.out.println("DEBUG VNPay: Invalid signature");
                request.setAttribute("transResult", false);
                request.getRequestDispatcher("paymentReturn.jsp").forward(request, response);
            }
        }
    }

    // Helper methods
    private HashMap<String, CartDisplayItem> getCartToProcess(HttpSession session) {
        Boolean isBuyNow = (Boolean) session.getAttribute("isBuyNow");
        if (Boolean.TRUE.equals(isBuyNow)) {
            return (HashMap<String, CartDisplayItem>) session.getAttribute("buyNowCart");
        } else {
            return (HashMap<String, CartDisplayItem>) session.getAttribute("cart");
        }
    }

    private Order createOrderFromInfo(Integer userID, Map<String, String> orderInfo, HashMap<String, CartDisplayItem> cartToProcess) {
        Order order = new Order();
        order.setUserId(userID);
        order.setCustomerName(orderInfo.get("fullname"));
        order.setCustomerPhone(orderInfo.get("phone"));
        order.setShippingAddress(connectFullAddress(
                orderInfo.get("address"),
                orderInfo.get("ward"),
                orderInfo.get("district"),
                orderInfo.get("province")
        ));
        order.setTotalAmount(Double.parseDouble(orderInfo.get("totalBill")));
        order.setOrderStatus("pending");
        order.setPaymentMethod("Thanh toán qua VNPay");
        order.setNotes(orderInfo.get("notes"));

        List<OrderItem> orderItems = new ArrayList<>();
        for (CartDisplayItem cartItem : cartToProcess.values()) {
            Product product = cartItem.getProduct();
            OrderItem orderItem = new OrderItem();
            orderItem.setProductId(product.getId());
            orderItem.setProductName(product.getName());
            orderItem.setProductImage(product.getImg());
            orderItem.setUnitPrice(product.getPrice());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setTotalPrice(product.getPrice() * cartItem.getQuantity());
            orderItems.add(orderItem);
        }
        order.setOrderItems(orderItems);
        return order;
    }

    private String connectFullAddress(String address, String ward, String district, String province) {
        StringBuilder fullAddress = new StringBuilder();
        if (address != null && !address.trim().isEmpty()) {
            fullAddress.append(address.trim());
        }
        if (ward != null && !ward.trim().isEmpty()) {
            if (fullAddress.length() > 0) fullAddress.append(", ");
            fullAddress.append(ward.trim());
        }
        if (district != null && !district.trim().isEmpty()) {
            if (fullAddress.length() > 0) fullAddress.append(", ");
            fullAddress.append(district.trim());
        }
        if (province != null && !province.trim().isEmpty()) {
            if (fullAddress.length() > 0) fullAddress.append(", ");
            fullAddress.append(province.trim());
        }
        return fullAddress.toString();
    }
}