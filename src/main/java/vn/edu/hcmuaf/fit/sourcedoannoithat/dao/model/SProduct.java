package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;
import java.util.List;

public class SProduct implements Serializable {
    private int id;
    private String name;
    private double price;
    private int quantity;
    private String description;
    private List<String> images;

    public SProduct(String name, double price, String description, List<String> images) {
        this.name = name;
        this.price = price;
        this.description = description;
        this.images = images;
    }
    public SProduct() {

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

    public String getDescription() {
        return description;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getImages() {
        return images;
    }
    public void setImage(String img) {
        this.images.add(img);
    }
    public String getIndexImages(int index) {
        return images.get(index);
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    @Override
    public String toString() {
        return
                "name='" + name + '\'' +
                ", price=" + price +
                ", description='" + description + '\'' +
                ", images=" + images +
                '\n';
    }
}
