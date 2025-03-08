package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MyAccountLostPassDao {
    public boolean isEmailExist(String email) {
        String query = "SELECT email FROM profile_client WHERE email = ?";
        try (Connection connection = new DBConnect().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            return resultSet.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePassword(String email, String hashedPassword) {
        String query = "UPDATE profile_client SET passw = ? WHERE email = ?";
        try (Connection connection = new DBConnect().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, hashedPassword);
            preparedStatement.setString(2, email);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
