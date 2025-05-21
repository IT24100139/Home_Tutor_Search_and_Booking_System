package com.feedback.util;

import com.feedback.model.Feedback;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;

public class FeedbackFileHandler {
    // Use user home directory to store data for better reliability
    private static final String FILE_PATH = System.getProperty("user.home") + File.separator + "feedbackData.txt";

    public static synchronized void saveFeedbacks(List<Feedback> feedbacks) {
        try {
            // Ensure parent directories exist
            Path dataFilePath = Paths.get(FILE_PATH);
            Files.createDirectories(dataFilePath.getParent());

            try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_PATH))) {
                oos.writeObject(feedbacks);
                System.out.println("Feedback data saved to: " + FILE_PATH);
            }
        } catch (IOException e) {
            System.err.println("Error saving feedback data: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static synchronized List<Feedback> loadFeedbacks() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            System.out.println("Feedback data file not found. Creating new list.");
            return new LinkedList<>();
        }

        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE_PATH))) {
            @SuppressWarnings("unchecked")
            List<Feedback> feedbacks = (List<Feedback>) ois.readObject();
            System.out.println("Loaded " + feedbacks.size() + " feedback(s) from: " + FILE_PATH);
            return feedbacks;
        } catch (IOException | ClassNotFoundException e) {
            System.err.println("Error loading feedback data: " + e.getMessage());
            e.printStackTrace();
            return new LinkedList<>();
        }
    }

    public static synchronized int getNextId() {
        List<Feedback> feedbacks = loadFeedbacks();
        if (feedbacks.isEmpty()) {
            return 1;
        }

        // Find the maximum ID and add 1
        int maxId = feedbacks.stream()
                .mapToInt(Feedback::getId)
                .max()
                .orElse(0);
        return maxId + 1;
    }

    public static synchronized void addFeedback(Feedback feedback) {
        List<Feedback> feedbacks = loadFeedbacks();
        feedback.setId(getNextId());
        feedbacks.add(feedback);
        saveFeedbacks(feedbacks);
        System.out.println("Added new feedback with ID: " + feedback.getId());
    }
}