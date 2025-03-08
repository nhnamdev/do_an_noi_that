package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;

public class Contact implements Serializable {
    private int id;
    private String name;
    private String email;
    private String topic;
    private String content;

    public Contact(String name, String email, String topic, String content) {
        this.name = name;
        this.email = email;
        this.topic = topic;
        this.content = content;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String text) {
        this.content = text;
    }

    @Override
    public String toString() {
        return "name='" + name + '\'' +
                        ", email='" + email + '\'' +
                        ", topic='" + topic + '\'' +
                        ", content='" + content + '\'';
    }
}
