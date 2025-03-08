package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.util.ArrayList;

public class ProductShop implements Serializable {
    private int id;
    private String name;
    private double price;
    private String img;
    private int quantitySold;

    public ProductShop(String name, double price,String images, int quantitySold) {
        this.name = name;
        this.price = price;
        this.img = images;
        this.quantitySold = quantitySold;
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
    public String getFormattedPrice() {
        DecimalFormat df = new DecimalFormat("#.000");
        return df.format(price);
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

    @Override
    public String toString() {
        return
                "name='" + name + '\'' +
                ", price=" + getFormattedPrice() +
                ", img='" + img + '\'' +
                ", quantitySold=" + quantitySold+"\n";
    }
}
