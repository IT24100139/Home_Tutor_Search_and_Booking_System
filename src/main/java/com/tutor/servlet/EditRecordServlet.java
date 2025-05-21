package com.tutor.servlet;

import com.tutor.model.Admin;
import com.tutor.util.DataStorage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/edit")
public class EditRecordServlet extends HttpServlet {
    private DataStorage dataStorage;

    @Override
    public void init() throws ServletException {
        String filePath = "F:\\sliit\\1st year\\2 sem\\Object Oriented Programming - SE1020\\project\\Final real project\\HTBT-Admin CRUD\\src\\main\\webapp\\records.txt";
        this.dataStorage = new DataStorage(filePath);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        Admin record = dataStorage.getAllRecords().stream()
                .filter(r -> r.getId() == id)
                .findFirst()
                .orElse(null);
        request.setAttribute("record", record);
        request.getRequestDispatcher("edit.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Admin user = (Admin) request.getSession().getAttribute("user");
        if (user == null || !"Admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/list");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String newRole = request.getParameter("role");

        try {
            dataStorage.updateRecordRole(id, newRole); // Let DataStorage handle Editor-to-Admin conversion
        } catch (IOException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Failed to update role");
        }
        response.sendRedirect(request.getContextPath() + "/list");
    }
}