package com.feedback.model;

import java.io.Serializable;
import java.util.Date;

public class Feedback implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String email;
    private String subject;
    private String message;
    private Date dateSubmitted;

    // Constructors, getters, and setters
    public Feedback() {
        this.dateSubmitted = new Date();
    }

    // Getters and setters for all fields
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public Date getDateSubmitted() { return dateSubmitted; }
    public void setDateSubmitted(Date dateSubmitted) { this.dateSubmitted = dateSubmitted; }
}