package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Invoice;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.PaymentHistory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PaymentHistoryDao {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<PaymentHistory> getAllPaymentHistory() {
        List<PaymentHistory> list = new ArrayList<>();
        String query = "SELECT ph.*, pc.name AS user_name\n" +
                "FROM payment_history ph\n" +
                "JOIN profile_client pc ON ph.user_id = pc.id\n" +
                "ORDER BY ph.payment_time DESC";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                PaymentHistory ph = new PaymentHistory();
                ph.setHistoryId(rs.getInt("history_id"));
                ph.setInvoiceId(rs.getInt("invoice_id"));
                ph.setUserId(rs.getInt("user_id"));
                ph.setAmountPaid(rs.getDouble("amount_paid"));
                ph.setPaymentTime(rs.getTimestamp("payment_time").toString());
                ph.setPaymentMethodId(rs.getInt("payment_method_id"));
                ph.setStatus(rs.getString("status"));
                ph.setTransactionCode(rs.getString("transaction_code"));
                ph.setUserName(rs.getString("user_name"));
                list.add(ph);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }
    public List<Invoice> getAllPaymentInvoice() {
        List<Invoice> list = new ArrayList<>();
        String query = "SELECT i.*, pc.name AS user_name " +
                "FROM invoice i " +
                "JOIN order_product o ON i.order_id = o.order_id " +
                "JOIN profile_client pc ON o.user_id = pc.id " +
                "WHERE i.status = 'success' " +  // Thanh toan thanh cong moi get
                "ORDER BY i.issue_date DESC";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setId(rs.getInt("invoice_id"));
                invoice.setOrderId(rs.getInt("order_id"));
                invoice.setTotal(rs.getInt("total_amount"));
                invoice.setDiscount(rs.getInt("discount_amount"));
                invoice.setFinalAmount(rs.getInt("final_amount"));
                invoice.setPaymentMethod(rs.getInt("payment_method_id"));
                invoice.setVoucherId(rs.getInt("voucher_id"));
                invoice.setIssueDate(rs.getTimestamp("issue_date"));
                invoice.setStatus(rs.getString("status"));
                invoice.setPaymentDate(rs.getTimestamp("payment_date"));
                invoice.setTransactionCode(rs.getString("transaction_code"));
                invoice.setUserName(rs.getString("user_name"));
                list.add(invoice);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }
}
