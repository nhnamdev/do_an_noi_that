package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.LoginDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProfileDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.RegisterDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.RegisterModel;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Profile;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private LoginDao loginDao = new LoginDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (username == null || username.trim().isEmpty() ||
                    password == null || password.trim().isEmpty()) {

                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            RegisterModel loginModel = new RegisterModel(username, password);
            boolean isValidUser = loginDao.checkLogin(loginModel);

            if (isValidUser) {
                HttpSession session = request.getSession();
                session.setAttribute("loginModel", loginModel);
                Integer userId = loginDao.getIdByUsername(username);
                session.setAttribute("userIdLogin", userId);
                ProfileDao profileDao = new ProfileDao();
                Profile profile = profileDao.getProfile(userId);
                if (profile != null) {
                    session.setAttribute("userName", profile.getName());
                    session.setAttribute("userEmail", profile.getEmail());
                    session.setAttribute("userBirthday", profile.getBirthday());
                    session.setAttribute("userPhone", profile.getPhoneNumber());
                    session.setAttribute("userAddress", profile.getAddress());
                }

                int role = loginDao.getUserRole(username);
                session.setAttribute("role", role);

                if (role == 0) {
                    response.sendRedirect("index.jsp");
                } else if (role == 1) {
                    response.sendRedirect("admin");
                } else {
                    response.sendRedirect("login.jsp");
                }
            } else {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}