package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.CategoryDAO;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.categories.Category;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.categories.Subcategory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> getAllCategoriesWithSubcategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT c.category_id, c.category_name, c.category_code, " +
                "c.display_order, c.is_active, c.created_at, " +
                "s.subcategory_id, s.subcategory_name, s.subcategory_code, " +
                "s.display_order as sub_display_order, s.is_active as sub_is_active, " +
                "s.created_at as sub_created_at " +
                "FROM categories c " +
                "LEFT JOIN subcategories s ON c.category_id = s.category_id " +
                "WHERE c.is_active = true " +
                "ORDER BY c.display_order, s.display_order";

        try (Connection conn = new DBConnect().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            Category currentCategory = null;

            while (rs.next()) {
                int categoryId = rs.getInt("category_id");

                // Nếu là category mới
                if (currentCategory == null || currentCategory.getCategoryId() != categoryId) {
                    currentCategory = new Category();
                    currentCategory.setCategoryId(categoryId);
                    currentCategory.setCategoryName(rs.getString("category_name"));
                    currentCategory.setCategoryCode(rs.getString("category_code"));
                    currentCategory.setDisplayOrder(rs.getInt("display_order"));
                    currentCategory.setActive(rs.getBoolean("is_active"));
                    currentCategory.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    currentCategory.setSubcategories(new ArrayList<>());
                    categories.add(currentCategory);
                }

                // Thêm subcategory nếu có
                if (rs.getInt("subcategory_id") > 0) {
                    Subcategory subcategory = new Subcategory();
                    subcategory.setSubcategoryId(rs.getInt("subcategory_id"));
                    subcategory.setSubcategoryName(rs.getString("subcategory_name"));
                    subcategory.setSubcategoryCode(rs.getString("subcategory_code"));
                    subcategory.setCategoryId(categoryId);
                    subcategory.setDisplayOrder(rs.getInt("sub_display_order"));
                    subcategory.setActive(rs.getBoolean("sub_is_active"));
                    subcategory.setCreatedAt(rs.getTimestamp("sub_created_at").toLocalDateTime());
                    currentCategory.getSubcategories().add(subcategory);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return categories;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM categories WHERE is_active = true ORDER BY display_order";

        try (Connection conn = new DBConnect().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setCategoryCode(rs.getString("category_code"));
                category.setDisplayOrder(rs.getInt("display_order"));
                category.setActive(rs.getBoolean("is_active"));
                category.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }

    public List<Subcategory> getSubcategoriesByCategoryId(int categoryId) {
        List<Subcategory> subcategories = new ArrayList<>();
        String sql = "SELECT * FROM subcategories WHERE category_id = ? AND is_active = true ORDER BY display_order";

        try (Connection conn = new DBConnect().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Subcategory subcategory = new Subcategory();
                subcategory.setSubcategoryId(rs.getInt("subcategory_id"));
                subcategory.setSubcategoryName(rs.getString("subcategory_name"));
                subcategory.setSubcategoryCode(rs.getString("subcategory_code"));
                subcategory.setCategoryId(rs.getInt("category_id"));
                subcategory.setDisplayOrder(rs.getInt("display_order"));
                subcategory.setActive(rs.getBoolean("is_active"));
                subcategory.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                subcategories.add(subcategory);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return subcategories;
    }

    public Category getCategoryById(int categoryId) {
        String sql = "SELECT * FROM categories WHERE category_id = ? AND is_active = true";

        try (Connection conn = new DBConnect().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setCategoryCode(rs.getString("category_code"));
                category.setDisplayOrder(rs.getInt("display_order"));
                category.setActive(rs.getBoolean("is_active"));
                category.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                return category;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public Subcategory getSubcategoryById(int subcategoryId) {
        String sql = "SELECT * FROM subcategories WHERE subcategory_id = ? AND is_active = true";

        try (Connection conn = new DBConnect().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, subcategoryId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Subcategory subcategory = new Subcategory();
                subcategory.setSubcategoryId(rs.getInt("subcategory_id"));
                subcategory.setSubcategoryName(rs.getString("subcategory_name"));
                subcategory.setSubcategoryCode(rs.getString("subcategory_code"));
                subcategory.setCategoryId(rs.getInt("category_id"));
                subcategory.setDisplayOrder(rs.getInt("display_order"));
                subcategory.setActive(rs.getBoolean("is_active"));
                subcategory.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                return subcategory;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCategories();
        for (Category category : categories) {
            System.out.println(category.getCategoryName());
        }
    }
}
