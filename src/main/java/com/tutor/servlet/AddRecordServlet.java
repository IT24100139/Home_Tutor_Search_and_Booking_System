package com.tutor.servlet;

import com.tutor.model.Admin;
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
        String filePath = "F:\\sliit\\1st year\\2 sem\\Object Oriented Programming - SE1020\\project\\sample\\HTB_Admin\\src\\main\\webapp\\records.txt";
        this.dataStorage = new DataStorage(filePath);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Admin newAdmin = new Admin(
                dataStorage.generateNewId(),
                request.getParameter("name"),
                request.getParameter("email"),
                request.getParameter("password"),
                request.getParameter("role")
        );

        try {
            dataStorage.addRecord(newAdmin);
        } catch (IOException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/list");
    }
}