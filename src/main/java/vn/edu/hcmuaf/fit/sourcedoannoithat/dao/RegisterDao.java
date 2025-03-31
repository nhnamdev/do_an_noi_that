package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.RegisterModel;

import java.sql.*;
import java.time.LocalDateTime;

public class RegisterDao {
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public boolean registerUser(RegisterModel user, String otp) {
        String query = "INSERT INTO profile_client (username, password,name,birthday,role,phoneNumber,address,email,otp,active,otpCreateAt) VALUES( ?, ?, ?, ?,0,?,?,?,?,0,NOW())";

        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getBirthDay());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getEmail());
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword()); // Trong thực tế nên mã hóa mật khẩu
            ps.setString(8, otp);

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

    public boolean checkAccountExists(String username) {
        String query = "SELECT COUNT(*) FROM profile_client WHERE username = ?";

        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, username);

            rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count == 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return true;
    }

    public boolean verifyOTP(String email, String otp) {
        String query = "SELECT * FROM profile_client WHERE email = ? AND otp = ? AND active= 0";

        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, otp);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Nếu OTP hợp lệ, cập nhật active = 1 và xóa OTP
                String updateQuery = "UPDATE profile_client SET active = 1, otp = NULL WHERE email = ?";
                ps = connection.prepareStatement(updateQuery);
                ps.setString(1, email);
                int rowsUpdated = ps.executeUpdate();
                return rowsUpdated > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean updateOTP(String email, String otp) {
        String query = "UPDATE profile_client SET otp = ? WHERE email = ? AND active = 0" ;
        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, otp);
            ps.setString(2, email);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public void removeExpiredOTP() {
        String query = "DELETE FROM profile_client WHERE active = 0 AND TIMESTAMPDIFF(HOUR, created_at, NOW()) > 1";

        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Đã xóa " + rowsAffected + " OTP hết hạn.");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        RegisterModel user = new RegisterModel();
        user.setUsername("testuser");
        user.setPassword("password123"); // Nên mã hóa mật khẩu
        user.setFullName("Test User");
        user.setBirthDay("1990-01-01");
        user.setPhoneNumber("0123456789");
        user.setAddress("123 Test Street");
        user.setEmail("testuser@example.com");

        // Gọi phương thức registerUser để kiểm tra
        RegisterDao registerDao = new RegisterDao();
        System.out.println(registerDao.verifyOTP("hominhhai2k4@gmail.com", "879921"));
    }
}
