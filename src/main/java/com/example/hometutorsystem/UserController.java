
package com.example.hometutorsystem;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.*;

@WebServlet("/user")
public class UserController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("register".equals(action)) {
                String id = UUID.randomUUID().toString();
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String role = request.getParameter("role");

                User user = new User(id, username, password, email, phone, role);

                List<String> lines = FileUtil.readLines();
                for (String line : lines) {
                    User existing = User.fromCSV(line);
                    if (existing != null && existing.getUsername().equals(user.getUsername())) {
                        throw new Exception("Username already exists.");
                    }
                }

                lines.add(user.toCSV());
                FileUtil.writeLines(lines);
                response.sendRedirect("login.jsp");

            } else if ("login".equals(action)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                for (String line : FileUtil.readLines()) {
                    User user = User.fromCSV(line);
                    if (user != null && user.getUsername().equals(username) && user.getPassword().equals(password)) {
                        request.getSession().setAttribute("user", user);
                        response.sendRedirect("viewProfile.jsp");
                        return;
                    }
                }

                throw new Exception("Invalid credentials.");

            } else if ("update".equals(action)) {
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");

                user.setEmail(request.getParameter("email"));
                user.setPhone(request.getParameter("phone"));
                user.setPassword(request.getParameter("password"));

                List<String> lines = FileUtil.readLines();
                for (int i = 0; i < lines.size(); i++) {
                    if (lines.get(i).startsWith(user.getId())) {
                        lines.set(i, user.toCSV());
                        break;
                    }
                }

                FileUtil.writeLines(lines);
                response.sendRedirect("viewProfile.jsp");

            } else if ("delete".equals(action)) {
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");

                List<String> lines = FileUtil.readLines();
                lines.removeIf(line -> line.startsWith(user.getId()));

                FileUtil.writeLines(lines);
                session.invalidate();
                response.sendRedirect("register.jsp");
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
