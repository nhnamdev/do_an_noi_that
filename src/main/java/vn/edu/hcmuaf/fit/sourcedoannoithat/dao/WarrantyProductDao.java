package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Order;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.WarrantyProduct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class WarrantyProductDao {
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<WarrantyProduct> getListWarrantyProduct() {
        try {
            String query = "SELECT * FROM warranty_product";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            List<WarrantyProduct> listProduct = new ArrayList<>();
            while (rs.next()) {
                WarrantyProduct wp = new WarrantyProduct(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
                listProduct.add(wp);
            }
            return listProduct;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addOrder(String nameProduct,String image,int cid,double price, String name) {
        String query = "INSERT INTO order_product (nameProduct,quantity,image,cid,price,pending,name, dateOrder) VALUES (?,?,?, ?,?, ?,?,DATE(NOW()))";
        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1,nameProduct);
            ps.setInt(2,1);
            ps.setString(3,image);
            ps.setInt(4,cid);
            ps.setDouble(5,price);
            ps.setInt(6, 0);
            ps.setString(7, name);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;

    }

    public boolean createListWarrantyProduct(WarrantyProduct wp) {
        try {
            java.util.Date currentDate = new java.util.Date();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(currentDate);
            calendar.add(Calendar.YEAR, 1);
            java.util.Date expiryDate = calendar.getTime();

            java.sql.Date sqlWarrantyDate = new java.sql.Date(currentDate.getTime());
            java.sql.Date sqlExpiryDate = new java.sql.Date(expiryDate.getTime());
            String status = currentDate.before(expiryDate) ? "Còn bảo hành" : "Hết bảo hành";

            String query = "INSERT INTO warranty_product(email,name,warrantyDate,warrantyExpiryDate,status) VALUES(?,?,?,?,?)";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, wp.getEmail());
            ps.setString(2, wp.getName());
            ps.setDate(3, sqlWarrantyDate);
            ps.setDate(4, sqlExpiryDate);
            ps.setString(5, status);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        WarrantyProductDao dao = new WarrantyProductDao();
        WarrantyProduct wp = new WarrantyProduct("hominhhai2k4@gmail.com", "Ghế bố", "", "", "");
    }
}
