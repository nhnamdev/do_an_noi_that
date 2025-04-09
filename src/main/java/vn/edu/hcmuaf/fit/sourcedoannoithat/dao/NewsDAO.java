package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.News;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class NewsDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<News> getAllNews() {
        List<News> newsList = new ArrayList<>();
        String query = "SELECT * FROM news ORDER BY created_at DESC";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                newsList.add(new News(
                        rs.getInt("news_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("content"),
                        rs.getString("image"),
                        rs.getDate("created_at"),
                        rs.getInt("category_id")
                ));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return newsList;
    }

    public void insertNews(String title, String description, String content, String image, int categoryId) {
        String query = "INSERT INTO news (title, description, content, image, created_at, category_id) " +
                "VALUES (?, ?, ?, ?, CURDATE(), ?)";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, content);
            ps.setString(4, image);
            ps.setInt(5, categoryId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public News getNewsByID(int id) {
        String query = "SELECT * FROM news WHERE news_id = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new News(
                        rs.getInt("news_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("content"),
                        rs.getString("image"),
                        rs.getDate("created_at"),
                        rs.getInt("category_id")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        NewsDAO dao = new NewsDAO();
        List<News> listNew = dao.getAllNews();

        for (News news : listNew) {
            System.out.println(news);
        }
    }
}