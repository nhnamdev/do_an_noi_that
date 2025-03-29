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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public Timestamp getEventTime() {
        return eventTime;
    }

    public void setEventTime(Timestamp eventTime) {
        this.eventTime = eventTime;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDataBefore() {
        return dataBefore;
    }

    public void setDataBefore(String dataBefore) {
        this.dataBefore = dataBefore;
    }

    public String getDataAfter() {
        return dataAfter;
    }

    public void setDataAfter(String dataAfter) {
        this.dataAfter = dataAfter;
    }
// Getters và Setters
}
