package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ProductDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class ImageProductDao {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public Map<String, List<String>> getMainAndSubImages(String id) {
        Map<String, List<String>> getImages = new HashMap<String, List<String>>();
        List<String> subImages = new ArrayList<>();
        String mainImage = "";
        String mainImageQuery = "SELECT image \n" +
                "FROM product_shop\n" +
                "WHERE id = ?;";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(mainImageQuery);
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                mainImage = rs.getString("image");
            }
            String subImageQuery = "SELECT * \n" +
                    "FROM image_product\n" +
                    "WHERE pid = ?;";
            ps = conn.prepareStatement(subImageQuery);
            ps.setString(1, id);
            rs = ps.executeQuery();

            while (rs.next()) {
                subImages.add(rs.getString("image"));
            }

            getImages.put("mainImage", Arrays.asList(mainImage));
            getImages.put("subImages", subImages);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return getImages;
    }

    public static void main(String[] args) {
        ImageProductDao dao = new ImageProductDao();
        System.out.println(dao.getMainAndSubImages("1"));
    }
}
