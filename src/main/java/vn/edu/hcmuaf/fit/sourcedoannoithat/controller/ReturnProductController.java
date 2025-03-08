package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ReturnProduct;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ReturnProductDao;

import java.io.IOException;

@WebServlet("/returnProduct")
public class ReturnProductController extends HttpServlet {
    private ReturnProductDao returnProductDao = new ReturnProductDao();

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String statusParam = req.getParameter("status");
            String imageLink = req.getParameter("file-input");
            String orderCodeParam = req.getParameter("id");
            String purchaseDate = req.getParameter("date-input");
            String reason = req.getParameter("countries");
            String decription = req.getParameter("message");

            if (statusParam == null || orderCodeParam == null || purchaseDate == null || reason == null) {
                resp.getWriter().write("Vui lòng điền đầy đủ thông tin.");
                return;
            }

            int orderCode = Integer.parseInt(orderCodeParam);
            if (imageLink == null || imageLink.isEmpty()) {
                imageLink = "img/sofa1.jpg";
            }
            ReturnProduct returnProduct = new ReturnProduct(statusParam, imageLink, orderCode, purchaseDate, reason, decription);

            boolean isSuccess = returnProductDao.insertReturnProduct(returnProduct);

            if (isSuccess) {
                resp.sendRedirect("index.jsp");
            } else {
                resp.sendRedirect("returnProduct.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("Có lỗi xảy ra: " + e.getMessage());
        }

    }
}
