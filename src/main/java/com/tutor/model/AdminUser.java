package com.tutor.model;

public class AdminUser extends Admin {
    // Constructor matches the parent class
    public AdminUser(int id, String name, String email, String password, String role) {
        super(id, name, email, password, role); // Call super constructor
    }
}