package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.DetailDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.CartDisplayItem;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ProductDetail;

@WebServlet(name = "CheckoutController", value = "/checkout/")
public class CheckoutController extends HttpServlet {
    private ProductDao productDao = new ProductDao();
    private DetailDao detailDao = new DetailDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
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

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String district = request.getParameter("district");
        String province = request.getParameter("province");
        String fullAddress = request.getParameter("fullAddress");
        String notes = request.getParameter("order-notes");
        String paymentMethod = request.getParameter("payment");

        // TODO: Xử lý lưu đơn hàng vào database ở đây

        // Xóa cart hoặc buyNowCart sau khi đặt hàng thành công
        Boolean isBuyNow = (Boolean) session.getAttribute("isBuyNow");
        if (Boolean.TRUE.equals(isBuyNow)) {
            // Nếu là mua ngay, chỉ xóa buyNowCart, giữ nguyên cart thường
            session.removeAttribute("buyNowCart");
            session.removeAttribute("isBuyNow");
        } else {
            // Nếu là checkout từ cart thường, xóa cart
            // TODO: Cũng cần xóa cart trong database sau khi đặt hàng thành công
            session.removeAttribute("cart");
        }

        response.sendRedirect(request.getContextPath() + "/orderReceived.jsp");
    }
}
