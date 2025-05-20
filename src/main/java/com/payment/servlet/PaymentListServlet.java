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
import java.util.stream.Collectors;

@WebServlet("/paymentList")
public class PaymentListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filePath = getServletContext().getRealPath("/WEB-INF/payments.txt");
        System.out.println("Loading payments from: " + filePath);
        List<Payment> payments = PaymentFileHandler.loadPayments(filePath);
        System.out.println("Loaded " + payments.size() + " payments.");

        request.setAttribute("payments", payments);
        request.getRequestDispatcher("paymentList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String paymentId = request.getParameter("paymentId");

        if (paymentId == null || paymentId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/paymentList");
            return;
        }

        String filePath = getServletContext().getRealPath("/WEB-INF/payments.txt");
        List<Payment> payments = PaymentFileHandler.loadPayments(filePath);

        if ("delete".equals(action)) {
            payments = payments.stream()
                    .filter(p -> !p.getPaymentId().equals(paymentId))
                    .collect(Collectors.toList());
            PaymentFileHandler.savePayments(payments, filePath);
            response.sendRedirect(request.getContextPath() + "/paymentList");
            return;

        } else if ("update".equals(action)) {
            Payment paymentToUpdate = payments.stream()
                    .filter(p -> p.getPaymentId().equals(paymentId))
                    .findFirst()
                    .orElse(null);

            if (paymentToUpdate == null) {
                response.sendRedirect(request.getContextPath() + "/paymentList");
                return;
            }

            request.setAttribute("paymentToUpdate", paymentToUpdate);
            request.getRequestDispatcher("paymentUpdateForm.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/paymentList");
        }
    }
}