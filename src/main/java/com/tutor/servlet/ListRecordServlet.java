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

@WebServlet(name = "ListRecordsServlet", urlPatterns = {"/", "/list"})
public class ListRecordServlet extends HttpServlet {
    private DataStorage dataStorage;

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/records.txt");
        this.dataStorage = new DataStorage(filePath);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        List<Record> records = dataStorage.getAllRecords();
        request.setAttribute("records", records);
        request.getRequestDispatcher("list.jsp").forward(request, response);
    }
}