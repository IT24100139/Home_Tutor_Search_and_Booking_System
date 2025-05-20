package com.payment.util;

import com.payment.model.Payment;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentFileHandler {
    public static void savePayment(Payment payment, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(payment.toString());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void savePayments(List<Payment> payments, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Payment p : payments) {
                writer.write(p.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static List<Payment> loadPayments(String filePath) {
        List<Payment> payments = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return payments;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println("Reading line: " + line);
                Payment payment = Payment.fromString(line);
                if (payment != null) payments.add(payment);
                else System.out.println("Skipped invalid line: " + line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return payments;
    }
}
