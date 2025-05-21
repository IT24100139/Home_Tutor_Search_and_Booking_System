package model;

import java.io.Serializable;

public class User implements Serializable {
    private String id;
    private String email;
    private String role; // "tutor" or "admin"

    public User() {}

    public User(String id, String email, String role) {
        this.id = id;
        this.email = email;
        this.role = role;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
