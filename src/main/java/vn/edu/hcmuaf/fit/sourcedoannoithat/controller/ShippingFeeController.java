package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.service.GHNService;

@WebServlet(name = "ShippingFeeController", value = "/api/*")
public class ShippingFeeController extends HttpServlet {
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
    }
}
