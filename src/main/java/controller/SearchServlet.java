package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Tutor;
import service.SearchService;

import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private final SearchService searchService = new SearchService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String subject = request.getParameter("subject");

        if (subject == null || subject.isEmpty()) {
            List<Tutor> tutors = searchService.getAllTutorsSorted();
            request.setAttribute("tutors", tutors);
        } else {
            List<Tutor> tutors = searchService.searchTutorsBySubject(subject);
            request.setAttribute("tutors", tutors);
            request.setAttribute("searchSubject", subject);
        }

        request.getRequestDispatcher("/searchResults.jsp").forward(request, response);
    }
}
