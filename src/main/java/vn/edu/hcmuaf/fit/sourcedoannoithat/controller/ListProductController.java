package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
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

        String ajaxRequest = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(ajaxRequest);

        if (isAjax) {
            handleAjaxRequest(request, response);
        } else {
            handleNormalRequest(request, response);
        }
    }

    private void handleAjaxRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Lấy thông tin bộ lọc từ request
        ProductFilterData filterData = extractFilterData(request);

        ProductDao dao = new ProductDao();
        List<Product> productList;
        int count;
        int endPage;

        boolean hasAdvancedFilter = filterData.categoryId > 0 || filterData.subcategoryId > 0 ||
                filterData.minPrice > 0 || filterData.maxPrice > 0 ||
                (filterData.sortBy != null && !filterData.sortBy.trim().isEmpty());

        if (hasAdvancedFilter || (filterData.keyword != null && !filterData.keyword.trim().isEmpty())) {
            productList = dao.getProductsWithAdvancedFilter(filterData.index, filterData.keyword,
                    filterData.categoryId, filterData.subcategoryId, filterData.minPrice,
                    filterData.maxPrice, filterData.sortBy);
            count = dao.countProductsWithAdvancedFilter(filterData.keyword, filterData.categoryId,
                    filterData.subcategoryId, filterData.minPrice, filterData.maxPrice);
        } else {
            if (filterData.keyword != null && !filterData.keyword.trim().isEmpty()) {
                count = dao.countSearchByName(filterData.keyword);
                productList = dao.searchByNamePaging(filterData.keyword, filterData.index);
            } else {
                count = dao.getAllProductCount();
                productList = dao.pagingProduct(filterData.index);
            }
        }

        endPage = count / 6;
        if (count % 6 != 0) {
            endPage++;
        }

        Integer userId = (Integer) request.getSession().getAttribute("userIdLogin");
        List<Integer> favoriteProductIds = null;
        if (userId != null) {
            FavouriteDao favDao = new FavouriteDao();
            favoriteProductIds = favDao.getFavoriteProductIds(userId);
        }

        if ("true".equals(filterData.onlyFavorite) && favoriteProductIds != null) {
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

        // Định dạng số
        NumberFormat formatter = NumberFormat.getNumberInstance(new Locale("vi", "VN"));

        if (productList.isEmpty()) {
            out.println("<div class=\"col-12 text-center\">");
            out.println("    <div style=\"padding: 50px; text-align: center;\">");
            out.println("        <i class=\"fas fa-search\" style=\"font-size: 48px; color: #ccc; margin-bottom: 20px;\"></i>");
            out.println("        <h3 style=\"color: #666;\">Không tìm thấy sản phẩm nào</h3>");
            out.println("        <p style=\"color: #999;\">Vui lòng thử lại với các bộ lọc khác</p>");
            out.println("        <button onclick=\"clearAllFilters()\" class=\"add-to-cart-btn\" style=\"margin-top: 15px;\">");
            out.println("            Xóa bộ lọc");
            out.println("        </button>");
            out.println("    </div>");
            out.println("</div>");
        } else {
            // Hiển thị sản phẩm
            for (Product product : productList) {
                boolean isFavorite = favoriteProductIds != null && favoriteProductIds.contains(product.getId());
                String favoriteClass = isFavorite ? "active" : "";
                String favoriteIcon = isFavorite ? "fa-solid fa-heart" : "fa-regular fa-heart";
                String favoriteTitle = isFavorite ? "Bỏ khỏi yêu thích" : "Thêm vào yêu thích";

                out.println("<div class=\"col-sm-3 p-3 col-md-3\">");
                out.println("    <div class=\"product-block\">");
                out.println("        <div class=\"product-tumb\">");
                out.println("            <span class=\"discount-percent\">-5%</span>");
                out.println("            <a href=\"detail?pId=" + product.getId() + "\">");
                out.println("                <img src=\"" + product.getImg() + "\" alt=\"" + product.getName() + "\" loading=\"lazy\">");
                out.println("            </a>");
                out.println("            <span class=\"favorite-product " + favoriteClass + "\" ");
                out.println("                  title=\"" + favoriteTitle + "\" ");
                out.println("                  data-product-id=\"" + product.getId() + "\">");
                out.println("                <i class=\"" + favoriteIcon + "\"></i>");
                out.println("            </span>");
                out.println("        </div>");
                out.println("        <div class=\"product-detail\">");
                out.println("            <h4>");
                out.println("                <a href=\"detail?pId=" + product.getId() + "\">" + product.getName() + "</a>");
                out.println("            </h4>");
                out.println("            <div class=\"product-rating\">");
                out.println("                <div class=\"stars\">");
                out.println("                    <i class=\"fas fa-star\"></i>");
                out.println("                    <i class=\"fas fa-star\"></i>");
                out.println("                    <i class=\"fas fa-star\"></i>");
                out.println("                    <i class=\"fas fa-star\"></i>");
                out.println("                    <i class=\"fas fa-star\"></i>");
                out.println("                </div>");
                out.println("                <span class=\"rating-count\">(12)</span>");
                out.println("            </div>");
                out.println("            <div class=\"product-bottom_detail\">");
                out.println("                <div class=\"price\">");
                out.println("                    <span class=\"original-price\">");
                out.println("                        " + formatter.format(product.getPrice() * 1.05) + "đ");
                out.println("                    </span>");
                out.println("                    <span class=\"discount-price\">");
                out.println("                        " + formatter.format(product.getPrice()) + "đ");
                out.println("                    </span>");
                out.println("                </div>");
                out.println("                <div class=\"product-actions\">");
                out.println("                    <button class=\"add-to-cart-btn\">");
                out.println("                        <i class=\"fa fa-shopping-cart\"></i> Thêm vào giỏ");
                out.println("                    </button>");
                out.println("                </div>");
                out.println("            </div>");
                out.println("        </div>");
                out.println("    </div>");
                out.println("</div>");
            }
        }
        out.println("<!--PAGINATION_INFO:" + filterData.index + ":" + endPage + ":" + count + "-->");
    }

    private void handleNormalRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        ProductFilterData filterData = extractFilterData(request);

        ProductDao dao = new ProductDao();
        List<Product> productList;
        int count;
        int endPage;

        boolean hasAdvancedFilter = filterData.categoryId > 0 || filterData.subcategoryId > 0 ||
                filterData.minPrice > 0 || filterData.maxPrice > 0 ||
                (filterData.sortBy != null && !filterData.sortBy.trim().isEmpty());

        if (hasAdvancedFilter || (filterData.keyword != null && !filterData.keyword.trim().isEmpty())) {
            productList = dao.getProductsWithAdvancedFilter(filterData.index, filterData.keyword,
                    filterData.categoryId, filterData.subcategoryId, filterData.minPrice,
                    filterData.maxPrice, filterData.sortBy);
            count = dao.countProductsWithAdvancedFilter(filterData.keyword, filterData.categoryId,
                    filterData.subcategoryId, filterData.minPrice, filterData.maxPrice);
        } else {
            if (filterData.keyword != null && !filterData.keyword.trim().isEmpty()) {
                count = dao.countSearchByName(filterData.keyword);
                productList = dao.searchByNamePaging(filterData.keyword, filterData.index);
            } else {
                count = dao.getAllProductCount();
                productList = dao.pagingProduct(filterData.index);
            }
        }

        endPage = count / 6;
        if (count % 6 != 0) {
            endPage++;
        }

        // Lấy danh sách danh mục và danh mục con
        CategoryDAO categoryDao = new CategoryDAO();
        List<Category> categories = categoryDao.getAllCategoriesWithSubcategories();

        // Lấy danh sách sản phẩm yêu thích của người dùng
        Integer userId = (Integer) request.getSession().getAttribute("userIdLogin");
        List<Integer> favoriteProductIds = null;
        if (userId != null) {
            FavouriteDao favDao = new FavouriteDao();
            favoriteProductIds = favDao.getFavoriteProductIds(userId);
        }

        // Lọc chỉ hiển thị sản phẩm yêu thích nếu được yêu cầu
        if ("true".equals(filterData.onlyFavorite) && favoriteProductIds != null) {
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
        request.setAttribute("onlyFavorite", onlyFavorite);
        request.setAttribute("favoriteProductIds", favoriteProductIds);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", filterData.index);
        request.setAttribute("totalProducts", count);
        request.setAttribute("selectedCategoryId", filterData.categoryId > 0 ? filterData.categoryId : null);
        request.setAttribute("selectedSubcategoryId", filterData.subcategoryId > 0 ? filterData.subcategoryId : null);
        request.setAttribute("selectedPriceRanges", filterData.priceRanges);
        request.setAttribute("currentKeyword", filterData.keyword);
        request.setAttribute("currentSortBy", filterData.sortBy);

        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    private ProductFilterData extractFilterData(HttpServletRequest request) {
        ProductFilterData data = new ProductFilterData();

        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }

        data.keyword = request.getParameter("search");
        data.onlyFavorite = request.getParameter("onlyFavorite");
        String categoryIdStr = request.getParameter("categoryId");
        String subcategoryIdStr = request.getParameter("subcategoryId");
        data.sortBy = request.getParameter("sortBy");
        data.priceRanges = request.getParameterValues("price-range");

        // Khởi tạo giá trị mặc định
        data.index = Integer.parseInt(indexPage);
        data.categoryId = 0;
        data.subcategoryId = 0;
        data.minPrice = 0;
        data.maxPrice = 0;

        // Xử lý ID danh mục và danh mục con
        try {
            if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                data.categoryId = Integer.parseInt(categoryIdStr);
            }
            if (subcategoryIdStr != null && !subcategoryIdStr.trim().isEmpty()) {
                data.subcategoryId = Integer.parseInt(subcategoryIdStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // Xử lý khoảng giá từ checkbox
        if (data.priceRanges != null && data.priceRanges.length > 0) {
            double globalMin = Double.MAX_VALUE;
            double globalMax = 0;
            boolean hasOpenRange = false;

            for (String range : data.priceRanges) {
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
                data.minPrice = globalMin;
            }

            if (hasOpenRange) {
                data.maxPrice = Double.MAX_VALUE;
            } else if (globalMax > 0) {
                data.maxPrice = globalMax;
            }
        }

        return data;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        doGet(request, response);
    }

    //     Lớp dữ liệu con hỗ trợ chứa thông tin bộ lọc sản phẩm
    private static class ProductFilterData {
        int index;              // Trang hiện tại
        String keyword;         // Từ khóa tìm kiếm
        String onlyFavorite;    // hiển thị sản phẩm yêu thích
        int categoryId;         // ID danh mục
        int subcategoryId;      // ID danh mục con
        String sortBy;          // Cách sắp xếp
        String[] priceRanges;   // Các khoảng giá được chọn
        double minPrice;        // Giá tối thiểu
        double maxPrice;        // Giá tối đa
    }
}