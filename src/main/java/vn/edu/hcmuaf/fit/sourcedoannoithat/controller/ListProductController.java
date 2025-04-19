package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.FavouriteDao;
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
        String keyword = request.getParameter("search");
        String onlyFavorite = request.getParameter("onlyFavorite");
        int index = Integer.parseInt(indexPage);
//        chia 6 san pham vao 1 trang
        ProductDao dao = new ProductDao();
        List<Product> productList;
        int count;
        int endPage;

        if (keyword != null && !keyword.trim().isEmpty()) {
            // Nếu có tìm kiếm
            count = dao.countSearchByName(keyword);
            productList = dao.searchByNamePaging(keyword, index);
        } else {
            // Không có tìm kiếm
            count = dao.getAllProductCount();
            productList = dao.pagingProduct(index);
        }

        endPage = count / 6;
        if (count % 6 != 0) {
            endPage++;
        }
        Integer userId = (Integer)request.getSession().getAttribute("userIdLogin");
        List<Integer> favoriteProductIds = null;
        if (userId != null) {
            FavouriteDao favDao = new FavouriteDao();
            favoriteProductIds = favDao.getFavoriteProductIds(userId);
        }
        if ("true".equals(onlyFavorite) && favoriteProductIds != null) {
            List<Integer> finalFavoriteProductIds = favoriteProductIds;
            productList = productList.stream()
                    .filter(product -> finalFavoriteProductIds.contains(product.getId()))
                    .collect(Collectors.toList());
            count = productList.size();
            endPage = count / 6;
            if (count % 6 != 0) {
                endPage++;
            }
        }

        request.setAttribute("listPagination", productList);
        request.setAttribute("endP", endPage);
        request.setAttribute("favoriteProductIds", favoriteProductIds);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
    }
}
