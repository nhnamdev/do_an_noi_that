package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;
import java.text.DecimalFormat;

public class Product implements Serializable {
    private int id;
    private String name;
    private double price;
    private String img;
    private int quantitySold;
    private int quantity;

    public Product() {
    }

    public Product(int id, String name, double price, String img, int quantitySold) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.img = img;
        this.quantitySold = quantitySold;
        this.quantity = 1;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public int getQuantitySold() {
        return quantitySold;
    }

    public void setQuantitySold(int quantitySold) {
        this.quantitySold = quantitySold;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public String getFormattedPrice() {
        DecimalFormat formatter = new DecimalFormat("#,###");
        return formatter.format(price);
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", img='" + img + '\'' +
                ", quantitySold=" + quantitySold +
                '}';
    }
}
