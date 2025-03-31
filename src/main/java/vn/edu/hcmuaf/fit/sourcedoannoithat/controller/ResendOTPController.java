package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.LoginDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.RegisterDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.utils.EmailUtility;

import javax.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/resendOTP")
public class ResendOTPController extends HttpServlet {
    private RegisterDao registerDao = new RegisterDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email").trim();
        String username = (String) request.getSession().getAttribute("userNameAccount");
        if (email.isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().print("{\"success\": false, \"message\": \"Email không hợp lệ.\"}");
            return;
        }
        String newOtp = EmailUtility.generateOTP();

        boolean isUpdated = registerDao.updateOTP(email, newOtp);
        boolean isSent = false;
            if (isUpdated) {
                try {
                    EmailUtility.sendOTP(email, newOtp);
                    isSent = true;
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            if (isUpdated && isSent) {
                out.print("{\"success\": true}");
            } else {
                out.print("{\"success\": false, \"message\": \"Không thể gửi mã OTP\"}");
            }
            out.flush();
        }
}