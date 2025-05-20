package com.payment.servlet;

import com.payment.model.Payment;
import com.payment.util.PaymentFileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/bankTransfer")
public class BankTransferServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("bankTransfer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tutorName = request.getParameter("tutorName");
        String amountStr = request.getParameter("amount");
        String accountNumber = request.getParameter("accountNumber");
        String accountName = request.getParameter("accountName");
        String bankName = request.getParameter("bankName");
        String branchCode = request.getParameter("branchCode");

        // Validate all inputs
        if (tutorName == null || tutorName.trim().isEmpty() ||
                amountStr == null || amountStr.trim().isEmpty() ||
                accountNumber == null || accountNumber.trim().isEmpty() ||
                accountName == null || accountName.trim().isEmpty() ||
                bankName == null || bankName.trim().isEmpty() ||
                branchCode == null || branchCode.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("bankTransfer.jsp").forward(request, response);
            return;
        }

        try {
            double amount = Double.parseDouble(amountStr.trim());

            // Create new payment object
            Payment payment = new Payment();
            payment.setPaymentId(UUID.randomUUID().toString());
            payment.setTutorName(tutorName.trim());
            payment.setRate(amount);
            payment.setHours(1); // or optional: parse from form
            payment.setStatus("Completed");
            payment.setPaymentMethod("Bank Transfer");
            payment.setPaymentDate(new java.util.Date());

            // Mask account number
            String maskedAccount = accountNumber.length() > 4
                    ? "**** **** **** " + accountNumber.substring(accountNumber.length() - 4)
                    : accountNumber;

            payment.setCardOrAccountDetails(
                    "Bank: " + bankName +
                            ", Branch Code: " + branchCode +
                            ", Account: " + maskedAccount +
                            ", Account Holder: " + accountName
            );

            // Save payment
            String filePath = getServletContext().getRealPath("/WEB-INF/payments.txt");
            List<Payment> payments = PaymentFileHandler.loadPayments(filePath);
            payments.add(payment);
            PaymentFileHandler.savePayments(payments, filePath);

            response.sendRedirect(request.getContextPath() + "/paymentList");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid amount format.");
            request.getRequestDispatcher("bankTransfer.jsp").forward(request, response);
        }
    }
}
