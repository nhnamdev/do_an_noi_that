package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;

public class Product implements Serializable {
    private int id;
    private String name;
    private double price;
    private String img;
    private int quantitySold;
    private int stock;

    private int categoryId;
    private int subcategoryId;
    private String createdDate;
    private int viewCount;
    private boolean isFeatured;
    private double discountPercent;
    private Double originalPrice;

    private String categoryName;
    private String subcategoryName;

    // Nam sửa bị conflict gòi Nam ơiiiii, nên t thêm constructor vô nhoé
    public Product() {
    }

    public Product(int id, String name, double price, String img, int quantitySold) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.img = img;
        this.quantitySold = quantitySold;
        this.stock = 1;
    }

    public Product(int id, String name, double price, String img, int quantitySold, int stock) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.img = img;
        this.quantitySold = quantitySold;
        this.stock = stock;
    }

    public Product(int id, String name, double price, String img, int quantitySold, int stock, int categoryId, int subcategoryId, String createdDate, int viewCount, boolean isFeatured, double discountPercent, Double originalPrice, String categoryName, String subcategoryName) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.img = img;
        this.quantitySold = quantitySold;
        this.stock = stock;
        this.categoryId = categoryId;
        this.subcategoryId = subcategoryId;
        this.createdDate = createdDate;
        this.viewCount = viewCount;
        this.isFeatured = isFeatured;
        this.discountPercent = discountPercent;
        this.originalPrice = originalPrice;
        this.categoryName = categoryName;
        this.subcategoryName = subcategoryName;
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

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getSubcategoryId() {
        return subcategoryId;
    }

    public void setSubcategoryId(int subcategoryId) {
        this.subcategoryId = subcategoryId;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean featured) {
        isFeatured = featured;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Double getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(Double originalPrice) {
        this.originalPrice = originalPrice;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getSubcategoryName() {
        return subcategoryName;
    }

    public void setSubcategoryName(String subcategoryName) {
        this.subcategoryName = subcategoryName;
    }

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name='" + name + '\'' + ", price=" + price + ", img='" + img + '\'' + ", quantitySold=" + quantitySold + ", stock=" + stock + ", categoryId=" + categoryId + ", subcategoryId=" + subcategoryId + ", createdDate='" + createdDate + '\'' + ", viewCount=" + viewCount + ", isFeatured=" + isFeatured + ", discountPercent=" + discountPercent + ", originalPrice=" + originalPrice + ", categoryName='" + categoryName + '\'' + ", subcategoryName='" + subcategoryName + '\'' + '}';
    }
}