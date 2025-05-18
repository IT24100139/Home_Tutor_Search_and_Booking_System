package com.tutorbooking.model;

//Booking class extends Session to represent a full tutoring session with extra metadata.
public class Booking extends Session {

    // Booking metadata
    private String bookingId;
    private String subject;
    private String tutor;
    private String sessionType; // Trial, Regular, or Premium
    private String status; // e.g., Confirmed, Cancelled, Completed
    private String cancellationReason; // optional if cancelled

    //Enum to define session types and their costs.
    public enum SessionType {
        TRIAL(30) {
            @Override
            public double calculateCost() {
                return 0.0; // Trial is free
            }
        },
        REGULAR(60) {
            @Override
            public double calculateCost() {
                return 1000.0; // Regular session cost
            }
        },
        PREMIUM(90) {
            @Override
            public double calculateCost() {
                return 2000.0; // Premium session cost
            }
        };

        private final int baseMinutes;

        // Constructor for each enum value
        SessionType(int minutes) {
            this.baseMinutes = minutes;
        }

        public int getBaseDuration() {
            return baseMinutes;
        }

        // Each session type defines how to calculate its cost
        public abstract double calculateCost();
    }

    // Default constructor (used for initialization without values)
    public Booking() {
    }

    // Constructor with full parameters
    public Booking(String bookingId, String subject, String tutor, String date,
                   String time, String duration, String sessionType, String status) {
        this.bookingId = bookingId;
        this.subject = subject;
        this.tutor = tutor;
        setDate(date);         // inherited from Session
        setTime(time);         // inherited from Session
        setDuration(duration); // inherited from Session
        setSessionType(sessionType);
        this.status = status;
    }

    // Getters and setters
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

    //Validates and sets the session type.
    //Throws an error if session type is missing or invalid.
    public void setSessionType(String sessionType) {
        if (sessionType == null || sessionType.trim().isEmpty()) {
            throw new IllegalArgumentException("Session type is required");
        }
        try {
            // Ensure the type matches one of the enum values
            this.sessionType = SessionType.valueOf(sessionType.toUpperCase()).name();
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Invalid session type: " + sessionType);
        }
    }

    //Calculates the session cost using the enum definition.
    @Override
    public double getCost() {
        if (sessionType == null) return 0.0;
        try {
            return SessionType.valueOf(sessionType).calculateCost();
        } catch (IllegalArgumentException e) {
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


