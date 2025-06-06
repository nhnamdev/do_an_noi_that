package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public boolean deleteProductById(int id) {
        String sql = "DELETE FROM product_shop WHERE id = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }


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
                p.setStock(rs.getInt("stock"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> getAllProduct() {
        List<Product> productList = new ArrayList<Product>();
        String query = "SELECT * FROM product_shop;";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Sử dụng constructor với 6 tham số: id, name, price, image, quantitySold, stock
                productList.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantitySold"),
                        rs.getInt("stock")
                ));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return productList;
    }

    public Product getProductById(String id) {
        String query = "SELECT * FROM product_shop WHERE id=?;";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                // Sử dụng constructor với 6 tham số
                return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantitySold"),
                        rs.getInt("stock")
                );
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }

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
                // Sử dụng constructor với 6 tham số
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantitySold"),
                        rs.getInt("stock")
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
        String query = "SELECT * FROM product_shop ORDER BY id LIMIT 6 OFFSET ?;";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, (index - 1) * 6);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Sử dụng constructor với 6 tham số
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantitySold"),
                        rs.getInt("stock")
                ));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<Product> getProductsWithAdvancedFilter(int index, String keyword, int categoryId,
                                                       int subcategoryId, double minPrice, double maxPrice,
                                                       String sortBy) {
        List<Product> result = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM product_shop WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        // Điều kiện tìm kiếm theo tên
        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append("AND name LIKE ? ");
            params.add("%" + keyword + "%");
        }

        // Lọc theo danh mục
        if (categoryId > 0) {
            query.append("AND category_id = ? ");
            params.add(categoryId);
        }

        // Lọc theo danh mục con
        if (subcategoryId > 0) {
            query.append("AND subcategory_id = ? ");
            params.add(subcategoryId);
        }

        // Lọc theo khoảng giá
        if (minPrice > 0 && maxPrice > 0) {
            if (maxPrice == Double.MAX_VALUE) {
                query.append("AND price >= ? ");
                params.add(minPrice);
            } else {
                query.append("AND price >= ? AND price <= ? ");
                params.add(minPrice);
                params.add(maxPrice);
            }
        } else if (minPrice > 0) {
            query.append("AND price >= ? ");
            params.add(minPrice);
        } else if (maxPrice > 0 && maxPrice != Double.MAX_VALUE) {
            query.append("AND price <= ? ");
            params.add(maxPrice);
        }

        // Sắp xếp
        query.append("ORDER BY ");
        if (sortBy != null && !sortBy.trim().isEmpty()) {
            switch (sortBy.toLowerCase()) {
                case "price_asc":
                    query.append("price ASC ");
                    break;
                case "price_desc":
                    query.append("price DESC ");
                    break;
                case "popular":
                    query.append("quantitySold DESC ");
                    break;
                case "newest":
                    query.append("created_date DESC ");
                    break;
                case "name":
                    query.append("name ASC ");
                    break;
                default:
                    query.append("id ASC ");
            }
        } else {
            query.append("id ASC ");
        }

        // Phân trang
        int offset = (index - 1) * 6;
        query.append("LIMIT 6 OFFSET ?");
        params.add(offset);

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query.toString());

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                // Sử dụng constructor với 6 tham số
                result.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantitySold"),
                        rs.getInt("stock")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return result;
    }

    public int countProductsWithAdvancedFilter(String keyword, int categoryId, int subcategoryId,
                                               double minPrice, double maxPrice) {
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM product_shop WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append("AND name LIKE ? ");
            params.add("%" + keyword + "%");
        }

        if (categoryId > 0) {
            query.append("AND category_id = ? ");
            params.add(categoryId);
        }

        if (subcategoryId > 0) {
            query.append("AND subcategory_id = ? ");
            params.add(subcategoryId);
        }

        if (minPrice > 0 && maxPrice > 0) {
            if (maxPrice == Double.MAX_VALUE) {
                query.append("AND price >= ? ");
                params.add(minPrice);
            } else {
                query.append("AND price >= ? AND price <= ? ");
                params.add(minPrice);
                params.add(maxPrice);
            }
        } else if (minPrice > 0) {
            query.append("AND price >= ? ");
            params.add(minPrice);
        } else if (maxPrice > 0 && maxPrice != Double.MAX_VALUE) {
            query.append("AND price <= ? ");
            params.add(maxPrice);
        }

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return 0;
    }

    public void insertProductWithDetail(String name, double price, int stock, String image,
                                        String description, String material, String brand, String color,
                                        double length, double width, double height, double weight, String feature) {
        String insertProduct = "INSERT INTO product_shop (name, price, image, quantitySold, stock) VALUES (?, ?, ?, 0, ?)";
        String insertDetail = "INSERT INTO product_detail (id, product_describe, material, brand, color, length, width, height, weight, feature) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = new DBConnect().getConnection()) {
            conn.setAutoCommit(false); // Transaction

            // Insert sản phẩm
            PreparedStatement ps = conn.prepareStatement(insertProduct, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setString(3, image);
            ps.setInt(4, stock);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            int productId = 0;
            if (rs.next()) {
                productId = rs.getInt(1);
            }

            // Insert chi tiết
            PreparedStatement detailPs = conn.prepareStatement(insertDetail);
            detailPs.setInt(1, productId);
            detailPs.setString(2, description);
            detailPs.setString(3, material);
            detailPs.setString(4, brand);
            detailPs.setString(5, color);
            detailPs.setDouble(6, length);
            detailPs.setDouble(7, width);
            detailPs.setDouble(8, height);
            detailPs.setDouble(9, weight);
            detailPs.setString(10, feature);
            detailPs.executeUpdate();

            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Không thể thêm sản phẩm mới");
        }
    }

    public void addStockById(int productId, int amount) {
        String sql = "UPDATE product_shop SET stock = stock + ? WHERE id = ?";
        try (Connection conn = new DBConnect().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, amount);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        ProductDao dao = new ProductDao();

        // Dữ liệu test
        String name = "Bàn gỗ sồi tự nhiên";
        double price = 2490000;
        int stock = 15;
        String image = "ban-go-soi.jpg";
        String description = "Bàn làm việc bằng gỗ sồi cao cấp, chống thấm nước và chịu lực tốt.";
        String material = "Gỗ sồi";
        String brand = "NatureWood";
        String color = "Nâu";
        double length = 120.0;
        double width = 60.0;
        double height = 75.0;
        double weight = 25.5;
        String feature = "Thiết kế hiện đại, dễ lau chùi";

        // Gọi hàm insert
        dao.insertProductWithDetail(name, price, stock, image, description,
                material, brand, color, length, width, height, weight, feature);

        System.out.println("✅ Đã thêm sản phẩm test vào CSDL thành công!");


        List<Product> productList = dao.getAllProduct();
        for (Product product : productList) {
            System.out.println(product);
        }
    }
}