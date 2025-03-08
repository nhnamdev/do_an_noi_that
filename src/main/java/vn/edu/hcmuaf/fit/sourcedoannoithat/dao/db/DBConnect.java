package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    public Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3307/dtb_nhom6";
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
}
