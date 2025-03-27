package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.db.DBConnect;

import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "HomeController", value = "/index")
public class HomeController extends HttpServlet {
    DBConnect db = new DBConnect();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DBConnect dbConnect
                    = new
                    DBConnect(); Connection
                    connection =
                    dbConnect.getConnection(); if
            (connection !=
                            null) {
                request.getRequestDispatcher("index.jsp").forward(request,
                        response);
            }
            else {
                request.getRequestDispatcher("errorDb.jsp").forward(request,
                        response);
            }
        } catch (Exception e) {

            request.getRequestDispatcher("errorDb.jsp").forward(request,
                    response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}