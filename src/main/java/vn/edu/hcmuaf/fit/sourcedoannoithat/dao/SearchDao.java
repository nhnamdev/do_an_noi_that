package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SearchDao {
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
                        rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getInt(5));
                p.setId(rs.getInt(1));
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
                Product p = new Product(
                        rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getInt(5));
                result.add(p);
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteProduct(int pId) {
        String query = "DELETE FROM product_shop WHERE id = ?";
        try {
            connection = new DBConnect().getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, pId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Product addProduct(Product product) {
        String query = "INSERT INTO product_shop (name, price, image, quantitySold) VALUES (?, ?, ?, ?)";
        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getImg());
            ps.setInt(4, product.getQuantitySold());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return product;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getProductsByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        List<Product> result = new ArrayList<>();
        try {
            String query = "SELECT * FROM product_shop LIMIT ? OFFSET ?";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, pageSize);
            ps.setInt(2, offset);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getInt(5));
                result.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int getTotalProductsBySearch(String search) {
        int total = 0;
        try {
            String query = "SELECT COUNT(*) FROM product_shop WHERE name LIKE ?";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, "%" + search + "%");
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public int getTotalProducts() {
        String query = "SELECT COUNT(*) AS total FROM product_shop";
        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
