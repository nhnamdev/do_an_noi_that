package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.DetailDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ProductDetail;
import vn.edu.hcmuaf.fit.sourcedoannoithat.service.GHNService;

@WebServlet(name = "ShippingFeeController", value = "/api/*")
public class ShippingFeeController extends HttpServlet {
    private DetailDao detail;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getPathInfo();
        PrintWriter out = response.getWriter();

        try {
            switch (action) {
                case "/provinces":
                    out.print(GHNService.getProvinces());
                    break;
                case "/districts":
                    String provinceId = request.getParameter("province_id");
                    if (provinceId == null || provinceId.isEmpty()) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        out.print("{\"code\": 400, \"message\": \"Missing province_id parameter\"}");
                        return;
                    }
                    out.print(GHNService.getDistricts(provinceId));
                    break;
                case "/wards":
                    String districtId = request.getParameter("district_id");
                    if (districtId == null || districtId.isEmpty()) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        out.print("{\"code\": 400, \"message\": \"Missing district_id parameter\"}");
                        return;
                    }
                    out.print(GHNService.getWards(districtId));
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"code\": 500, \"message\": \"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getPathInfo();
        PrintWriter out = response.getWriter();

        try {
            if ("/calculate-fee".equals(action)) {
                // Đọc dữ liệu từ request
                BufferedReader reader = request.getReader();
                StringBuilder jsonBody = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonBody.append(line);
                }

                // Parse JSON từ request
                // (Sử dụng thư viện JSON như Gson hoặc org.json)
                // Đây là ví dụ, bạn cần thêm thư viện xử lý JSON vào project

                // Giả sử dữ liệu từ client
                String productId = "1"; // Lấy productId từ JSON
                int fromDistrictId = -1; // Lấy fromDistrictId từ JSON
                String fromWardCode = ""; // Lấy fromWardCode từ JSON
                int toDistrictId = -1; // Lấy toDistrictId từ JSON
                String toWardCode = ""; // Lấy toWardCode từ JSON

                // Lấy thông tin sản phẩm từ database dựa vào productId
                ProductDetail product = detail.getProductDetail(productId);

                // Gọi API GHN để tính phí vận chuyển
                String result = GHNService.calculateShippingFee(
                        fromDistrictId, fromWardCode,
                        toDistrictId, toWardCode,
                        product.getWeight(),
                        product.getLength(),
                        product.getWidth(),
                        product.getHeight()
                );

                out.print(result);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"code\": 500, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}
