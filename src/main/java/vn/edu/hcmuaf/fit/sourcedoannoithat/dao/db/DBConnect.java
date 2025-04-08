package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    public Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3306/donoithat";
        String user = "root";
        String password = "";

        Connection connection = null;

        try {
            connection = DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Kết nối thất bại: " + e.getMessage());
        }

        return connection;
    }

    public static void main(String[] args) {
        try {
            DBConnect dbConnect = new DBConnect();
            Connection connection = dbConnect.getConnection();

            if (connection != null) {
                System.out.println("Kết nối thành công!");
                connection.close(); // Đóng kết nối sau khi kiểm tra
            } else {
                System.out.println("Kết nối thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
