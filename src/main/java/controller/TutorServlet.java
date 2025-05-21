package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Tutor;
import service.TutorService;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/tutors/*")
public class TutorServlet extends HttpServlet {
    private final TutorService tutorService = new TutorService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all tutors
            List<Tutor> tutors = tutorService.getAllTutors();
            request.setAttribute("tutors", tutors);
            request.getRequestDispatcher("/tutorsList.jsp").forward(request, response);
        } else {
            // Get tutor by ID
            String tutorId = pathInfo.substring(1);
            Tutor tutor = tutorService.getTutorById(tutorId);
            if (tutor != null) {
                request.setAttribute("tutor", tutor);
                request.getRequestDispatcher("/tutorDetails.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }
}
