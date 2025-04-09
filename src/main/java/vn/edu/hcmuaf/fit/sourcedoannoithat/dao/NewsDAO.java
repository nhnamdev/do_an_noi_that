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
                        rs.getInt("id"),
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
}