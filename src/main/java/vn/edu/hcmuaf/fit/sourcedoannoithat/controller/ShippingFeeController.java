package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONArray;
import org.json.JSONObject;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.DetailDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.CartDisplayItem;
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
                case "/shippingFee":
                    String toDistrictId = request.getParameter("to_district_id");
                    String toWardCode = request.getParameter("to_ward_code");

                    if (toDistrictId == null || toWardCode == null) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        out.print("{\"code\": 400, \"message\": \"Missing required parameters\"}");
                        return;
                    }
//                    lay thong tin gio hang
                    HttpSession session = request.getSession();
                    HashMap<String, CartDisplayItem> cart = (HashMap<String, CartDisplayItem>) session.getAttribute("cart");

                    if (cart == null || cart.isEmpty()) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        out.print("{\"code\": 400, \"message\": \"Cart is empty\"}");
                        return;
                    }

                    // Tính tổng trọng lượng, kích thước lớn nhất
                    int totalWeight = 0;
                    int maxLength = 0;
                    int maxWidth = 0;
                    int maxHeight = 0;

                    JSONArray items = new JSONArray();

                    for (CartDisplayItem item : cart.values()) {
                        Product product = item.getProduct();
                        ProductDetail productDetail = item.getProductDetail();
                        int quantity = item.getQuantity();

//                        lay ra chi tiet san pham, sau do cong don so kg cua san pham trong gio hang
                        if (productDetail != null) {
                            int weight = productDetail.getWeight();
                            int length = productDetail.getLength();
                            int width = productDetail.getWidth();
                            int height = productDetail.getHeight();

                            // Cập nhật tổng trọng lượng
                            totalWeight += weight * quantity;

                            // Cập nhật kích thước lớn nhất
                            maxLength = Math.max(maxLength, length);
                            maxWidth = Math.max(maxWidth, width);
                            maxHeight = Math.max(maxHeight, height);

                            // Thêm sản phẩm vào mảng
                            JSONObject itemObj = new JSONObject();
                            itemObj.put("name", product.getName());
                            itemObj.put("code", product.getId());
                            itemObj.put("quantity", quantity);
                            itemObj.put("weight", weight);
                            itemObj.put("length", length);
                            itemObj.put("width", width);
                            itemObj.put("height", height);
                            items.put(itemObj);
                        }
                    }

                    // Tạo JSON để gửi API GHN
                    JSONObject requestData = new JSONObject();
                    requestData.put("to_district_id", Integer.parseInt(toDistrictId));
                    requestData.put("to_ward_code", toWardCode);
                    requestData.put("weight", totalWeight);
                    requestData.put("length", maxLength);
                    requestData.put("width", maxWidth);
                    requestData.put("height", maxHeight);
                    requestData.put("service_type_id", 2); //2 cho ship thuong, 5 cho ship nang, cai nay tinh sau hihi
                    requestData.put("items", items);

                    // call API GHN
                    String result = GHNService.calculateShippingFee(
                            Integer.parseInt(toDistrictId), toWardCode,
                            totalWeight, maxLength, maxWidth, maxHeight

                    );
                    out.print(result);
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
    }
}
