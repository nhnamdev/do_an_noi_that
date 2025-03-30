package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.mindrot.jbcrypt.BCrypt;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.RegisterDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.RegisterModel;
import vn.edu.hcmuaf.fit.sourcedoannoithat.utils.EmailUtility;

import javax.mail.MessagingException;
import java.io.IOException;

@WebServlet("/confirm")
public class ConfirmOTPController extends HttpServlet {
    private RegisterDao registerDao = new RegisterDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        try {
            String otp = request.getParameter("username");
            String email = (String) request.getSession().getAttribute("registeredEmail");
            boolean isSuccess = registerDao.verifyOTP(email, otp);

            if (isSuccess) {
                request.setAttribute("success", "Đăng ký tài khoản thành công!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}