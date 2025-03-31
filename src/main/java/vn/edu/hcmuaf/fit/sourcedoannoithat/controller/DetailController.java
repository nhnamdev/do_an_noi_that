package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.DetailDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ImageProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ProductDetail;

@WebServlet(name = "DetailController", value = "/detail")
public class DetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String id = request.getParameter("pId");

        // lay ra thong tin san pham
        ProductDao productDao = new ProductDao();
        Product product = productDao.getProductById(id);

        // lay ra thong tin chi tiet san pham
        DetailDao dao = new DetailDao();
        ProductDetail detail = dao.getProductDetail(id);

        // lay ra hinh anh cua san pham
        ImageProductDao imageDao = new ImageProductDao();
        Map<String, List<String>> productImages = imageDao.getMainAndSubImages(id);

        String mainImage = "";
        if (!productImages.get("mainImage").isEmpty()) {
            mainImage = productImages.get("mainImage").get(0);
        }
        List<String> subImages = productImages.get("subImages");

        request.setAttribute("product", product);
        request.setAttribute("detail", detail);
        request.setAttribute("mainImage", mainImage);
        request.setAttribute("subImages", subImages);

        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
    }
}
