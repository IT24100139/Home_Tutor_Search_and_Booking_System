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

@WebServlet("/invoice")
public class InvoiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Load payments from file
        String filePath = getServletContext().getRealPath("/WEB-INF/payments.txt");
        List<Payment> payments = PaymentFileHandler.loadPayments(filePath);

        // ✅ Pass to JSP
        request.setAttribute("payments", payments);

        // ✅ Forward to the JSP
        request.getRequestDispatcher("invoice.jsp").forward(request, response);
    }
}
