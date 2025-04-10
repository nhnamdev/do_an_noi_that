package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet(name = "HomeController", value = "/index")
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        ProductDao productDao = new ProductDao();
        List<Product> listProduct = productDao.getTop4BestSellers();
        request.setAttribute("listProduct", listProduct);
        if (listProduct != null) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("errorDb.jsp").forward(request, response);
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}