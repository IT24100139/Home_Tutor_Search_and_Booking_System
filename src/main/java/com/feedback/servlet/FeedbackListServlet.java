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

@WebServlet("/listFeedbacks")
public class FeedbackListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Load feedbacks from file
        List<Feedback> feedbacks = FeedbackFileHandler.loadFeedbacks();

        // Set attributes for JSP
        request.setAttribute("feedbacks", feedbacks);

        // Check for messages
        String message = (String) request.getSession().getAttribute("message");
        if (message != null) {
            request.setAttribute("message", message);
            request.getSession().removeAttribute("message");
        }

        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/feedbackList.jsp").forward(request, response);
    }
}