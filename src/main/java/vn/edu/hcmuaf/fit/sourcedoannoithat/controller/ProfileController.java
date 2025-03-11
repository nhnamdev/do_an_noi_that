package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProfileDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Profile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/index")
public class ProfileController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");
            HttpSession session = req.getSession();
            Integer userId = (Integer) session.getAttribute("userIdLogin");

            String name = req.getParameter("userNameInput");
            String birthday = req.getParameter("userBirthdayInput");
            String numberPhone = req.getParameter("userPhoneInput");
            String address = req.getParameter("userAddressInput");
            String email = req.getParameter("userEmailInput");

            Profile profile = new Profile(name, birthday, numberPhone, address, email);
            ProfileDao profileDao = new ProfileDao();
            boolean isUpdated = profileDao.updateProfile(profile, userId);

            if (isUpdated) {
                resp.sendRedirect("index.jsp");
            } else {
                resp.sendRedirect("personal.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("Có lỗi xảy ra: " + e.getMessage());
        }
    }
}
