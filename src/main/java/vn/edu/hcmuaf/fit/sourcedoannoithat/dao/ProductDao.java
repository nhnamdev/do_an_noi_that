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

    public List<Product> getTop4BestSellers() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product_shop ORDER BY quantitySold DESC LIMIT 4";

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setImg(rs.getString("image"));
                p.setQuantitySold(rs.getInt("quantitySold"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

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

    public List<Product> searchByNamePaging(String keyword, int index) {
        List<Product> result = new ArrayList<>();
        try {
            int start = (index - 1) * 6;
            String query = "SELECT * FROM product_shop WHERE name LIKE ? LIMIT ?, 6";

            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, start);

            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getString(4),
                        rs.getInt(5)
                );
                result.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int countSearchByName(String keyword) {
        try {
            String query = "SELECT COUNT(*) FROM product_shop WHERE name LIKE ?";
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + keyword + "%");
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        List<Product> productList = dao.getTop4BestSellers();
        for (Product product : productList) {
            System.out.println(product);
        }

    }
}
