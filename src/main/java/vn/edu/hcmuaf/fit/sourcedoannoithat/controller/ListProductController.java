package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.FavouriteDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.CategoryDAO.CategoryDAO;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.categories.Category;

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
        String categoryIdStr = request.getParameter("categoryId");
        String subcategoryIdStr = request.getParameter("subcategoryId");
        String sortBy = request.getParameter("sortBy");
        String[] priceRanges = request.getParameterValues("price-range");

        int index = Integer.parseInt(indexPage);
        int categoryId = 0;
        int subcategoryId = 0;
        double minPrice = 0;
        double maxPrice = 0;

        // truyền tham số id của category và subcategory
        try {
            if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                categoryId = Integer.parseInt(categoryIdStr);
            }
            if (subcategoryIdStr != null && !subcategoryIdStr.trim().isEmpty()) {
                subcategoryId = Integer.parseInt(subcategoryIdStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // truyền price ranges từ checkbox qua
        if (priceRanges != null && priceRanges.length > 0) {
            double globalMin = Double.MAX_VALUE;
            double globalMax = 0;
            boolean hasOpenRange = false;

            for (String range : priceRanges) {
                switch (range) {
                    case "0-1m":
                        globalMin = Math.min(globalMin, 0);
                        globalMax = Math.max(globalMax, 1000000);
                        break;
                    case "1m-2m":
                        globalMin = Math.min(globalMin, 1000000);
                        globalMax = Math.max(globalMax, 2000000);
                        break;
                    case "2m-3m":
                        globalMin = Math.min(globalMin, 2000000);
                        globalMax = Math.max(globalMax, 3000000);
                        break;
                    case "3m-5m":
                        globalMin = Math.min(globalMin, 3000000);
                        globalMax = Math.max(globalMax, 5000000);
                        break;
                    case "5m+":
                        globalMin = Math.min(globalMin, 5000000);
                        hasOpenRange = true;
                        break;
                }
            }

            if (globalMin != Double.MAX_VALUE) {
                minPrice = globalMin;
            }

            if (hasOpenRange) {
                maxPrice = Double.MAX_VALUE;
            } else if (globalMax > 0) {
                maxPrice = globalMax;
            }
        }

        ProductDao dao = new ProductDao();
        List<Product> productList;
        int count;
        int endPage;

        boolean hasAdvancedFilter = categoryId > 0 || subcategoryId > 0 ||
                minPrice > 0 || maxPrice > 0 ||
                (sortBy != null && !sortBy.trim().isEmpty());

        if (hasAdvancedFilter || (keyword != null && !keyword.trim().isEmpty())) {
            productList = dao.getProductsWithAdvancedFilter(index, keyword, categoryId,
                    subcategoryId, minPrice, maxPrice, sortBy);
            count = dao.countProductsWithAdvancedFilter(keyword, categoryId, subcategoryId,
                    minPrice, maxPrice);
        } else {
            if (keyword != null && !keyword.trim().isEmpty()) {
                count = dao.countSearchByName(keyword);
                productList = dao.searchByNamePaging(keyword, index);
            } else {
                count = dao.getAllProductCount();
                productList = dao.pagingProduct(index);
            }
        }

        endPage = count / 6;
        if (count % 6 != 0) {
            endPage++;
        }

        CategoryDAO categoryDao = new CategoryDAO();
        List<Category> categories = categoryDao.getAllCategoriesWithSubcategories();

        Integer userId = (Integer) request.getSession().getAttribute("userIdLogin");
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
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", index);
        request.setAttribute("totalProducts", count);
        request.setAttribute("selectedCategoryId", categoryId > 0 ? categoryId : null);
        request.setAttribute("selectedSubcategoryId", subcategoryId > 0 ? subcategoryId : null);
        request.setAttribute("selectedPriceRanges", priceRanges);
        request.setAttribute("currentKeyword", keyword);
        request.setAttribute("currentSortBy", sortBy);

        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        doGet(request, response);
    }
}