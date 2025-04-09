package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;


import java.util.Date;

public class News {
    private int news_id;
    private String title;
    private String description;
    private String content;
    private String image;
    private Date createdAt;
    private int categoryId; // Nếu bạn muốn gọn
    // private NewsCategory category; // Nếu bạn muốn quan hệ đối tượng

    public News() {
    }

    public News(int news_id, String title, String description, String content, String image, Date createdAt, int categoryId) {
        this.news_id = news_id;
        this.title = title;
        this.description = description;
        this.content = content;
        this.image = image;
        this.createdAt = createdAt;
        this.categoryId = categoryId;
    }

    // GETTERS & SETTERS

    public int getNews_id() {
        return news_id;
    }

    public void setNews_id(int news_id) {
        this.news_id = news_id;
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

    @Override
    public String toString() {
        return "News{" +
                "news_id=" + news_id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", content='" + content + '\'' +
                ", image='" + image + '\'' +
                ", createdAt=" + createdAt +
                ", categoryId=" + categoryId +
                '}';
    }
}
