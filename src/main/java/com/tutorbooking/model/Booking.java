package com.tutorbooking.model;

public class Booking extends Session {
    private String bookingId;
    private String subject;
    private String tutor;
    private String sessionType;
    private String status;
    private String cancellationReason;

    public static final String TRIAL = "TRIAL";
    public static final String REGULAR = "REGULAR";
    public static final String PREMIUM = "PREMIUM";

    public Booking() {
    }

    public Booking(String bookingId, String subject, String tutor, String date,
                   String time, String duration, String sessionType, String status) {
        this.bookingId = bookingId;
        this.subject = subject;
        this.tutor = tutor;
        setDate(date);
        setTime(time);
        setDuration(duration);
        setSessionType(sessionType);
        this.status = status;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getTutor() {
        return tutor;
    }

    public void setTutor(String tutor) {
        this.tutor = tutor;
    }

    public String getSessionType() {
        return sessionType;
    }

    public void setSessionType(String sessionType) {
        if (sessionType == null || sessionType.trim().isEmpty()) {
            throw new IllegalArgumentException("Session type is required");
        }

        String type = sessionType.trim().toUpperCase();

        if (!type.equals(TRIAL) && !type.equals(REGULAR) && !type.equals(PREMIUM)) {
            throw new IllegalArgumentException("Invalid session type: " + sessionType);
        }

        this.sessionType = type;
    }

    @Override
    public double getCost() {
        if (sessionType == null) return 0.0;

        switch (sessionType) {
            case REGULAR:
                return 1000.0;
            case PREMIUM:
                return 2000.0;
            default:
                return 0.0;
        }
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCancellationReason() {
        return cancellationReason;
    }

    public void setCancellationReason(String cancellationReason) {
        this.cancellationReason = cancellationReason;
    }
}



