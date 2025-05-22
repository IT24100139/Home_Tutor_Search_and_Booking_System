
package com.example.hometutorsystem;

public class User {
    private String id;
    private String username;
    private String password;
    private String email;
    private String phone;
    private String role;

    public User(String id, String username, String password, String email, String phone, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.role = role;
    }

    public String getId() { return id; }
    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getRole() { return role; }

    public void setPassword(String password) { this.password = password; }
    public void setEmail(String email) { this.email = email; }
    public void setPhone(String phone) { this.phone = phone; }

    public String toCSV() {
        return String.join(",", id, username, password, email, phone, role);
    }

    public static User fromCSV(String line) {
        String[] p = line.split(",", -1);
        if (p.length < 6) return null;
        return new User(p[0], p[1], p[2], p[3], p[4], p[5]);
    }
}
