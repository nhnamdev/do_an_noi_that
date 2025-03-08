package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Contact;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class ContactDao {
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public boolean createContact(Contact contact) {
        String query = "INSERT INTO contact (name, email, topic, content,timeContact) VALUES (?, ?, ?, ?,DATE(NOW()))";
        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, contact.getName());
            ps.setString(2, contact.getEmail());
            ps.setString(3, contact.getTopic());
            ps.setString(4, contact.getContent());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<String> getName() {
        try {
            String query = "SELECT name,email FROM contact ";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            List<String> contacts = new ArrayList<>();
            Set<String> uniqueContacts = new HashSet<>();
            while (rs.next()) {
                String name = rs.getString(1);
                String email = rs.getString(2);
                String identifier = name + "|" + email;

                if (!uniqueContacts.contains(identifier)) {
                    uniqueContacts.add(identifier);
                    contacts.add(name);
                }
            }
            return contacts;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<String> getContentByName(String name) {
        try {
            String query = "SELECT content, timeContact FROM contact WHERE name = ?";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, name);
            rs = ps.executeQuery();
            List<String> contents = new ArrayList<>();
            while (rs.next()) {
                String content = rs.getString(1);
                String timeContact = rs.getString(2);
                contents.add(timeContact + ": " + content);
            }
            return contents;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public List<Contact> getContactsByDate(String date) {
        try {
            String query = "SELECT * FROM contact WHERE timeContact = ?";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, date);
            rs = ps.executeQuery();
            List<Contact> contacts = new ArrayList<>();
            while (rs.next()) {
                Contact contact = new Contact(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
                contacts.add(contact);
            }
            return contacts;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        ContactDao contactDao = new ContactDao();
        List<String> list = contactDao.getContentByName("Hồ Minh Hải");
        for (String contact : list) {
            System.out.println(contact);
        }
    }

}
