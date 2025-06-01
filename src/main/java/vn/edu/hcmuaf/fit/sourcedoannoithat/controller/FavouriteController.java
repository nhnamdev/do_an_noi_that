
package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/addToFavorites")
public class FavouriteController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            String productIdStr = request.getParameter("productId");
            Integer productId = null;
            Integer userId = (Integer)request.getSession().getAttribute("userIdLogin");
            if (productIdStr != null && !productIdStr.trim().isEmpty()) {
                try {
                    productId = Integer.parseInt(productIdStr.trim());
                } catch (NumberFormatException e) {
                    out.write("{\"success\": false, \"message\": \"productId không hợp lệ: " + productIdStr + "\"}");
                    return;
                }
            } else {
                out.write("{\"success\": false, \"message\": \"Thiếu hoặc rỗng productId\"}");
                return;
            }
            if (userId == null) {
                out.write("{\"success\": false, \"message\": \"User not logged in\"}");
                return;
            }

            // delete if exist
            if (deleteFavourite(userId, productId)) {
                out.write("{\"success\": true, \"action\": \"deleted\", \"message\": \"Đã bỏ yêu thích\"}");
                return;
            }

            Connection conn = new DBConnect().getConnection();
            PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO user_favourite (user_id, product_id) VALUES (?, ?)"
            );
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                out.write("{\"success\": true, \"action\": \"added\", \"message\": \"Đã thêm yêu thích\"}");
            } else {
                out.write("{\"success\": false, \"message\": \"Thêm yêu thích thất bại\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }


    public boolean deleteFavourite(int userId, int productId) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            String query = "DELETE FROM user_favourite WHERE user_id = ? AND product_id = ?";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, productId);

            int affectedRows = ps.executeUpdate(); // Trả về số dòng bị ảnh hưởng
            return affectedRows > 0; // Nếu có dòng bị xóa, trả về true
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
