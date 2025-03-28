package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProfileDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Profile;

import java.io.IOException;

@WebServlet("/ChangePassW")
public class ChangePassWController extends HttpServlet {
    ProfileDao profileDao = new ProfileDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("application/json");

            HttpSession session = req.getSession();
            Integer idUser = (Integer) session.getAttribute("userIdLogin");
            if (idUser == null) {
                resp.sendRedirect("login.jsp");
                return;
            }
            String oldPW = req.getParameter("oldPassword");
            String newPW = req.getParameter("newPassword");
            boolean isOldPassWord = profileDao.checkOldPassW(oldPW, idUser);
            if (!isOldPassWord) {
                req.setAttribute("error", "Mật khẩu cũ không chính xác.");
                req.getRequestDispatcher("changePassword.jsp").forward(req, resp);
                return;
            }
            boolean isChangePassWord = profileDao.changePassw(newPW, idUser);
            if (isChangePassWord) {
                resp.sendRedirect("login.jsp");
            } else {
                req.setAttribute("error", "Đổi mật khẩu không thành công.");
                resp.sendRedirect("changePassword.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}