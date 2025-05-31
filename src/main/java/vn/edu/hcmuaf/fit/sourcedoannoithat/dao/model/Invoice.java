package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Invoice {
    private int id;
    private int orderId;
    private int total;
    private int discount;
    private int finalAmount;
    private int paymentMethod;
    private int voucherId;
    private Timestamp issueDate;
    private String status;
    private Timestamp paymentDate;
    private String transactionCode;

}
