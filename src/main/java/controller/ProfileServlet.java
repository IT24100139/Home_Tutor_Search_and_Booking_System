package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Tutor;
import model.User;
import service.ProfileService;

import java.io.IOException;

@WebServlet("/profile/*")
public class ProfileServlet extends HttpServlet {
    private final ProfileService profileService = new ProfileService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getPathInfo();

        if (action == null || action.equals("/")) {
            Tutor tutor = profileService.getTutorProfile(user.getId());
            request.setAttribute("tutor", tutor);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        } else if (action.equals("/edit")) {
            Tutor tutor = profileService.getTutorProfile(user.getId());
            request.setAttribute("tutor", tutor);
            request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getPathInfo();

        if (action.equals("/update")) {
            handleUpdateProfile(request, response, user.getId());
        } else if (action.equals("/delete")) {
            handleDeleteProfile(request, response, user.getId());
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response, String tutorId) throws IOException, ServletException {
        Tutor tutor = profileService.getTutorProfile(tutorId);

        tutor.setName(request.getParameter("name"));
        tutor.setPhone(request.getParameter("phone"));
        tutor.setAddress(request.getParameter("address"));
        tutor.setQualification(request.getParameter("qualification"));
        tutor.setSubjectExpertise(request.getParameter("subjectExpertise"));
        tutor.setHourlyRate(Double.parseDouble(request.getParameter("hourlyRate")));
        tutor.setExperienceYears(Integer.parseInt(request.getParameter("experienceYears")));
        tutor.setAvailability(request.getParameter("availability"));

        if (profileService.updateTutorProfile(tutor)) {
            request.setAttribute("success", "Profile updated successfully");
            request.setAttribute("tutor", tutor);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to update profile");
            request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
        }
    }

    private void handleDeleteProfile(HttpServletRequest request, HttpServletResponse response, String tutorId) throws IOException, ServletException {
        if (profileService.deleteTutorProfile(tutorId)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.setAttribute("error", "Failed to delete profile");
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        }
    }
}
