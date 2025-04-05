package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;
// ds san pham trong gio hang cua ng dung dc luu vao database
public class Cart implements Serializable {
    private int id;
    private int userID;
    private int productID;
    private int quantity;

    public Cart(int userID, int productID, int quantity) {
        this.userID = userID;
        this.productID = productID;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "userID=" + userID +
                ", productID=" + productID +
                ", quantity=" + quantity +
                '}';
    }
}
