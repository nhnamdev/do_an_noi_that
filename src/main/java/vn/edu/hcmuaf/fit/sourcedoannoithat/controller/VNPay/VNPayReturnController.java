package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.VNPay;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.CartDao;
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
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");
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
                String transactionStatus = request.getParameter("vnp_TransactionStatus");

                boolean transSuccess = false;
                int orderId = 0;

                if ("00".equals(transactionStatus)) {
                    @SuppressWarnings("unchecked")
                    Map<String, String> orderInfo = (Map<String, String>) session.getAttribute("pendingOrderInfo");
                    @SuppressWarnings("unchecked")
                    HashMap<String, CartDisplayItem> cartToProcess = (HashMap<String, CartDisplayItem>) session.getAttribute("cartToProcess");

                    if (orderInfo != null && cartToProcess != null) {
                        Integer userID = (Integer) session.getAttribute("userIdLogin");

                        if (userID != null) {
                            Order order = createOrderFromInfo(userID, orderInfo, cartToProcess);
                            order.setPaymentMethod("Thanh toán qua VNPay");

                            orderId = orderDao.createOrderAndGetId(order);

                            if (orderId > 0) {
                                Invoice invoice = new Invoice();
                                invoice.setOrderId(orderId);
                                invoice.setTotal(order.getTotalAmount());
                                invoice.setDiscount(0);
                                invoice.setFinalAmount(order.getTotalAmount());
                                invoice.setPaymentMethod(1);

                                int invoiceId = orderDao.insertOrder(invoice);

                                if (invoiceId > 0) {
                                    Invoice updateInvoice = new Invoice();
                                    updateInvoice.setId(invoiceId);
                                    updateInvoice.setTransactionCode(paymentCode);
                                    updateInvoice.setStatus("success");
                                    orderDao.updateOrderStatus(updateInvoice);
                                }

                                CartDao cartDao = new CartDao();
                                cartDao.clearCartByUserId(userID);

                                session.setAttribute("lastOrderId", orderId);
                                session.removeAttribute("pendingOrderInfo");
                                session.removeAttribute("cartToProcess");

                                transSuccess = true;
                            }
                        }
                    }
                }

                request.setAttribute("transResult", transSuccess);
                request.getRequestDispatcher("paymentReturn.jsp").forward(request, response);

            } else {
                request.setAttribute("transResult", false);
                request.getRequestDispatcher("paymentReturn.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("transResult", false);
            request.getRequestDispatcher("paymentReturn.jsp").forward(request, response);
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

        double totalBill = Double.parseDouble(orderInfo.get("totalBill"));
        order.setTotalAmount(totalBill);
        order.setOrderStatus("pending");
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