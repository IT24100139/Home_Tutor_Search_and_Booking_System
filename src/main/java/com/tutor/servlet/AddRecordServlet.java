package com.tutor.servlet;

import com.tutor.model.Admin;
import com.tutor.model.AdminUser;
import com.tutor.model.EditorUser;
import com.tutor.util.DataStorage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/add")
public class AddRecordServlet extends HttpServlet {
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

        request.getRequestDispatcher("add.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Admin user = (Admin) request.getSession().getAttribute("user");
        if (user == null || !"Admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/list");
            return;
        }

        String role = request.getParameter("role");
        Admin newAdmin;
        int newId = dataStorage.generateNewId();
        if ("Editor".equals(role)) {
            newAdmin = new EditorUser(
                    newId,
                    request.getParameter("name"),
                    request.getParameter("email"),
                    request.getParameter("password")
            );
        } else {
            newAdmin = new AdminUser(
                    newId,
                    request.getParameter("name"),
                    request.getParameter("email"),
                    request.getParameter("password"),
                    role
            );
        }

        try {
            dataStorage.addRecord(newAdmin);
        } catch (IOException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/list");
    }
}