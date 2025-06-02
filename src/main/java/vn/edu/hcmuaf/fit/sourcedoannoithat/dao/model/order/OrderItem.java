package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.order;

public class OrderItem {
    private int itemId;
    private int orderId;
    private int productId;
    private String productName;
    private String productImage;
    private double unitPrice;
    private int quantity;
    private double totalPrice;

    public OrderItem() {
    }

    public OrderItem(int itemId, int orderId, int productId, String productName, String productImage, Double unitPrice, int quantity, Double totalPrice) {
        this.itemId = itemId;
        this.orderId = orderId;
        this.productId = productId;
        this.productName = productName;
        this.productImage = productImage;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public Double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "itemId=" + itemId +
                ", orderId=" + orderId +
                ", productId=" + productId +
                ", productName='" + productName + '\'' +
                ", productImage='" + productImage + '\'' +
                ", unitPrice=" + unitPrice +
                ", quantity=" + quantity +
                ", totalPrice=" + totalPrice +
                '}';
    }
}