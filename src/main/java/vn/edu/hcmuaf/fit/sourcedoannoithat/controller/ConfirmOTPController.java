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
            HttpSession session = request.getSession();
            String otp = request.getParameter("username");
            String email = request.getParameter("email");
            Integer failedAttempts = (Integer) session.getAttribute("failedAttempts");
            if (failedAttempts == null) {
                failedAttempts = 0;
            }

            Long lockTime = (Long) session.getAttribute("lockTime");
            if (lockTime != null) {
                long elapsedTime = (System.currentTimeMillis() - lockTime) / 1000;
                if (elapsedTime < 300) {
                    request.setAttribute("error", "Bạn đã nhập sai quá nhiều lần. Vui lòng thử lại sau " + (300 - elapsedTime) + " giây.");
                    request.getRequestDispatcher("ConfirmOTP.jsp").forward(request, response);
                    return;
                } else {
                    session.removeAttribute("lockTime");
                    session.setAttribute("failedAttempts", 0);
                    failedAttempts = 0;
                }
            }
            boolean isSuccess = registerDao.verifyOTP(email, otp);

            if (isSuccess) {
                session.removeAttribute("failedAttempts");
                session.removeAttribute("lockTime");
                request.setAttribute("success", "Đăng ký tài khoản thành công!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                failedAttempts++;
                session.setAttribute("failedAttempts", failedAttempts);
                if (failedAttempts >= 5) {
                    session.setAttribute("lockTime", System.currentTimeMillis());
                    request.setAttribute("error", "Bạn đã nhập sai quá 5 lần. Tài khoản bị khóa trong 5 phút.");
                } else {
                    request.setAttribute("error", "Mã OTP không đúng. Bạn còn " + (5 - failedAttempts) + " lần thử.");
                }

                request.getRequestDispatcher("ConfirmOTP.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}