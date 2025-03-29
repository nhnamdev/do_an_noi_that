package vn.edu.hcmuaf.fit.sourcedoannoithat.dao;

import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.LogEntry;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LogDAO {
    private Connection connection = null;
    private PreparedStatement ps = null;

    public boolean insertLog(String username, String level, String location, String dataBefore, String dataAfter) {
        String query = "INSERT INTO logs (username, level, location, data_before, data_after) VALUES (?, ?, ?, ?, ?)";

        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, level);
            ps.setString(3, location);
            ps.setString(4, dataBefore);
            ps.setString(5, dataAfter);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    public List<LogEntry> getAllLogs() {
        List<LogEntry> logs = new ArrayList<>();
        String query = "SELECT * FROM logs ORDER BY event_time DESC";

        try {
            connection = new DBConnect().getConnection();
            ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                LogEntry log = new LogEntry(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("level"),
                        rs.getTimestamp("event_time"),
                        rs.getString("location"),
                        rs.getString("data_before"),
                        rs.getString("data_after")
                );
                logs.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return logs;
    }

    private void closeResources() {
        try {
            if (ps != null) ps.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static void main(String[] args) {
        LogDAO logDAO = new LogDAO();

        // Test insert log
        boolean isInserted = logDAO.insertLog("admin", "info", "/dashboard", "oldData", "newData");
        if (isInserted) {
            System.out.println("Log inserted successfully!");
        } else {
            System.out.println("Failed to insert log.");
        }

        // Test get all logs
        System.out.println("\n===== List of Logs =====");
        logDAO.getAllLogs().forEach(log -> {
            System.out.println("ID: " + log.getId());
            System.out.println("Username: " + log.getUsername());
            System.out.println("Level: " + log.getLevel());
            System.out.println("Time: " + log.getEventTime());
            System.out.println("Location: " + log.getLocation());
            System.out.println("Before: " + log.getDataBefore());
            System.out.println("After: " + log.getDataAfter());
            System.out.println("------------------------------");
        });
    }
}
