package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.LoginDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProfileDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.User;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private LoginDao loginDao = new LoginDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}