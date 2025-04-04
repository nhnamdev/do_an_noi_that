package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Order;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;

@WebServlet(name = "CartController", value = "/cart/*")
public class CartController extends HttpServlet {
    private ProductDao productDao = new ProductDao();
    private Order order;

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
//                request.getRequestDispatcher("index.jsp").forward(request, response);
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
            default:
                System.out.println(action);
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
        }
    }

    public void showCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        HashMap<String, Order> cart = (HashMap<String, Order>) session.getAttribute("cart");

        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
        return;
    }

    public void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productID = request.getParameter("id");
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
        Product product = productDao.getProductById(productID);
        HttpSession session = request.getSession();

        HashMap<String, Order> cart = (HashMap<String, Order>) session.getAttribute("cart");

//         gio hang trong thi khoi tao them moi 1 san pham khi an vao button "them vao gio hang"
        if (cart == null) {
            cart = new HashMap<>();
            order = new Order(quantity, product);
            cart.put(productID, order);
        } else {
//            kiem tra neu trong gio hang da co 1 san pham truoc do da duoc them vao, thi tang so luong sp
            if (cart.containsKey(productID)) {
                Order order = cart.get(productID);
                order.setQuantity(order.getQuantity() + quantity);
//                ko co thi them moi san pham do vao gio hang
            } else {
                order = new Order(quantity, product);
                cart.put(productID, order);
            }
        }
        session.setAttribute("cart", cart);
//        in ra san pham
//        for (Map.Entry<String, Order> entry : cart.entrySet()) {
//            System.out.println(entry.getValue().getProduct().getName() + " - So luong: " + entry.getValue().getQuantity());
//        }
        response.sendRedirect(request.getContextPath() + "/cart/");
        return;
    }
}
