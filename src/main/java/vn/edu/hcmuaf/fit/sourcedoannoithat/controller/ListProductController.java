package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;

// phan trang san pham
@WebServlet(name = "ListProductController", value = "/shop")
public class ListProductController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
//        chia 6 san pham vao 1 trang
        ProductDao dao = new ProductDao();
        int count = dao.getAllProductCount();
        int endPage = count / 6;
        if (count % 6 != 0) {
            endPage++;
        }

        List<Product> productList = dao.pagingProduct(index);

        request.setAttribute("listPagination", productList);
        request.setAttribute("endP", endPage);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
    }
}
