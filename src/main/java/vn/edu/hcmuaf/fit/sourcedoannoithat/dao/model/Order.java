package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;

public class Order implements Serializable {
    private int id;
    private String nameProduct;
    private int quantity;
    private String img;
    private double price;
    private int pending;
    private String name;
    private String dateOrder;

    public Order(int id, String nameProduct, int quantity, double price, String img, int pending, String name, String dateOrder) {
        this.id = id;
        this.nameProduct = nameProduct;
        this.quantity = quantity;
        this.price = price;
        this.img = img;
        this.pending = pending;
        this.name = name;
        this.dateOrder = dateOrder;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNameProduct() {
        return nameProduct;
    }

    public void setNameProduct(String nameProduct) {
        this.nameProduct = nameProduct;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getPending() {
        return pending;
    }

    public void setPending(int pending) {
        this.pending = pending;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDateOrder() {
        return dateOrder;
    }

    public void setDateOrder(String dateOrder) {
        this.dateOrder = dateOrder;
    }

    @Override
    public String toString() {
        return "name=" + name +
                ",nameProduct=" + nameProduct +
                ", quantity=" + quantity +
                ", price=" + price + ", image=" + img + ", dateOrder=" + dateOrder + "\n";

    }
}
