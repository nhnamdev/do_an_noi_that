package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ProductDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DetailDao {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public ProductDetail getProductDetail(String id) {
        String query = "SELECT * \n" +
                "FROM product_detail\n" +
                "WHERE id=?;";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                //table product_detail (db 29-5.txt) chỉ có 11 thuộc tính(không có weight) => lỗi 500 đã fix
                return new ProductDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getInt(8),
                        rs.getInt(9),
                        rs.getInt(10),
                        rs.getString(11),
                        rs.getString(12));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public static void main(String[] args) {
        DetailDao dao = new DetailDao();
        ProductDetail detail = dao.getProductDetail("1");
        System.out.println(detail);
    }
}
