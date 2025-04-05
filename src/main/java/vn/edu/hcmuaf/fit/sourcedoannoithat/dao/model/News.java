package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;


import java.util.Date;

public class News {
    private int id;
    private String title;
    private String description;
    private String content;
    private String image;
    private Date createdAt;
    private int categoryId; // Nếu bạn muốn gọn
    // private NewsCategory category; // Nếu bạn muốn quan hệ đối tượng

    public News() {
    }

    public News(int id, String title, String description, String content, String image, Date createdAt, int categoryId) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.content = content;
        this.image = image;
        this.createdAt = createdAt;
        this.categoryId = categoryId;
    }

    // GETTERS & SETTERS

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
}
