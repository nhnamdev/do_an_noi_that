package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.*;

import java.sql.*;
import java.time.LocalDateTime;
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
    public int insertOrder(Invoice invoice) {
        String sql = "insert into invoice(order_id,total_amount,discount_amount,final_amount,payment_method_id,voucher_id,issue_date,status,payment_date,transaction_code) values(?,?,?,?,?,?,?,?,?,?)";
        try {
            conn = new DBConnect().getConnection();
            PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            Timestamp currentTimestamp = Timestamp.valueOf(LocalDateTime.now());
            st.setInt(1, 4);
            st.setInt(2, invoice.getFinalAmount());
            st.setInt(3, invoice.getDiscount());
            st.setInt(4, invoice.getFinalAmount());
            st.setInt(5, 2);
            st.setNull(6, java.sql.Types.INTEGER);
            st.setTimestamp(7, currentTimestamp);
            st.setString(8,"waiting...");
            st.setNull(9, Types.TIMESTAMP);
            st.setNull(10,Types.VARCHAR);
            st.executeUpdate();
            try (ResultSet generatedKeys = st.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Thêm thất bại");
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean updateOrderStatus(Invoice invoice) {
        String sql = "update invoice set status=?, payment_date = ?, transaction_code = ? where invoice_id=?";
        try {
            conn = new DBConnect().getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, invoice.getStatus());
            st.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            st.setString(3,invoice.getTransactionCode());
            st.setInt(4, invoice.getId());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        OrderDao orderDao = new OrderDao();
        Invoice invoice = new Invoice();
        invoice.setFinalAmount(20000);
        invoice.setDiscount(0);
        System.out.println(orderDao.insertOrder(invoice));
    }
}
