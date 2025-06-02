package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardDao {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM profile_client";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM order_product";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public double getTotalSales() {
        String sql = "SELECT SUM(price * quantity) FROM order_product";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getTotalActiveUsers() {
        String sql = "SELECT COUNT(*) FROM profile_client WHERE active = 1";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public static void main(String[] args) {
        DashboardDao dao = new DashboardDao();

        int totalUsers = dao.getTotalUsers();
        int totalOrders = dao.getTotalOrders();
        double totalSales = dao.getTotalSales();
        int activeUsers = dao.getTotalActiveUsers();

        System.out.println("===== THỐNG KÊ HỆ THỐNG =====");
        System.out.println("Tổng số người dùng      : " + totalUsers);
        System.out.println("Tổng số đơn hàng        : " + totalOrders);
        System.out.println("Tổng doanh thu (VND)    : " + totalSales);
        System.out.println("Người dùng đang hoạt động: " + activeUsers);
    }

}
