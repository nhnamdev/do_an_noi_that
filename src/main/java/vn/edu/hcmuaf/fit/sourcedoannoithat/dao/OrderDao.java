package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order.Order;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order.OrderItem;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class OrderDao {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // tạo order và trả về order id, vì cái này liên quan tới hoá đơn
    public int createOrderAndGetId(Order order) {
        String query = "INSERT INTO order_product(user_id, order_number, customer_name, customer_phone, shipping_address, " +
                "total_amount, order_status, payment_method, notes, order_date) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = new DBConnect().getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction
            ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            if (order.getOrderNumber() == null || order.getOrderNumber().isEmpty()) {
                order.setOrderNumber(generateOrderNumber());
            }

            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getOrderNumber());
            ps.setString(3, order.getCustomerName());
            ps.setString(4, order.getCustomerPhone());
            ps.setString(5, order.getShippingAddress());
            ps.setDouble(6, order.getTotalAmount());
            ps.setString(7, order.getOrderStatus() != null ? order.getOrderStatus() : "pending");
            ps.setString(8, order.getPaymentMethod());
            ps.setString(9, order.getNotes());
            ps.setTimestamp(10, Timestamp.valueOf(LocalDateTime.now()));
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1); // Lấy order_id được auto-generate
            } else {
                throw new SQLException("Không thể tạo order_id");
            }

            // Lưu order items vào bảng order_items
            String itemSql = "INSERT INTO order_items (order_id, product_id, product_name, product_image, " +
                    "unit_price, quantity, total_price) VALUES (?, ?, ?, ?, ?, ?, ?)";

            ps = conn.prepareStatement(itemSql);

            for (OrderItem item : order.getOrderItems()) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProductId());
                ps.setString(3, item.getProductName());
                ps.setString(4, item.getProductImage());
                ps.setDouble(5, item.getUnitPrice());
                ps.setInt(6, item.getQuantity());
                ps.setDouble(7, item.getTotalPrice());
                ps.addBatch();
            }

            ps.executeBatch();
            conn.commit(); // Lưu thành công

            System.out.println("DEBUG: Order created with order_id: " + orderId);
            return orderId; // Trả về order_id

        } catch (Exception e) {
            System.out.println("DEBUG: Error creating order: " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return -1;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean createOrder(Order order) {
        return createOrderAndGetId(order) > 0;
    }

    // tạo số order ngẫu nhiên
    private String generateOrderNumber() {
        return "ORD" + System.currentTimeMillis() + new Random().nextInt(1000);
    }

    // luu order vao database
    public int insertOrder(Invoice invoice) {
        String sql = "insert into invoice(order_id,total_amount,discount_amount,final_amount,payment_method_id,voucher_id,issue_date,status,payment_date,transaction_code) values(?,?,?,?,?,?,?,?,?,?)";
        try {
            conn = new DBConnect().getConnection();
            PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            Timestamp currentTimestamp = Timestamp.valueOf(LocalDateTime.now());
            st.setInt(1, invoice.getOrderId());
            st.setDouble(2, invoice.getTotal());
            st.setInt(3, invoice.getDiscount());
            st.setDouble(4, invoice.getFinalAmount());
            st.setInt(5, invoice.getPaymentMethod());
            st.setNull(6, java.sql.Types.INTEGER);
            st.setTimestamp(7, currentTimestamp);
            st.setString(8, "waiting...");
            st.setNull(9, Types.TIMESTAMP);
            st.setNull(10, Types.VARCHAR);
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
            st.setString(3, invoice.getTransactionCode());
            st.setInt(4, invoice.getId());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Order getOrderById(int orderId) {
        String query = "SELECT * FROM order_product WHERE order_id = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderNumber(rs.getString("order_number"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setCustomerPhone(rs.getString("customer_phone"));
                order.setShippingAddress(rs.getString("shipping_address"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setNotes(rs.getString("notes"));
                // Chuyển đổi Timestamp sang LocalDateTime
                Timestamp timestamp = rs.getTimestamp("order_date");
                if (timestamp != null) {
                    order.setOrderDate(timestamp.toLocalDateTime());
                }
                return order;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    // Lấy danh sách sản phẩm trong đơn hàng
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT * FROM order_items WHERE order_id = ?";

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setItemId(rs.getInt("item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setProductImage(rs.getString("product_image"));
                item.setUnitPrice(rs.getDouble("unit_price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setTotalPrice(rs.getDouble("total_price"));
                orderItems.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return orderItems;
    }

    // Lấy thông tin hóa đơn theo order_id
    public Invoice getInvoiceByOrderId(int orderId) {
        String query = "SELECT * FROM invoice WHERE order_id = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setId(rs.getInt("invoice_id"));
                invoice.setOrderId(rs.getInt("order_id"));
                invoice.setTotal(rs.getDouble("total_amount"));
                invoice.setDiscount(rs.getInt("discount_amount"));
                invoice.setFinalAmount(rs.getDouble("final_amount"));
                invoice.setPaymentMethod(rs.getInt("payment_method_id"));
                invoice.setVoucherId(rs.getInt("voucher_id"));
                invoice.setIssueDate(rs.getTimestamp("issue_date"));
                invoice.setStatus(rs.getString("status"));
                invoice.setPaymentDate(rs.getTimestamp("payment_date"));
                invoice.setTransactionCode(rs.getString("transaction_code"));
                return invoice;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public static void main(String[] args) {
        OrderDao orderDao = new OrderDao();
        Invoice invoice = new Invoice();
        invoice.setFinalAmount(20000);
        invoice.setDiscount(0);
        System.out.println(orderDao.insertOrder(invoice));
    }
}
