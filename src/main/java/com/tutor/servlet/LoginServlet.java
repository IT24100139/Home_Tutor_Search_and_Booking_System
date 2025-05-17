package com.tutor.servlet;

import com.tutor.model.Record;
import com.tutor.util.DataStorage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private DataStorage dataStorage;

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/records.txt");
        this.dataStorage = new DataStorage(filePath);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        List<Record> records = dataStorage.getAllRecords();

        for (Record record : records) {
            if (record.getEmail().equals(email) && record.getPassword().equals(password)) {
                request.getSession().setAttribute("user", record);
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }
        }

        request.setAttribute("errorMessage", "Invalid email or password");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}