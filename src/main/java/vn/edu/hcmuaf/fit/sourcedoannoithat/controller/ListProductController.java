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

// phan trang san pham
@WebServlet(name = "ListProductController", value = "/shop")
public class ListProductController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        // === THAY ĐỔI 1: LẤY THÊM CÁC THAM SỐ LỌC MỚI ===
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        String keyword = request.getParameter("search");
        String onlyFavorite = request.getParameter("onlyFavorite");

        // Thêm các tham số filter mới
        String categoryIdStr = request.getParameter("categoryId");
        String subcategoryIdStr = request.getParameter("subcategoryId");
        String sortBy = request.getParameter("sortBy");
        String[] priceRanges = request.getParameterValues("price-range");

        int index = Integer.parseInt(indexPage);

        // === THAY ĐỔI 2: PARSE CÁC THAM SỐ FILTER ===
        int categoryId = 0;
        int subcategoryId = 0;
        double minPrice = 0;
        double maxPrice = 0;

        // Parse category và subcategory
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

        // Parse price ranges từ checkbox
        if (priceRanges != null && priceRanges.length > 0) {
            double tempMin = Double.MAX_VALUE;
            double tempMax = 0;

            for (String range : priceRanges) {
                switch (range) {
                    case "0-1m":
                        tempMin = Math.min(tempMin, 0);
                        tempMax = Math.max(tempMax, 1000000);
                        break;
                    case "1m-2m":
                        tempMin = Math.min(tempMin, 1000000);
                        tempMax = Math.max(tempMax, 2000000);
                        break;
                    case "2m-3m":
                        tempMin = Math.min(tempMin, 2000000);
                        tempMax = Math.max(tempMax, 3000000);
                        break;
                    case "3m-5m":
                        tempMin = Math.min(tempMin, 3000000);
                        tempMax = Math.max(tempMax, 5000000);
                        break;
                    case "5m+":
                        tempMin = Math.min(tempMin, 5000000);
                        tempMax = Double.MAX_VALUE;
                        break;
                }
            }

            if (tempMin != Double.MAX_VALUE) {
                minPrice = tempMin;
            }
            if (tempMax != 0 && tempMax != Double.MAX_VALUE) {
                maxPrice = tempMax;
            }
        }

        // === THAY ĐỔI 3: SỬ DỤNG PHƯƠNG THỨC FILTER MỚI ===
        ProductDao dao = new ProductDao();
        List<Product> productList;
        int count;
        int endPage;

        // Kiểm tra có filter nào không
        boolean hasAdvancedFilter = categoryId > 0 || subcategoryId > 0 ||
                minPrice > 0 || maxPrice > 0 ||
                (sortBy != null && !sortBy.trim().isEmpty());

        if (hasAdvancedFilter || (keyword != null && !keyword.trim().isEmpty())) {
            // Sử dụng phương thức filter nâng cao
            productList = dao.getProductsWithAdvancedFilter(index, keyword, categoryId,
                    subcategoryId, minPrice, maxPrice, sortBy);
            count = dao.countProductsWithAdvancedFilter(keyword, categoryId, subcategoryId,
                    minPrice, maxPrice);
        } else {
            // Sử dụng phương thức cũ khi không có filter
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

        // Xử lý yêu thích (giữ nguyên)
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
