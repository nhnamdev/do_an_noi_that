
package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FavouriteDao {
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Product> searchProducts(String keyword) {
        try {
            String query = "SELECT * FROM product_shop WHERE name LIKE ?";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, "%" + keyword + "%");
            rs = ps.executeQuery();
            List<Product> result = new ArrayList<>();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getString(4),
                        rs.getInt(5), rs.getInt(6));
                result.add(p);
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;


    }

    public List<Product> getAllProducts() {
        try {
            String query = "SELECT * FROM product_shop";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            List<Product> result = new ArrayList<>();
            while (rs.next()) {
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getInt(5), rs.getInt(6));
                result.add(p);
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;


    }

    public List<Product> getFavoriteProducts(int userId) {
        List<Product> favorites = new ArrayList<>();
        try {
            String query = "SELECT p.* FROM product_shop p " +
                    "INNER JOIN user_favourite f ON p.id = f.product_id " +
                    "WHERE f.user_id = ?";

            try {
                connection = new DBConnect().getConnection();
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            try {
                ps = connection.prepareStatement(query);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt(1),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantitySold"),
                        rs.getInt("stock")
                );
                product.setId(rs.getInt("id"));
                favorites.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return favorites;
    }

    public boolean toggleFavorite(int userId, int productId) {
        boolean isFavorite = checkIfFavorite(userId, productId);
        try {
            String query;
            if (isFavorite) {
                query = "DELETE FROM user_favourite WHERE user_id = ? AND product_id = ?";
            } else {
                query = "INSERT INTO user_favourite (user_id, product_id) VALUES (?, ?)";
            }

            try {
                connection = new DBConnect().getConnection();
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, productId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkIfFavorite(int userId, int productId) {
        try {
            String query = "SELECT COUNT(*) FROM user_favourite WHERE user_id = ? AND product_id = ?";
            try {
                connection = new DBConnect().getConnection();
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public List<Integer> getFavoriteProductIds(int userId) {
        List<Integer> favoriteProductIds = new ArrayList<>();
        try {
            Connection conn = new DBConnect().getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT product_id FROM user_favourite WHERE user_id = ?");
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                favoriteProductIds.add(rs.getInt("product_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return favoriteProductIds;
    }


}
