package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import org.mindrot.jbcrypt.BCrypt;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.RegisterModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDao {
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public boolean checkLogin(RegisterModel login) {
        String query = "SELECT password FROM profile_client WHERE username = ?";

        try  {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, login.getUsername());
            ResultSet resultSet = ps.executeQuery();
            if (resultSet.next()) {
                String hashedPasswordFromDB = resultSet.getString("password");
                return BCrypt.checkpw(login.getPassword(), hashedPasswordFromDB);
            }
            return false;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public int getUserRole(String username) {
        String query = "SELECT role FROM profile_client WHERE username = ?";
        int role = 0;

        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ResultSet resultSet = ps.executeQuery();
            if (resultSet.next()) {
                role = resultSet.getInt("role");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return role;
    }
    public int getIdByUsername(String username) {
        String query = "SELECT id FROM profile_client WHERE username = ?";
        int id = 0;
        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ResultSet resultSet = ps.executeQuery();
            if (resultSet.next()) {
                id = resultSet.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }

    public static void main(String[] args) {
        LoginDao loginDao = new LoginDao();
        System.out.println(loginDao.getUserRole("haipro0801"));
        System.out.println(loginDao.getIdByUsername("haipro0801"));
    }
}