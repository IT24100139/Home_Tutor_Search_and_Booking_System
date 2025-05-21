package com.tutor.model;

public class EditorUser extends Admin {
    public EditorUser(int id, String name, String email, String password) {
        super(id, name, email, password, "Editor");
    }

    @Override
    public void setRole(String role) {
        throw new UnsupportedOperationException("Editors cannot change their role");
    }
}