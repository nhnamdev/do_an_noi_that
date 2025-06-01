package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.categories;

import java.time.LocalDateTime;

public class Subcategory {
    private int subcategoryId;
    private String subcategoryName;
    private String subcategoryCode;
    private int categoryId;
    private int displayOrder;
    private boolean isActive;
    private LocalDateTime createdAt;

    public Subcategory() {
    }

    public Subcategory(int subcategoryId, String subcategoryName,
                       String subcategoryCode, int categoryId, int displayOrder, boolean isActive, LocalDateTime createdAt) {
        this.subcategoryId = subcategoryId;
        this.subcategoryName = subcategoryName;
        this.subcategoryCode = subcategoryCode;
        this.categoryId = categoryId;
        this.displayOrder = displayOrder;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    public int getSubcategoryId() {
        return subcategoryId;
    }

    public void setSubcategoryId(int subcategoryId) {
        this.subcategoryId = subcategoryId;
    }

    public String getSubcategoryName() {
        return subcategoryName;
    }

    public void setSubcategoryName(String subcategoryName) {
        this.subcategoryName = subcategoryName;
    }

    public String getSubcategoryCode() {
        return subcategoryCode;
    }

    public void setSubcategoryCode(String subcategoryCode) {
        this.subcategoryCode = subcategoryCode;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Subcategory{" +
                "subcategoryId=" + subcategoryId +
                ", subcategoryName='" + subcategoryName + '\'' +
                ", subcategoryCode='" + subcategoryCode + '\'' +
                ", categoryId=" + categoryId +
                ", displayOrder=" + displayOrder +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                '}';
    }
}
