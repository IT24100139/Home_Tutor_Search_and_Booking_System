package com.tutor.util;

import com.tutor.model.Admin;
import com.tutor.model.AdminUser;
import com.tutor.model.EditorUser;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class DataStorage {
    private final String filePath;
    private static final String DELIMITER = "\\|";
    private static final String SEPARATOR = "|";

    public DataStorage(String filePath) {
        this.filePath = filePath;
        initializeFile();
    }

    private void initializeFile() {
        File file = new File(filePath);
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public synchronized List<Admin> getAllRecords() {
        List<Admin> records = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(DELIMITER);
                if (parts.length >= 4) {
                    String role = parts.length >= 5 ? parts[4] : "Admin";
                    if ("Editor".equals(role)) {
                        records.add(new EditorUser(
                                Integer.parseInt(parts[0]),
                                parts[1],
                                parts[2],
                                parts[3]
                        ));
                    } else {
                        records.add(new AdminUser(
                                Integer.parseInt(parts[0]),
                                parts[1],
                                parts[2],
                                parts[3],
                                role
                        ));
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return records;
    }

    public synchronized void addRecord(Admin record) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(record.getId() + SEPARATOR
                    + record.getName() + SEPARATOR
                    + record.getEmail() + SEPARATOR
                    + record.getPassword() + SEPARATOR
                    + record.getRole());
            writer.newLine();
        }
    }

    public synchronized void updateRecordRole(int id, String newRole) throws IOException {
        List<Admin> records = getAllRecords();
        for (int i = 0; i < records.size(); i++) {
            Admin record = records.get(i);
            if (record.getId() == id) {
                if (record instanceof EditorUser && "Admin".equals(newRole)) {
                    // Replace Editor with new Admin instance
                    records.set(i, new AdminUser(
                            record.getId(),
                            record.getName(),
                            record.getEmail(),
                            record.getPassword(),
                            newRole
                    ));
                } else {
                    record.setRole(newRole);
                }
                break;
            }
        }
        saveAllRecords(records);
    }

    private void saveAllRecords(List<Admin> records) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Admin r : records) {
                writer.write(r.getId() + SEPARATOR
                        + r.getName() + SEPARATOR
                        + r.getEmail() + SEPARATOR
                        + r.getPassword() + SEPARATOR
                        + r.getRole());
                writer.newLine();
            }
        }
    }

    public synchronized void deleteRecord(int id) throws IOException {
        List<Admin> updated = getAllRecords().stream()
                .filter(r -> r.getId() != id)
                .collect(Collectors.toList());
        saveAllRecords(updated);
    }

    public synchronized int generateNewId() {
        List<Admin> records = getAllRecords();
        return records.isEmpty() ? 1 : records.get(records.size() - 1).getId() + 1;
    }
}