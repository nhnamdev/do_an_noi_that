package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

public class PaymentHistory {
    private int historyId;
    private int invoiceId;
    private int userId;
    private double amountPaid;
    private String paymentTime; // hoặc dùng java.sql.Timestamp nếu cần xử lý ngày giờ
    private int paymentMethodId;
    private String status;
    private String transactionCode;
    private String userName;

    // Constructor
    public PaymentHistory() {
    }

    public PaymentHistory(int historyId, int invoiceId, int userId, double amountPaid,
                          String paymentTime, int paymentMethodId, String status, String transactionCode, String userName) {
        this.historyId = historyId;
        this.invoiceId = invoiceId;
        this.userId = userId;
        this.amountPaid = amountPaid;
        this.paymentTime = paymentTime;
        this.paymentMethodId = paymentMethodId;
        this.status = status;
        this.transactionCode = transactionCode;
        this.userName = userName;
    }

    // Getters and Setters
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getHistoryId() {
        return historyId;
    }

    public void setHistoryId(int historyId) {
        this.historyId = historyId;
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getAmountPaid() {
        return amountPaid;
    }

    public void setAmountPaid(double amountPaid) {
        this.amountPaid = amountPaid;
    }

    public String getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(String paymentTime) {
        this.paymentTime = paymentTime;
    }

    public int getPaymentMethodId() {
        return paymentMethodId;
    }

    public void setPaymentMethodId(int paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }
}
