package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Contact;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.ReturnProduct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReturnProductDao {
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public boolean insertReturnProduct(ReturnProduct returnProduct) {
        String query = "INSERT INTO return_product (status, imageLink, pid, purchaseDate, reason, decription) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, returnProduct.getStatus());
            ps.setString(2, returnProduct.getImageLink());
            ps.setInt(3, returnProduct.getOrderCode());
            ps.setString(4, returnProduct.getPurchaseDate());
            ps.setString(5, returnProduct.getReason());
            ps.setString(6, returnProduct.getDescription());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<ReturnProduct> getReturnProduct() {
        try {
            String query = "SELECT * FROM return_product";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            List<ReturnProduct> listRd = new ArrayList<>();
            while (rs.next()) {
                ReturnProduct returnProduct = new ReturnProduct(rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7));
                listRd.add(returnProduct);
            }
            return listRd;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
