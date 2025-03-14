package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.RegisterModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterDao {
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    public boolean registerUser(RegisterModel user) {
        String query = "INSERT INTO profile_client (username, password,name,birthday,role,phoneNumber,address,email) VALUES( ?, ?, ?, ?,0,?,?,?)";

        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(3, user.getFullName());
            ps.setString(4,user.getBirthDay());
            ps.setString(5,user.getPhoneNumber());
            ps.setString(6,user.getAddress());
            ps.setString(7,user.getEmail());
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword()); // Trong thực tế nên mã hóa mật khẩu

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

    public static void main(String[] args) {
        // Tạo một đối tượng RegisterModel với dữ liệu giả lập
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
        boolean result = registerDao.registerUser(user);

        // In kết quả ra màn hình
        if (result) {
            System.out.println("Đăng ký thành công!");
        } else {
            System.out.println("Đăng ký thất bại!");
        }
    }


}
