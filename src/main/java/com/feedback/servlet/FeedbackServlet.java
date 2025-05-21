package com.feedback.servlet;

import com.feedback.model.Feedback;
import com.feedback.util.FeedbackFileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the feedback form JSP
        request.getRequestDispatcher("/WEB-INF/feedbackForm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Validate input
        if (name == null || name.isEmpty() || email == null || email.isEmpty()) {
            request.setAttribute("error", "Name and email are required");
            doGet(request, response);
            return;
        }

        // Create and save feedback
        Feedback feedback = new Feedback();
        feedback.setName(name);
        feedback.setEmail(email);
        feedback.setSubject(subject);
        feedback.setMessage(message);

        FeedbackFileHandler.addFeedback(feedback);

        // Set success message
        request.getSession().setAttribute("message", "Feedback submitted successfully!");

        // Redirect to the feedback list
        response.sendRedirect(request.getContextPath() + "/listFeedbacks");
    }
}