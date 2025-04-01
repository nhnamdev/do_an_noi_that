package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Product> getAllProduct() {
        List<Product> productList = new ArrayList<Product>();
        String query = "SELECT * \n" +
                "FROM product_shop;";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(new Product(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getString(4),
                        rs.getInt(5)
                ));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return productList;
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

    //phan trang
    public int getAllProductCount() {
        String query = "SELECT COUNT(*) FROM product_shop;";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public List<Product> pagingProduct(int index) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT *\n" +
                "FROM product_shop\n" +
                "ORDER BY id \n" +
                "LIMIT 6 OFFSET ?;";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, (index - 1) * 6);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getString(4),
                        rs.getInt(5))
                );
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public static void main(String[] args) {
        ProductDao dao = new ProductDao();
        List<Product> productList = dao.getAllProduct();
        for (Product product : productList) {
            System.out.println(product);
        }
        System.out.println(dao.getProductById("1"));
        int count = dao.getAllProductCount();
        System.out.println(count);

        List<Product> productList2 = dao.pagingProduct(2);
        for (Product product : productList2) {
            System.out.println(product);
        }
    }
}
