package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;

public class WarrantyProduct implements Serializable {
    private int id;
    private String email;
    private String name;
    private String warrantyDate;
    private String warrantyExpiryDate;
    private String status;
    public WarrantyProduct(String email, String name,String warrantyDate, String warrantyExpiryDate,String status) {
        this.email = email;
        this.name = name;
        this.warrantyDate = warrantyDate;
        this.warrantyExpiryDate = warrantyExpiryDate;
        this.status = status;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getWarrantyDate() {
        return warrantyDate;
    }
    public void setWarrantyDate(String warrantyDate) {
        this.warrantyDate = warrantyDate;
    }
    public String getWarrantyExpiryDate() {
        return warrantyExpiryDate;
    }
    public void setWarrantyExpiryDate(String warrantyExpiryDate) {
        this.warrantyExpiryDate = warrantyExpiryDate;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return
                "email=" + email +
                ", name='" + name + '\'' +
                ", warrantyDate='" + warrantyDate + '\'' +
                ", warrantyExpiryDate='" + warrantyExpiryDate + '\'' +
                ", status='" + status + "'";

    }
}
