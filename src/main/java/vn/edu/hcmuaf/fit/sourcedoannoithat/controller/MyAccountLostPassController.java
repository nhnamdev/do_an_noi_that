package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.MyAccountLostPassDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.RegisterDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.utils.EmailUtility;
import vn.edu.hcmuaf.fit.sourcedoannoithat.utils.PasswordGenerator;

import javax.mail.MessagingException;
import java.io.IOException;

@WebServlet("/forgot-password")
public class MyAccountLostPassController extends HttpServlet {
    private MyAccountLostPassDao lostPassDao = new MyAccountLostPassDao();
    private RegisterDao registerDao = new RegisterDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String otp = request.getParameter("otp");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập email!");
            request.getRequestDispatcher("my_account_lostpass.jsp").forward(request, response);
            return;
        }

        if (!lostPassDao.isEmailExist(email)) {
            request.setAttribute("error", "Email không tồn tại trong hệ thống!");
            request.getRequestDispatcher("my_account_lostpass.jsp").forward(request, response);
            return;
        }
        if (otp == null || otp.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập mã OTP!");
            request.getRequestDispatcher("my_account_lostpass.jsp").forward(request, response);
            return;
        }

        // Sinh mật khẩu ngẫu nhiên
        String newPassword = PasswordGenerator.generateRandomPassword();
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        // Cập nhật mật khẩu trong DB
        boolean isSuccess = lostPassDao.updatePassword(email, hashedPassword);

        if (isSuccess) {
            try {
                // Gửi mật khẩu mới qua email
                String subject = "Mật khẩu mới của bạn";
                String content = "Xin chào,\n\nMật khẩu mới của bạn là: " + newPassword + "\n\nVui lòng đăng nhập và thay đổi mật khẩu!";
                EmailUtility.sendEmail(email, subject, content);

                request.setAttribute("success", "Mật khẩu mới đã được gửi tới email của bạn!");
                request.getRequestDispatcher("login.jsp").forward(request, response);

            } catch (MessagingException e) {
                e.printStackTrace();
                request.setAttribute("error", "Không thể gửi email. Vui lòng thử lại!");
                request.getRequestDispatcher("my_account_lostpass.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại!");
            request.getRequestDispatcher("my_account_lostpass.jsp").forward(request, response);
        }
    }
}
