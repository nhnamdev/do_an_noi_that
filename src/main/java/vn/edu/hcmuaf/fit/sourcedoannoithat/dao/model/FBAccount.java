package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

public class FBAccount {
    private String id, email, name;

    public FBAccount(String id, String email, String name) {
        this.id = id;
        this.email = email;
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
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

    @Override
    public String toString() {
        return "id='" + id + '\'' +
                ", email='" + email + '\'' +
                ", name='" + name + "\n";
    }
}
