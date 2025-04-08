package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.CartDisplayItem;

@WebServlet(name = "CheckoutController", value = "/checkout/")
public class CheckoutController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userIdLogin");
        if (userID == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        HashMap<String, CartDisplayItem> cart = (HashMap<String, CartDisplayItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
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

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String district = request.getParameter("district");
        String province = request.getParameter("province");
        String fullAddress = request.getParameter("fullAddress");
        String notes = request.getParameter("order-notes");
        String paymentMethod = request.getParameter("payment");

        response.sendRedirect(request.getContextPath() + "/orderReceived.jsp");
    }
}
