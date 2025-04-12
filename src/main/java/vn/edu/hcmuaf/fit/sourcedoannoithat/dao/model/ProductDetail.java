package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

public class ProductDetail {
    private int detailID;
    private int id;
    private String productDescribe;
    private String material;
    private String brand;
    private String color;
    private double length;
    private double width;
    private double height;
    private double weight;
    private String feature;
    private String stockStatus;

    public ProductDetail(int detailID, int id, String productDescribe, String material,
                         String brand, String color, double length, double width,
                         double height, double weight, String feature, String stockStatus) {
        this.detailID = detailID;
        this.id = id;
        this.productDescribe = productDescribe;
        this.material = material;
        this.brand = brand;
        this.color = color;
        this.length = length;
        this.width = width;
        this.height = height;
        this.weight = weight;
        this.feature = feature;
        this.stockStatus = stockStatus;
    }

    public int getDetailID() {
        return detailID;
    }

    public void setDetailID(int detailID) {
        this.detailID = detailID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProductDescribe() {
        return productDescribe;
    }

    public void setProductDescribe(String productDescribe) {
        this.productDescribe = productDescribe;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getLength() {
        return length;
    }

    public void setLength(double length) {
        this.length = length;
    }

    public double getWidth() {
        return width;
    }

    public void setWidth(double width) {
        this.width = width;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getFeature() {
        return feature;
    }

    public void setFeature(String feature) {
        this.feature = feature;
    }

    public String getStockStatus() {
        return stockStatus;
    }

    public void setStockStatus(String stockStatus) {
        this.stockStatus = stockStatus;
    }

    @Override
    public String toString() {
        return "ProductDetail{" +
                "detailID=" + detailID +
                ", id=" + id +
                ", productDescribe='" + productDescribe + '\'' +
                ", material='" + material + '\'' +
                ", brand='" + brand + '\'' +
                ", color='" + color + '\'' +
                ", length=" + length +
                ", width=" + width +
                ", height=" + height +
                ", weight=" + weight +
                ", feature='" + feature + '\'' +
                ", stockStatus='" + stockStatus + '\'' +
                '}';
    }
}
