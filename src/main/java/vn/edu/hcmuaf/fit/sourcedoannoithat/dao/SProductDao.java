package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.SProduct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SProductDao {
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public SProduct getSProduct(int id) {
        List<String> images = new ArrayList<>();
        SProduct sp = null;
        try {
            String query = "select * from single_product where id = ?";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                 sp = new SProduct(rs.getString(2),rs.getDouble(3),rs.getString(4),images);
            }
            String queryImages = "SELECT image FROM image_product WHERE pid = ?";
            ps = connection.prepareStatement(queryImages);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                images.add(rs.getString("image"));
            }

            if (sp != null) {
                sp.setImages(images);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return sp;
    }

    public static void main(String[] args) {
        SProductDao sProductDao = new SProductDao();
        System.out.println(sProductDao.getSProduct(1));
    }
}
