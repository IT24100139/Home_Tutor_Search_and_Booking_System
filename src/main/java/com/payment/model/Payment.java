package com.payment.model;

import java.io.Serializable;
import java.util.Date;

public class Payment implements Serializable {
    private String paymentId;
    private String tutorName;
    private int hours;
    private double rate;
    private double total;
    private String paymentMethod;
    private String cardOrAccountDetails;
    private Date paymentDate;
    private String status;

    public Payment() {
        this.paymentDate = new Date();
        this.status = "Pending";
    }

    public String getPaymentId() { return paymentId; }
    public void setPaymentId(String paymentId) { this.paymentId = paymentId; }

    public String getTutorName() { return tutorName; }
    public void setTutorName(String tutorName) { this.tutorName = tutorName; }

    public int getHours() { return hours; }
    public void setHours(int hours) {
        this.hours = hours;
        calculateTotal();
    }

    public double getRate() { return rate; }
    public void setRate(double rate) {
        this.rate = rate;
        calculateTotal();
    }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getCardOrAccountDetails() { return cardOrAccountDetails; }
    public void setCardOrAccountDetails(String cardOrAccountDetails) { this.cardOrAccountDetails = cardOrAccountDetails; }

    public Date getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Date paymentDate) { this.paymentDate = paymentDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    private void calculateTotal() {
        this.total = this.hours * this.rate;
    }

    @Override
    public String toString() {
        return paymentId + "|" + tutorName + "|" + hours + "|" + rate + "|" + total + "|" +
                (paymentMethod != null ? paymentMethod : "") + "|" +
                (cardOrAccountDetails != null ? cardOrAccountDetails : "") + "|" +
                paymentDate.getTime() + "|" + status;
    }

    public static Payment fromString(String str) {
        try {
            String[] parts = str.split("\\|");
            if (parts.length != 9) return null;

            Payment p = new Payment();
            p.setPaymentId(parts[0]);
            p.setTutorName(parts[1]);
            p.setHours(Integer.parseInt(parts[2]));
            p.setRate(Double.parseDouble(parts[3]));
            p.setPaymentMethod(parts[5]);
            p.setCardOrAccountDetails(parts[6]);
            p.setPaymentDate(new Date(Long.parseLong(parts[7])));
            p.setStatus(parts[8]);
            return p;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
