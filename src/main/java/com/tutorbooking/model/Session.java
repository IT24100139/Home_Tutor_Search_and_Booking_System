package com.tutorbooking.model;

//Abstract class representing a tutoring session.
//This serves as a base class for more specific types of sessions like Booking.
public abstract class Session {

    // Common session details
    private String date;      // Expected format: yyyy-MM-dd
    private String time;      // Expected format: HH:mm
    private String duration;  // e.g., 30 Minutes, 1 Hour, etc.

    //Gets the session date.
    public String getDate() {
        return date;
    }

    //Sets the session date.
    //Throws IllegalArgumentException if date is null or empty.
    public void setDate(String date) {
        if (date == null || date.trim().isEmpty()) {
            throw new IllegalArgumentException("Date is required.");
        }
        this.date = date;
    }

    //Gets the session time.
    public String getTime() {
        return time;
    }

    //Sets the session time.
    //Throws IllegalArgumentException if time is null or empty.
    public void setTime(String time) {
        if (time == null || time.trim().isEmpty()) {
            throw new IllegalArgumentException("Time is required.");
        }
        this.time = time;
    }

    //Gets the session duration (like 1 Hour, 30 Minutes).
    public String getDuration() {
        return duration;
    }

    //Sets the session duration.
    //Throws IllegalArgumentException if duration is null or empty.
    public void setDuration(String duration) {
        if (duration == null || duration.trim().isEmpty()) {
            throw new IllegalArgumentException("Duration is required.");
        }
        this.duration = duration;
    }

    //Abstract method to return the cost of the session.
    //Implemented in concrete subclasses like Booking.
    public abstract double getCost();
}

