package com.tutor.servlet;

import com.tutor.util.DataStorage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/delete")
public class DeleteRecordServlet extends HttpServlet {
    private DataStorage dataStorage;

    @Override
    public void init() throws ServletException {
        String filePath = "F:\\sliit\\1st year\\2 sem\\Object Oriented Programming - SE1020\\project\\sample\\HTB_Admin\\src\\main\\webapp\\records.txt";
        this.dataStorage = new DataStorage(filePath);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            dataStorage.deleteRecord(id);
        } catch (IOException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/");
    }
}