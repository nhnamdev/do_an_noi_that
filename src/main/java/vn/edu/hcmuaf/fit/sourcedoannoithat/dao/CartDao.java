package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Cart;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

// xu li gio hang cua ng dung, luu gio hang cua nguoi dung ve db voi user id tuong ung
public class CartDao {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // phuong thuc them hoac cap nhat so luong san pham trong gio hang
    public boolean addOrUpdateCartItem(int userID, int productID, int quantity) {
//        kiem tra coi san pham nay da co trong gio hang hay chua
        String query = "SELECT *\n" +
                "FROM cart\n" +
                "WHERE user_id = ?\n" +
                "AND product_id = ?;";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userID);
            ps.setInt(2, productID);
            rs = ps.executeQuery();
//            neu san pham da ton tai, cap nhat so luong
            if (rs.next()) {
                String updateQuery = "UPDATE cart\n" +
                        "SET quantity = ?\n" +
                        "WHERE user_id = ?\n" +
                        "AND product_id = ?;";
                ps = conn.prepareStatement(updateQuery);
                ps.setInt(1, quantity);
                ps.setInt(2, userID);
                ps.setInt(3, productID);

                return ps.executeUpdate() > 0;
            } else {
                String insertQuery = "INSERT INTO `cart`(user_id, product_id, quantity) \n" +
                        "VALUES (?, ?, ?);";
                ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, userID);
                ps.setInt(2, productID);
                ps.setInt(3, quantity);

                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Cart> getCartItems(int userID) {
        List<Cart> carts = new ArrayList<Cart>();
        String query = "SELECT *\n" +
                "FROM cart\n" +
                "WHERE user_id = ?;";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userID);
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                int productID = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");

                Cart cartItem = new Cart(userID, productID, quantity);
                cartItem.setId(id);
                carts.add(cartItem);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return carts;
    }

    public Product getProductById(String id) {
        String query = "SELECT * \n" +
                "FROM product_shop\n" +
                "WHERE id=?;";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getInt(6)
                );
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }
    public boolean clearCartByUserId(int userId) {
        String query = "DELETE FROM cart WHERE user_id = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Xóa một sản phẩm cụ thể khỏi giỏ hàng
     */
    public boolean removeCartItem(int userId, int productId) {
        String query = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, productId);

            int rowsAffected = ps.executeUpdate();
            System.out.println("DEBUG CartDao: Removed product " + productId + " from cart for user " + userId);
            return rowsAffected > 0;

        } catch (Exception e) {
            System.out.println("DEBUG CartDao: Error removing cart item - " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Xóa các sản phẩm cụ thể khỏi giỏ hàng (cho trường hợp mua ngay với nhiều sản phẩm)
     */
    public boolean removeCartItems(int userId, List<Integer> productIds) {
        if (productIds == null || productIds.isEmpty()) {
            return true;
        }

        StringBuilder query = new StringBuilder("DELETE FROM cart WHERE user_id = ? AND product_id IN (");
        for (int i = 0; i < productIds.size(); i++) {
            query.append("?");
            if (i < productIds.size() - 1) {
                query.append(",");
            }
        }
        query.append(")");

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query.toString());
            ps.setInt(1, userId);

            for (int i = 0; i < productIds.size(); i++) {
                ps.setInt(i + 2, productIds.get(i));
            }

            int rowsAffected = ps.executeUpdate();
            System.out.println("DEBUG CartDao: Removed " + rowsAffected + " specific items from cart for user " + userId);
            return rowsAffected > 0;

        } catch (Exception e) {
            System.out.println("DEBUG CartDao: Error removing specific cart items - " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        CartDao cartDao = new CartDao();
        System.out.println(cartDao.addOrUpdateCartItem(3, 4, 2));
    }
}
