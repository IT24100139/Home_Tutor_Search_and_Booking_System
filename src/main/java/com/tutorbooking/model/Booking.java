package com.tutorbooking.model;

public class Booking extends Session {
    private String bookingId;
    private String subject;
    private String tutor;
    private String sessionType;
    private String status;
    private String cancellationReason;

    public enum SessionType {
        TRIAL(30) {
            @Override
            public double calculateCost() {
                return 0.0;
            }
        },
        REGULAR(60) {
            @Override
            public double calculateCost() {
                return 1000.0;
            }
        },
        PREMIUM(90) {
            @Override
            public double calculateCost() {
                return 2000.0;
            }
        };

        private final int baseMinutes;
        SessionType(int minutes) {
            this.baseMinutes = minutes; }

        public int getBaseDuration() {
            return baseMinutes; }

        public abstract double calculateCost();
    }

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
        return sessionType; }


    public void setSessionType(String sessionType) {
        SessionType.valueOf(sessionType.toUpperCase());
        this.sessionType = sessionType;
    }

    @Override
    public double getCost() {
        return SessionType.valueOf(sessionType.toUpperCase()).calculateCost();
    }


    public String getStatus() {
        return status; }

    public void setStatus(String status) {
        this.status = status; }

    public String getCancellationReason() {
        return cancellationReason; }

    public void setCancellationReason(String cancellationReason) {
        this.cancellationReason = cancellationReason; }
}
