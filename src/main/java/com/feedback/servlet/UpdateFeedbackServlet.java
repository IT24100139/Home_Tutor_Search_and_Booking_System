package com.feedback.servlet;

import com.feedback.model.Feedback;
import com.feedback.util.FeedbackFileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/updateFeedback")
public class UpdateFeedbackServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        List<Feedback> feedbacks = FeedbackFileHandler.loadFeedbacks();

        Feedback feedbackToUpdate = feedbacks.stream()
                .filter(f -> f.getId() == id)
                .findFirst()
                .orElse(null);

        if (feedbackToUpdate != null) {
            request.setAttribute("feedback", feedbackToUpdate);
            request.getRequestDispatcher("/WEB-INF/updateFeedback.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("message", "Feedback not found!");
            response.sendRedirect("listFeedbacks");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        List<Feedback> feedbacks = FeedbackFileHandler.loadFeedbacks();

        for (Feedback feedback : feedbacks) {
            if (feedback.getId() == id) {
                feedback.setName(name);
                feedback.setEmail(email);
                feedback.setSubject(subject);
                feedback.setMessage(message);
                break;
            }
        }

        FeedbackFileHandler.saveFeedbacks(feedbacks);
        request.getSession().setAttribute("message", "Feedback updated successfully!");
        response.sendRedirect("listFeedbacks");
    }
}