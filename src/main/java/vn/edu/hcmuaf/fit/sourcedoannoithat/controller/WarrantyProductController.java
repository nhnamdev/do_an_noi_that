package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.WarrantyProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.WarrantyProduct;

import java.io.IOException;

@WebServlet("/cart")
public class WarrantyProductController extends HttpServlet {
    private WarrantyProductDao warrantyProductDao = new WarrantyProductDao();

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String userEmail = (String) req.getSession().getAttribute("userEmail");
            Integer userId = (Integer) req.getSession().getAttribute("userIdLogin");
            String nameProduct = (String) req.getSession().getAttribute("productName");
            Double price = (Double) req.getSession().getAttribute("productPrice");
            String image = (String) req.getSession().getAttribute("imageProduct");
            WarrantyProduct warrantyProduct = new WarrantyProduct(userEmail, nameProduct, "", "", "");
            boolean isSuccess = warrantyProductDao.createListWarrantyProduct(warrantyProduct);
            boolean addOrder = warrantyProductDao.addOrder(nameProduct, image, userId, price, userEmail);
            if (isSuccess && addOrder) {
                resp.sendRedirect("index.jsp");
            } else {
                resp.sendRedirect("cart.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("Có lỗi xảy ra: " + e.getMessage());
        }
    }
}