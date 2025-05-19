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

    public boolean registerUser(RegisterModel user, String otp) {
        String query = "INSERT INTO profile_client (username, password,name,birthday,role,phoneNumber,address,email,otp,active,otpCreateAt) VALUES( ?, ?, ?, ?,0,?,?,?,?,0,NOW())";

        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(3, user.getFullName());
            ps.setString(4, "01/01/2004");
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, "Đang cập nhật");
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

    public boolean checkEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM profile_client WHERE email = ?";

        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, email);

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

    public boolean checkAccountExists(String username) {
        String query = "SELECT COUNT(*) FROM profile_client WHERE username = ?";

        try (
                Connection connection = new DBConnect().getConnection();
                PreparedStatement ps = connection.prepareStatement(query)
        ) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0; // Tài khoản đã tồn tại
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Lỗi hoặc không tồn tại
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
        String query = "UPDATE profile_client SET otp = ? , otpCreateAt=NOW() WHERE email = ?";
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
        String query = "DELETE FROM profile_client WHERE active = 0 AND TIMESTAMPDIFF(HOUR, otpCreateAt, NOW()) > 1";

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
 

        RegisterDao registerDao = new RegisterDao();
        String email = "rocap85817@deusa7.com";
        String otp = "488063"; // giả sử OTP được gửi về email là 123456

        boolean result = registerDao.verifyOTP(email, otp);

        if (result) {
            System.out.println("✅ OTP hợp lệ. Kích hoạt tài khoản thành công.");
        } else {
            System.out.println("❌ OTP không hợp lệ hoặc đã hết hạn.");
        }
    }
}
