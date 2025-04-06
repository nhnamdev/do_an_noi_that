package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Cart;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;

import java.math.BigDecimal;
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
                        rs.getInt(5)
                );
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
