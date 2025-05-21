package com.feedback.servlet;

import com.feedback.model.Feedback;
import com.feedback.util.FeedbackFileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/deleteFeedback")
public class DeleteFeedbackServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        List<Feedback> feedbacks = FeedbackFileHandler.loadFeedbacks();
        List<Feedback> updatedFeedbacks = feedbacks.stream()
                .filter(f -> f.getId() != id)
                .collect(Collectors.toCollection(LinkedList::new));

        FeedbackFileHandler.saveFeedbacks(updatedFeedbacks);
        request.getSession().setAttribute("message", "Feedback deleted successfully!");
        response.sendRedirect("listFeedbacks");
    }
}