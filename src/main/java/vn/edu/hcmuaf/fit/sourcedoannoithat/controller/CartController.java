package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.CartDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.DetailDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Cart;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.CartDisplayItem;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ProductDetail;

@WebServlet(name = "CartController", value = "/cart/*")
public class CartController extends HttpServlet {
    private ProductDao productDao = new ProductDao();
    private CartDisplayItem cartDisplayItem;
    private CartDao cartDao = new CartDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getPathInfo();
        if (action == null) {
            action = "/";
        }
        switch (action) {
            case "/":
                showCart(request, response);
                break;
//            default:
//                System.out.println(action);
//                response.sendRedirect(request.getContextPath() + "/");
//                return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getPathInfo();

        switch (action) {
            case "/addToCart":
                addToCart(request, response);
                break;
            case "/updateQuantity":
                updateCartQuantity(request, response);
                break;
            default:
                System.out.println(action);
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
        }
    }

    public void showCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userIdLogin");

        HashMap<String, CartDisplayItem> cart = (HashMap<String, CartDisplayItem>) session.getAttribute("cart");
        if (userId != null && (cart == null || cart.isEmpty())) {
            // Tải giỏ hàng từ database
            List<Cart> cartItems = cartDao.getCartItems(userId);

            if (!cartItems.isEmpty()) {
                cart = new HashMap<>();
                DetailDao detailDao = new DetailDao();
                for (Cart item : cartItems) {
                    // Lấy thông tin sản phẩm
                    Product product = productDao.getProductById(String.valueOf(item.getProductID()));
                    ProductDetail productDetail = detailDao.getProductDetail(String.valueOf(item.getProductID()));
                    if (product != null) {
                        // Tạo CartDisplayItem từ thông tin sản phẩm và số lượng
                        CartDisplayItem displayItem = new CartDisplayItem(item.getQuantity(), product, productDetail);
                        cart.put(String.valueOf(item.getProductID()), displayItem);
                    }
                }

                // Lưu giỏ hàng vào session
                session.setAttribute("cart", cart);
            }
        }
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
        return;
    }

    public void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productID = request.getParameter("id");
        Product product = productDao.getProductById(productID);

//        lay ra thong tin cua san pham, vd mau sac, chieu cao x chieu rong
        DetailDao detailDao = new DetailDao();
        ProductDetail productDetail = detailDao.getProductDetail(productID);

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userIdLogin");
//        kiem tra dang nhap, neu chua dang nhap ma ng dung an them vao gio hang thi se chuyen sang trang login
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
//lay ra quantity cua san pham, mac dinh neu khong thay doi gi thi khi an vao nut them vao gio hang thi se lay so luong la 1
        int quantity = 1;
        try {
            String quantityString = request.getParameter("quantity");
            if (quantityString != null && !quantityString.isEmpty()) {
                quantity = Integer.parseInt(quantityString);
            }
        } catch (NumberFormatException e) {
//            neu co loi thi lay so luong la 1
            quantity = 1;
        }

        HashMap<String, CartDisplayItem> cart = (HashMap<String, CartDisplayItem>) session.getAttribute("cart");

//         gio hang trong thi khoi tao them moi 1 san pham khi an vao button "them vao gio hang"
        if (cart == null) {
            cart = new HashMap<>();
            cartDisplayItem = new CartDisplayItem(quantity, product, productDetail);
            cart.put(productID, cartDisplayItem);
        } else {
//            kiem tra neu trong gio hang da co 1 san pham truoc do da duoc them vao, thi tang so luong sp
            if (cart.containsKey(productID)) {
                CartDisplayItem cartItem = cart.get(productID);
                cartItem.setQuantity(cartItem.getQuantity() + quantity);
//                ko co thi them moi san pham do vao gio hang
                if (cartItem.getProductDetail() == null) {
                    cartItem.setProductDetail(productDetail);
                }
            } else {
                cartDisplayItem = new CartDisplayItem(quantity, product, productDetail);
                cart.put(productID, cartDisplayItem);
            }
        }
        session.setAttribute("cart", cart);
//        in ra san pham
//        for (Map.Entry<String, CartDisplayItem> entry : cart.entrySet()) {
//            System.out.println(entry.getValue().getProduct().getName() + " - So luong: " + entry.getValue().getQuantity());
//        }
//        luu gio hang vao database
        try {
            int prodId = Integer.parseInt(productID);
            // neu trong gio hang da co san pham do, thi cap nhat so luong
            int totalQuantity = cart.get(productID).getQuantity();
            cartDao.addOrUpdateCartItem(userId, prodId, totalQuantity);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/cart/");
        return;
    }

    public void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    public void updateCartQuantity(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        phuong thuc nay se cap nhat lai toan bo gio hang khi nguoi dung nhan vao
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userIdLogin");
        HashMap<String, CartDisplayItem> cart = (HashMap<String, CartDisplayItem>) session.getAttribute("cart");

        if (cart != null) {
            // lay ra id san pham va so luong san pham tuong ung
            String[] productIDs = request.getParameterValues("id");
            String[] quantities = request.getParameterValues("quantity");

            if (productIDs != null && quantities != null && productIDs.length == quantities.length) {
                // cap nhat lai so luong san pham
                for (int i = 0; i < productIDs.length; i++) {
                    String productID = productIDs[i];
                    try {
                        int quantity = Integer.parseInt(quantities[i]);
                        if (quantity > 0 && cart.containsKey(productID)) {
                            CartDisplayItem item = cart.get(productID);
                            item.setQuantity(quantity);
                            if (item.getProductDetail() == null) {
                                DetailDao detailDao = new DetailDao();
                                ProductDetail detail = detailDao.getProductDetail(productID);
                                item.setProductDetail(detail);
                            }
                            if (userId != null) {
                                try {
                                    int prodId = Integer.parseInt(productID);
                                    cartDao.addOrUpdateCartItem(userId, prodId, quantity);
                                } catch (NumberFormatException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
                session.setAttribute("cart", cart);
            }
        }
        response.sendRedirect(request.getContextPath() + "/cart/");
    }

    public void clearCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
