package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.DetailDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.OrderDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.CartDisplayItem;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Invoice;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ProductDetail;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order.Order;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order.OrderItem;

@WebServlet(name = "CheckoutController", value = "/checkout/")
public class CheckoutController extends HttpServlet {
    private ProductDao productDao = new ProductDao();
    private DetailDao detailDao = new DetailDao();
    OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userIdLogin");

        if (userID == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Xử lý checkout bình thường từ giỏ hàng
        HashMap<String, CartDisplayItem> cart = (HashMap<String, CartDisplayItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart/");
            return;
        }

        // Tính tổng tiền cho giỏ hàng thường
        double totalAmount = 0;
        for (CartDisplayItem item : cart.values()) {
            totalAmount += item.getProduct().getPrice() * item.getQuantity();
        }

        session.setAttribute("isBuyNow", false);
        request.setAttribute("cart", cart);
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("/cartCheckout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userIdLogin");

        if (userID == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Kiểm tra nếu là "Mua ngay" từ POST request
        String buyNow = request.getParameter("buyNow");
        String productId = request.getParameter("id");
        String quantityStr = request.getParameter("quantity");

        if ("true".equals(buyNow) && productId != null && quantityStr != null) {
            // Xử lý mua ngay - tạo cart tạm thời cho sản phẩm này
            try {
                int quantity = Integer.parseInt(quantityStr);
                Product product = productDao.getProductById(productId);
                ProductDetail productDetail = detailDao.getProductDetail(productId);

                if (product != null) {
                    // Tạo CartDisplayItem với constructor đúng
                    CartDisplayItem buyNowItem = new CartDisplayItem(quantity, product, productDetail);

                    // HashMap chứa sản phẩm mua ngay
                    HashMap<String, CartDisplayItem> buyNowCart = new HashMap<>();
                    buyNowCart.put(productId, buyNowItem);

                    session.setAttribute("buyNowCart", buyNowCart);
                    session.setAttribute("isBuyNow", true);

                    // Tính tiền cho sản phẩm mua ngay
                    double totalAmount = product.getPrice() * quantity;
                    request.setAttribute("cart", buyNowCart);
                    request.setAttribute("totalAmount", totalAmount);
                    request.getRequestDispatcher("/cartCheckout.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }
        }

        // Lấy thông tin từ form checkout
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String district = request.getParameter("district");
        String province = request.getParameter("province");
        String ward = request.getParameter("ward");
        String notes = request.getParameter("order-notes");
        String paymentMethod = request.getParameter("payment");
        String totalBillStr = request.getParameter("totalBill");

        // ✅ KIỂM TRA PHƯƠNG THỨC THANH TOÁN
        System.out.println("DEBUG: Payment method received: " + paymentMethod);

        // Kiểm tra phương thức thanh toán - nếu là VNPay thì chuyển sang VNPayController
        if ("vnpay".equals(paymentMethod)) {
            System.out.println("DEBUG: Forwarding to VNPay payment");
            // Forward đến VNPayController để xử lý thanh toán VNPay
            request.getRequestDispatcher("/payment").forward(request, response);
            return;
        }

        // ✅ XỬ LÝ THANH TOÁN COD
        if (!"cod".equals(paymentMethod)) {
            System.out.println("DEBUG: Invalid payment method: " + paymentMethod);
            // Lấy cart để hiển thị lỗi
            HashMap<String, CartDisplayItem> cartForError = getCartToProcess(session);
            showError(request, response, "Phương thức thanh toán không hợp lệ.", cartForError);
            return;
        }

        System.out.println("DEBUG: Processing COD payment");

        // Lấy cart để xử lý
        HashMap<String, CartDisplayItem> cartToProcess = getCartToProcess(session);

        if (cartToProcess == null || cartToProcess.isEmpty()) {
            System.out.println("DEBUG: Cart is empty, redirecting to cart page");
            response.sendRedirect(request.getContextPath() + "/cart/");
            return;
        }

        System.out.println("DEBUG: Cart size: " + cartToProcess.size());

        // Lưu order và invoice vào DB cho thanh toán COD
        try {
            // 1. Tạo Order
            Order order = new Order();
            order.setUserId(userID);
            order.setCustomerName(fullname);
            order.setCustomerPhone(phone);
            order.setShippingAddress(connectFullAddress(address, ward, district, province));
            order.setTotalAmount(Double.parseDouble(totalBillStr));
            order.setOrderStatus("pending");
            order.setPaymentMethod(getPaymentMethodText(paymentMethod));
            order.setNotes(notes);

            // 2. Tạo OrderItems
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

            System.out.println("DEBUG: Creating order with " + orderItems.size() + " items");

            // 3. Lưu Order và nhận order_id
            int orderId = orderDao.createOrderAndGetId(order);
            System.out.println("DEBUG: Order created with ID: " + orderId);

            if (orderId > 0) {
                Invoice invoice = new Invoice();
                invoice.setOrderId(orderId);
                invoice.setTotal(order.getTotalAmount());
                invoice.setDiscount(0); // hoặc tính từ voucher
                invoice.setFinalAmount(order.getTotalAmount());

                // Xác định payment_method_id - COD = 2
                invoice.setPaymentMethod(2); // 2=COD
                invoice.setVoucherId(0); // hoặc lấy từ session nếu có voucher
                invoice.setStatus("pending"); // COD sẽ là pending cho đến khi giao hàng

                // 5. Lưu Invoice
                int invoiceId = orderDao.insertOrder(invoice);
                System.out.println("DEBUG: Invoice created with ID: " + invoiceId);

                if (invoiceId > 0) {
                    // ✅ THÀNH CÔNG - KHÔNG XÓA CART Ở ĐÂY
                    // Cart sẽ được xóa trong OrderReceivedController sau khi hiển thị thành công

                    // Lưu thông tin để hiển thị ở trang xác nhận
                    session.setAttribute("lastOrderId", orderId);
                    session.setAttribute("lastInvoiceId", invoiceId);

                    System.out.println("DEBUG: Redirecting to orderReceived");
                    // ✅ CHUYỂN ĐẾN TRANG HIỂN THỊ THÔNG TIN ĐƠN HÀNG
                    response.sendRedirect(request.getContextPath() + "/orderReceived");
                } else {
                    // Lỗi tạo invoice
                    System.out.println("DEBUG: Failed to create invoice");
                    showError(request, response, "Có lỗi xảy ra khi tạo hóa đơn.", cartToProcess);
                }
            } else {
                // Lỗi tạo order
                System.out.println("DEBUG: Failed to create order");
                showError(request, response, "Có lỗi xảy ra khi tạo đơn hàng.", cartToProcess);
            }

        } catch (Exception e) {
            System.out.println("DEBUG: Exception occurred: " + e.getMessage());
            e.printStackTrace();
            HashMap<String, CartDisplayItem> cartForError = getCartToProcess(session);
            showError(request, response, "Có lỗi hệ thống xảy ra: " + e.getMessage(), cartForError);
        }
    }

    // ✅ HELPER METHOD ĐỂ LẤY CART ĐÚNG LOẠI
    private HashMap<String, CartDisplayItem> getCartToProcess(HttpSession session) {
        Boolean isBuyNow = (Boolean) session.getAttribute("isBuyNow");
        if (Boolean.TRUE.equals(isBuyNow)) {
            return (HashMap<String, CartDisplayItem>) session.getAttribute("buyNowCart");
        } else {
            return (HashMap<String, CartDisplayItem>) session.getAttribute("cart");
        }
    }

    private void showError(HttpServletRequest request, HttpServletResponse response, String errorMessage, HashMap<String, CartDisplayItem> cart) throws ServletException, IOException {
        request.setAttribute("errorMessage", errorMessage);
        if (cart != null) {
            request.setAttribute("cart", cart);
            double totalAmount = 0;
            for (CartDisplayItem item : cart.values()) {
                totalAmount += item.getProduct().getPrice() * item.getQuantity();
            }
            request.setAttribute("totalAmount", totalAmount);
        }
        request.getRequestDispatcher("/cartCheckout.jsp").forward(request, response);
    }

    //trong db có shipping address, nên phải connect các thành phần địa chỉ lại với nhau
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

    // chuyển phương thức thanh toán thành dạng chữ để lưu vào db
    private String getPaymentMethodText(String paymentMethod) {
        if (paymentMethod == null) return "COD";

        switch (paymentMethod.toLowerCase()) {
            case "vnpay":
                return "Thanh toán qua VNPay";
            case "cod":
                return "Trả tiền mặt khi nhận hàng (COD)";
            default:
                return "COD";
        }
    }
}