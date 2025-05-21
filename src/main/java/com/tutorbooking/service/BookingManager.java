package com.tutorbooking.service;

import com.tutorbooking.model.Booking;
import jakarta.servlet.ServletContext;

import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;

public class BookingManager {
    private static final String FILE_NAME = "bookings.txt";
    private static final String DELIMITER = ",";
    private ServletContext servletContext;

    public BookingManager(ServletContext context) {
        this.servletContext = context;
    }

    private String getFilePath() {
        if (servletContext == null) {
            throw new IllegalStateException("ServletContext not initialized.");
        }
        String path = servletContext.getRealPath("/WEB-INF/" + FILE_NAME);
        System.out.println("Resolved file path: " + path);
        return path;
    }

    public synchronized void createBooking(Booking booking) throws IOException {
        validateBooking(booking);
        String data = convertBookingToString(booking);
        Path path = Paths.get(getFilePath());

        if (!Files.exists(path)) {
            Files.createDirectories(path.getParent());
            Files.createFile(path);
        }

        Files.write(path, (data + System.lineSeparator()).getBytes(), StandardOpenOption.APPEND);
    }

    public synchronized List<Booking> getAllBookings() throws IOException {
        Path path = Paths.get(getFilePath());
        if (!Files.exists(path)) {
            return new ArrayList<>();
        }

        List<Booking> bookings = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(path.toFile()))) {
            String line;
            int lineNumber = 0;
            while ((line = reader.readLine()) != null) {
                lineNumber++;
                if (line.trim().isEmpty()) continue;

                try {
                    Booking booking = convertStringToBooking(line);
                    if (booking != null) bookings.add(booking);
                } catch (Exception e) {
                    System.err.println("Invalid line " + lineNumber + ": " + e.getMessage());
                }
            }
        }

        return bookings;
    }

    public synchronized Booking getBookingById(String id) throws IOException {
        return getAllBookings().stream()
                .filter(b -> b.getBookingId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public synchronized void updateBooking(Booking updatedBooking) throws IOException {
        List<Booking> bookings = getAllBookings();
        for (int i = 0; i < bookings.size(); i++) {
            if (bookings.get(i).getBookingId().equals(updatedBooking.getBookingId())) {
                bookings.set(i, updatedBooking);
                break;
            }
        }
        saveAllBookings(bookings);
    }

    public synchronized void cancelBooking(String id, String reason) throws IOException {
        List<Booking> bookings = getAllBookings();
        for (Booking booking : bookings) {
            if (booking.getBookingId().equals(id)) {
                booking.setStatus("Cancelled");
                booking.setCancellationReason(reason);
                break;
            }
        }
        saveAllBookings(bookings);
    }

    public synchronized void saveAllBookings(List<Booking> bookings) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(getFilePath()))) {
            for (Booking booking : bookings) {
                writer.write(convertBookingToString(booking));
                writer.newLine();
            }
        }
    }

    private String convertBookingToString(Booking booking) {
        return String.join(DELIMITER,
                booking.getBookingId(),
                booking.getSubject(),
                booking.getTutor(),
                booking.getDate(),
                booking.getTime(),
                booking.getDuration(),
                booking.getSessionType(),
                booking.getStatus(),
                booking.getCancellationReason() != null ? booking.getCancellationReason() : ""
        );
    }

    private Booking convertStringToBooking(String str) {
        String[] parts = str.split(DELIMITER, -1);
        if (parts.length < 8) return null;

        Booking booking = new Booking();
        booking.setBookingId(parts[0]);
        booking.setSubject(parts[1]);
        booking.setTutor(parts[2]);
        booking.setDate(parts[3]);
        booking.setTime(parts[4]);
        booking.setDuration(parts[5]);
        booking.setSessionType(parts[6]);
        booking.setStatus(parts[7]);

        if (parts.length > 8) {
            booking.setCancellationReason(parts[8]);
        }

        return booking;
    }

    private void validateBooking(Booking booking) {
        if (booking.getBookingId() == null || booking.getSubject() == null || booking.getTutor() == null ||
                booking.getDate() == null || booking.getTime() == null || booking.getDuration() == null ||
                booking.getSessionType() == null) {
            throw new IllegalArgumentException("All booking fields are required");
        }
    }
}


