package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.AccountManagement;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Profile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

//    public List<Order> getOrderByUserName(int id) {
//        try {
//            String query = "SELECT * FROM order_product WHERE cid=?";
//            conn = new DBConnect().getConnection();
//            ps = conn.prepareStatement(query);
//            ps.setInt(1, id);
//            rs = ps.executeQuery();
//            List<Order> result = new ArrayList<>();
//            while (rs.next()) {
//                Order p = new Order(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getDouble(6), rs.getString(4), rs.getInt(7), rs.getString(8), rs.getString(9));
//                result.add(p);
//            }
//            return result;
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    public List<Order> getListOrder() {
//        try {
//            String query = "SELECT * FROM order_product";
//            conn = new DBConnect().getConnection();
//            ps = conn.prepareStatement(query);
//            rs = ps.executeQuery();
//            List<Order> result = new ArrayList<>();
//            while (rs.next()) {
//                Order p = new Order(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getDouble(6), rs.getString(4), rs.getInt(7), rs.getString(8), rs.getString(9));
//                result.add(p);
//            }
//            return result;
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    public Order getOrderById(int id) {
//        try {
//            String query = "select * from order_product where id = ?";
//            conn = new DBConnect().getConnection();
//            ps = conn.prepareStatement(query);
//            ps.setInt(1, id);
//            rs = ps.executeQuery();
//            if (rs.next()) {
//                Order p = new Order(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getDouble(6), rs.getString(4), rs.getInt(7), rs.getString(8), rs.getString(9));
//                return p;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                if (rs != null) rs.close();
//                if (ps != null) ps.close();
//                if (conn != null) conn.close();
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }
//        return null;
//    }
//
//    public void updatePending(String name, int pid) {
//        String query = "UPDATE order_product SET pending = 1 WHERE name = ? AND id=?";
//        try {
//            conn = new DBConnect().getConnection();
//            PreparedStatement ps = conn.prepareStatement(query);
//            ps.setString(1, name);
//            ps.setInt(2, pid);
//            ps.executeUpdate();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

    // luu order vao database

    public static void main(String[] args) {
        OrderDao orderDao = new OrderDao();
    }
}
