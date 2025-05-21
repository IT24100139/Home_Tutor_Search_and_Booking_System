package com.tutor.servlet;

import com.tutor.model.Admin;
import com.tutor.util.DataStorage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "ListRecordsServlet", urlPatterns = {"/", "/list"})
public class ListRecordServlet extends HttpServlet {
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

        Admin user = (Admin) request.getSession().getAttribute("user");
        request.setAttribute("currentUserRole", user != null ? user.getRole() : null);

        List<Admin> records = dataStorage.getAllRecords();

        // Search filter only
        String searchTerm = request.getParameter("search");
        if (searchTerm != null && !searchTerm.isEmpty()) {
            String finalSearch = searchTerm.toLowerCase();
            records = records.stream()
                    .filter(r -> r.getName().toLowerCase().contains(finalSearch))
                    .collect(Collectors.toList());
        }

        request.setAttribute("records", records);
        request.getRequestDispatcher("list.jsp").forward(request, response);
    }
}