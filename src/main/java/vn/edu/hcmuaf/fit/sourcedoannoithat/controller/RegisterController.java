package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.RegisterDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.RegisterModel;

import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private RegisterDao registerDao = new RegisterDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Set character encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            // Lấy thông tin từ form
            String fullName = request.getParameter("full_name");
            String birthDay = request.getParameter("birth_day");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phone_number");
            String address = request.getParameter("address");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm_password");

            // Kiểm tra dữ liệu hợp lệ
            String errorMessage = validateInput(fullName, birthDay, email, phoneNumber, address, username, password, confirmPassword);

            if (errorMessage != null) {
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Kiểm tra xem tài khoản đã tồn tại chưa
            if (!registerDao.checkAccountExists(username)) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Mã hóa mật khẩu
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // Tạo model với mật khẩu đã mã hóa
            RegisterModel user = new RegisterModel(fullName, birthDay, email, phoneNumber, address, username, hashedPassword);
            boolean isSuccess = registerDao.registerUser(user);

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
