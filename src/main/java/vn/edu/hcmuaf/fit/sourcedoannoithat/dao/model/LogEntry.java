package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;
import java.sql.Timestamp;

public class LogEntry {
    private int id;
    private String username;
    private String level;
    private Timestamp eventTime;
    private String location;
    private String dataBefore;
    private String dataAfter;

    public LogEntry(int id, String username, String level, Timestamp eventTime, String location, String dataBefore, String dataAfter) {
        this.id = id;
        this.username = username;
        this.level = level;
        this.eventTime = eventTime;
        this.location = location;
        this.dataBefore = dataBefore;
        this.dataAfter = dataAfter;
    }

    // Getters và Setters
}
