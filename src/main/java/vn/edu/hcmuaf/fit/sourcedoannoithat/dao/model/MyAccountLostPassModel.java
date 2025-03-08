package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;

public class MyAccountLostPassModel implements Serializable {
    private String email;

    public MyAccountLostPassModel(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
