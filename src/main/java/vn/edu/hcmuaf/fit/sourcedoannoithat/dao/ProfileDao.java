package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.AccountManagement;
import org.mindrot.jbcrypt.BCrypt;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Profile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProfileDao {
    Connection connection = null; // kết nối tới dtb
    PreparedStatement ps = null; // ném câu lệnh querry sang navicat
    ResultSet rs = null; // Nhận kq trả về

    public Profile getProfile(int id) {
        try {
            String query = "select * from profile_client where id = ?";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Profile p = new Profile(rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(9));
                return p;
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
        return null;
    }

    public boolean checkOldPassW(String oldPassw,int id) {
        String query = "SELECT password FROM profile_client WHERE id = ?";
        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                String hashedPasswordFromDB = rs.getString("password");
                return BCrypt.checkpw(oldPassw, hashedPasswordFromDB);
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

    public boolean changePassw(String newPassw,int id) {
        String query = "UPDATE profile_client SET password = ? WHERE id = ?";

        try {
            String hashedPassword = BCrypt.hashpw(newPassw, BCrypt.gensalt());
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, hashedPassword);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            } else {
                System.out.println("Không thay đổi được mật khẩu.");
                return false;
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

    public boolean updateProfile(Profile profile, int id) {
        String query = "UPDATE profile_client SET name = ?, birthday = ?, phoneNumber = ?, address = ?,email=?  WHERE id = ?";
        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, profile.getName());
            ps.setString(2, profile.getBirthday());
            ps.setString(3, profile.getPhoneNumber());
            ps.setString(4, profile.getAddress());
            ps.setString(5, profile.getEmail());
            ps.setInt(6, id);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
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

    public List<AccountManagement> getAccountAdmin() {
        try {
            String query = "SELECT * FROM profile_client WHERE role =0";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            List<AccountManagement> result = new ArrayList<>();
            while (rs.next()) {
                AccountManagement p = new AccountManagement(rs.getInt(1), rs.getString(2), rs.getString(4), rs.getString(9), rs.getString(6), rs.getString(7));
                result.add(p);
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }

    public List<AccountManagement> searchAccounts(String keyword) {
        List<AccountManagement> result = new ArrayList<>();
        try {
            String query = "SELECT * FROM profile_client WHERE username LIKE ? AND role = 0";
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, "%" + keyword + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                AccountManagement p = new AccountManagement(rs.getInt(1), rs.getString(2), rs.getString(4), rs.getString(9), rs.getString(6), rs.getString(7));
                result.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public void deleteAccount(int accountId) {
        String query = "DELETE FROM profile_client WHERE id = ?";
        try {
            connection = new DBConnect().getConnection();
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, accountId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        ProfileDao profileDao = new ProfileDao();
        Profile profile = new Profile("Hồ Hải 3", "08/01/2001", "0793450530", "BÙI HỮU NGHĨA STREET", "hominhhai2k@gmail.com");
        //System.out.println(profileDao.checkOldPassW("123456",3));
        System.out.println(profileDao.changePassw("123456",3));
    }

}
