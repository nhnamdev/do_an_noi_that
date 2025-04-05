package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;
// hien thi thong tin san pham len tren gio hang
public class CartDisplayItem implements Serializable {
    private int quantity;
    private Product product;

    public CartDisplayItem(int quantity, Product product) {
        this.quantity = quantity;
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "Order{" +
                "quantity=" + quantity +
                ", product=" + product +
                '}';
    }

    public void increaseQuantity() {
        this.quantity++;
    }
}
