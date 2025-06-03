package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order.Order;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderManagementDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // lay don hang ra cho admin quan ly
    public List<Order> getAllOrdersForAdmin() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT op.*, pc.name as customer_full_name, pc.email " +
                "FROM order_product op " +
                "LEFT JOIN profile_client pc ON op.user_id = pc.id " +
                "ORDER BY op.order_date DESC";

        try {
            conn = new DBConnect().getConnection();
            if (conn == null) {
                return orders;
            }
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            int count = 0;
            while (rs.next()) {
                count++;
                try {
                    Order order = new Order();
                    int orderId = rs.getInt("order_id");
                    order.setOrderId(orderId);
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderNumber(rs.getString("order_number"));
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setCustomerPhone(rs.getString("customer_phone"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setNotes(rs.getString("notes"));

                    String customerFullName = rs.getString("customer_full_name");
                    String customerEmail = rs.getString("email");
                    if (customerFullName != null && !customerFullName.trim().isEmpty()) {
                        order.setCustomerName(customerFullName);
                    }

                    // xu ly timestamp
                    Timestamp timestamp = rs.getTimestamp("order_date");
                    if (timestamp != null) {
                        order.setOrderDate(timestamp.toLocalDateTime());
                    } else {
                    }

                    orders.add(order);

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return orders;
    }

    // get đơn hàng theo trạng thái đơn
    public List<Order> getOrdersByStatus(String status) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT op.*, pc.name as customer_full_name, pc.email " +
                "FROM order_product op " +
                "LEFT JOIN profile_client pc ON op.user_id = pc.id " +
                "WHERE op.order_status = ? " +
                "ORDER BY op.order_date DESC";

        try {
            conn = new DBConnect().getConnection();
            if (conn == null) {
                return orders;
            }

            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            rs = ps.executeQuery();

            int count = 0;
            while (rs.next()) {
                count++;
                Order order = createOrderFromResultSet(rs);
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return orders;
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(int orderId, String newStatus) {
        String query = "UPDATE order_product SET order_status = ? WHERE order_id = ?";
        try {
            conn = new DBConnect().getConnection();
            if (conn == null) {
                return false;
            }
            ps = conn.prepareStatement(query);
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnections();
        }
    }

    // Duyệt đơn
    public boolean approveOrder(int orderId) {
        return updateOrderStatus(orderId, "confirmed");
    }

    // Từ chối đơn
    public boolean rejectOrder(int orderId) {
        return updateOrderStatus(orderId, "cancelled");
    }

    // Ship
    public boolean shipOrder(int orderId) {
        return updateOrderStatus(orderId, "shipping");
    }

    // Hoàn thành đơn
    public boolean completeOrder(int orderId) {
        return updateOrderStatus(orderId, "delivered");
    }

    // Thống kê đơn hàng theo trạng thái
    public int getOrderCountByStatus(String status) {
        String query = "SELECT COUNT(*) FROM order_product WHERE order_status = ?";
        try {
            conn = new DBConnect().getConnection();
            if (conn == null) {
                return 0;
            }

            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            rs = ps.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                return count;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return 0;
    }

    // Lấy chi tiết đơn hàng với danh sách sản phẩm
    public Order getOrderWithItems(int orderId) {
        Order order = getOrderById(orderId);
        if (order != null) {
            List<OrderItem> items = getOrderItemsByOrderId(orderId);
            order.setOrderItems(items);
        }
        return order;
    }

    // Lấy thông tin đơn hàng theo ID
    private Order getOrderById(int orderId) {
        String query = "SELECT op.*, pc.name as customer_full_name, pc.email " +
                "FROM order_product op " +
                "LEFT JOIN profile_client pc ON op.user_id = pc.id " +
                "WHERE op.order_id = ?";
        try {
            conn = new DBConnect().getConnection();
            if (conn == null) {
                return null;
            }

            ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return createOrderFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }

    // Lấy danh sách sản phẩm trong đơn hàng
    private List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String query = "SELECT oi.*, ps.name as product_name_detail " +
                "FROM order_items oi " +
                "LEFT JOIN product_shop ps ON oi.product_id = ps.id " +
                "WHERE oi.order_id = ?";

        try {
            conn = new DBConnect().getConnection();
            if (conn == null) {

                return items;
            }

            ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            int count = 0;
            while (rs.next()) {
                count++;
                OrderItem item = new OrderItem();
                item.setItemId(rs.getInt("item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setProductImage(rs.getString("product_image"));
                item.setUnitPrice(rs.getDouble("unit_price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setTotalPrice(rs.getDouble("total_price"));
                items.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return items;
    }

    // Helper method để tạo Order từ ResultSet
    private Order createOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();

        try {
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

            // Override với tên đầy đủ từ profile nếu có
            String customerFullName = rs.getString("customer_full_name");
            if (customerFullName != null && !customerFullName.trim().isEmpty()) {
                order.setCustomerName(customerFullName);
            }

            Timestamp timestamp = rs.getTimestamp("order_date");
            if (timestamp != null) {
                order.setOrderDate(timestamp.toLocalDateTime());
            }

        } catch (SQLException e) {
            throw e;
        }

        return order;
    }

    // Đóng kết nối
    private void closeConnections() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}