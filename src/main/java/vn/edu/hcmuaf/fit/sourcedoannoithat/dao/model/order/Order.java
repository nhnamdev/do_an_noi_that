package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order;

import java.time.LocalDateTime;
import java.util.List;

public class Order {
    private int orderId;
    private int userId;
    private String orderNumber;
    private String customerName;
    private String customerPhone;
    private String shippingAddress;
    private double totalAmount;
    private String orderStatus;
    private String paymentMethod;
    private String notes;
    private LocalDateTime orderDate;
    private List<OrderItem> orderItems;

    public Order() {
    }

    public Order(int orderId, int userId, String orderNumber, String customerName, String customerPhone, String shippingAddress, Double totalAmount,
                 String orderStatus, String paymentMethod, String notes) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderNumber = orderNumber;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.shippingAddress = shippingAddress;
        this.totalAmount = totalAmount;
        this.orderStatus = orderStatus;
        this.paymentMethod = paymentMethod;
        this.notes = notes;
        this.orderDate = LocalDateTime.now();
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", orderNumber='" + orderNumber + '\'' +
                ", customerName='" + customerName + '\'' +
                ", customerPhone='" + customerPhone + '\'' +
                ", shippingAddress='" + shippingAddress + '\'' +
                ", totalAmount=" + totalAmount +
                ", orderStatus='" + orderStatus + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", notes='" + notes + '\'' +
                ", orderDate=" + orderDate +
                ", orderItems=" + orderItems +
                '}';
    }
}
