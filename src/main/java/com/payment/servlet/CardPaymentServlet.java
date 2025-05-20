package com.payment.servlet;

import com.payment.model.Payment;
import com.payment.util.PaymentFileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/cardPayment")
public class CardPaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from form
        String tutorName = request.getParameter("tutorName");
        String amountStr = request.getParameter("amount");
        String cardNumber = request.getParameter("cardNumber");
        String cardHolder = request.getParameter("cardHolder");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");

        // Basic validation
        if (tutorName == null || tutorName.trim().isEmpty() ||
                amountStr == null || amountStr.trim().isEmpty() ||
                cardNumber == null || cardNumber.trim().isEmpty() ||
                cardHolder == null || cardHolder.trim().isEmpty() ||
                expiryDate == null || expiryDate.trim().isEmpty() ||
                cvv == null || cvv.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("cardPayment.jsp").forward(request, response);
            return;
        }

        try {
            double amount = Double.parseDouble(amountStr.trim());

            // Create payment object
            Payment payment = new Payment();
            payment.setPaymentId(UUID.randomUUID().toString());
            payment.setTutorName(tutorName);
            payment.setRate(amount);
            payment.setHours(1); // default to 1
            payment.setStatus("Completed");
            payment.setPaymentMethod("Credit Card");
            payment.setPaymentDate(new Date());

            // Mask card number
            String maskedCard = cardNumber.length() > 4
                    ? "**** **** **** " + cardNumber.substring(cardNumber.length() - 4)
                    : cardNumber;

            payment.setCardOrAccountDetails("Card: " + maskedCard +
                    ", Holder: " + cardHolder +
                    ", Expiry: " + expiryDate);

            // Save to file
            String filePath = getServletContext().getRealPath("/WEB-INF/payments.txt");
            List<Payment> existing = PaymentFileHandler.loadPayments(filePath);
            existing.add(payment);
            PaymentFileHandler.savePayments(existing, filePath);

            // Redirect to history page
            response.sendRedirect(request.getContextPath() + "/paymentList");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid amount format.");
            request.getRequestDispatcher("cardPayment.jsp").forward(request, response);
        }
    }
}
