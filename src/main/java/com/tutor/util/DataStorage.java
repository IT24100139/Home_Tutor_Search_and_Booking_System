package com.tutor.util;

import com.tutor.model.Admin;
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
                    records.add(new Admin(
                            Integer.parseInt(parts[0]),
                            parts[1],
                            parts[2],
                            parts[3],
                            role
                    ));
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
        for (Admin record : records) {
            if (record.getId() == id) {
                record.setRole(newRole);
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