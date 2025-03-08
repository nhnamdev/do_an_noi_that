
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
            String productId = request.getParameter("productId");
            String userId = request.getSession().getAttribute("userIdLogin") == null ? null : request.getSession().getAttribute("userIdLogin").toString();

            if (userId == null) {
                out.write("{\"success\": false, \"message\": \"User not logged in\"}");
                return;
            }

            // delete if exist
            if (deleteFavourite(userId, productId)) {
                out.write("{\"success\": true, \"message\": \"Favourite successfully deleted\"}");
                return;
            }

            Connection conn = new DBConnect().getConnection();
            PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO user_favourite (user_id, product_id) VALUES (?, ?)"
            );
            stmt.setString(1, userId);
            stmt.setString(2, productId);
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                out.write("{\"Đã thêm sản phẩm yêu thích\": true}");
            } else {
                out.write("{\"success\": false}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }


    public boolean deleteFavourite(String userId, String productId) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            String query = "DELETE FROM user_favourite WHERE user_id = ? AND product_id = ?";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, userId);
            ps.setString(2, productId);

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
