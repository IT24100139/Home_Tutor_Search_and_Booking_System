package com.tutorbooking.model;

public abstract class Session {
    private String date;
    private String time;
    private String duration;

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }

    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }

    public abstract double getCost();
}
