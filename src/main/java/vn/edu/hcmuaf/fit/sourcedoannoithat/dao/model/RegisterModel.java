package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;

public class RegisterModel implements Serializable {
    private int id;
    private String fullName;
    private String birthDay;
    private String email;
    private String phoneNumber;
    private String address;
    private String username;
    private String password;

    public RegisterModel(String fullName, String birthDay, String email, String phoneNumber, String address, String username, String password) {
        this.fullName = fullName;
        this.birthDay = birthDay;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.username = username;
        this.password = password;
    }
    public RegisterModel(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public String getBirthDay() {
        return birthDay;
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

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
}
