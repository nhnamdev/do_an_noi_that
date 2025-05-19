package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;

public class Profile implements Serializable {
    private int id;
    private String name;
    private String birthday;
    private String phoneNumber;
    private String address;
    private String email;

    public Profile() {
    }

    public Profile(String name, String birthday, String phoneNumber, String address, String email) {
        this.name = name;
        this.birthday = birthday;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.email = email;
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

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return
                "name='" + name + '\'' +
                        ", birthday='" + birthday + '\'' +
                        ", phoneNumber='" + phoneNumber + '\'' +
                        ", address='" + address + '\'' +
                        ", email='" + email + '\'' +
                        '}';
    }
}
