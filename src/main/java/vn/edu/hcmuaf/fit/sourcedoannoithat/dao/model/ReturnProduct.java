package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;

public class ReturnProduct implements Serializable {
    private int id;
    private String status ;
    private String imageLink;
    private int orderCode;
    private String purchaseDate;
    private String reason;
    private String decription;

    public ReturnProduct(String status, String imageLink, int orderCode, String purchaseDate, String reason, String decription) {
        super();
        this.status = status;
        this.imageLink = imageLink;
        this.orderCode = orderCode;
        this.purchaseDate = purchaseDate;
        this.reason = reason;
        this.decription = decription;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }

    public int getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(int orderCode) {
        this.orderCode = orderCode;
    }

    public String getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(String purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getDescription() {
        return decription;
    }
    public void setDescription(String decription) {
        this.decription = decription;
    }

    @Override
    public String toString() {
        return " status=" + status +
                ", imageLink='" + imageLink + '\'' +
                ", orderCode=" + orderCode +
                ", purchaseDate='" + purchaseDate + '\'' +
                ", reason='" + reason + '\'' +
                ", description='" + decription + '\'' +
                '}';
    }
}
