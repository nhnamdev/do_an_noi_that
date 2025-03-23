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
    // ✅ Hàm kiểm tra dữ liệu đầu vào bằng Regex
    private String validateInput(String fullName, String birthDay, String email, String phoneNumber, String address, String username, String password, String confirmPassword) {
        Pattern nameRegex = Pattern.compile("^[A-Za-zÀ-Ỹà-ỹ\\s]{2,}$");
        Pattern birthDateRegex = Pattern.compile("^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[0-2])[-/.](19|20)\\d{2}$");
        Pattern emailRegex = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
        Pattern phoneRegex = Pattern.compile("^0\\d{9}$");
//        Pattern addressRegex = Pattern.compile("^[A-Za-z0-9\\s,.-]{5,}$");
        Pattern usernameRegex = Pattern.compile("^[a-zA-Z0-9_]{5,20}$");
        Pattern passwordRegex = Pattern.compile("^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{6,}$");

        if (!nameRegex.matcher(fullName).matches()) return "Họ và tên không hợp lệ!";
        if (!birthDateRegex.matcher(birthDay).matches()) return "Ngày sinh phải có định dạng dd/mm/yyyy.";
        if (!emailRegex.matcher(email).matches()) return "Email không hợp lệ!";
        if (!phoneRegex.matcher(phoneNumber).matches()) return "Sdt phải có 10 chữ số và bắt đầu bằng 0!";
        if (!usernameRegex.matcher(username).matches()) return "Tên đăng nhập không hợp lệ!";
//        if (!usernameRegex.matcher(username).matches()) return "Tên đăng nhập từ 5-20 ký tự, chỉ chứa chữ, số, dấu gạch dưới!";
        if (!passwordRegex.matcher(password).matches()) return "Mật khẩu không hợp lệ!";
//        if (!passwordRegex.matcher(password).matches()) return "Mật khẩu phải có ít nhất 6 ký tự, 1 chữ hoa, 1 số, 1 ký tự đặc biệt!";
        if (!password.equals(confirmPassword)) return "Mật khẩu xác nhận không khớp!";

        return null; // Không có lỗi
    }

}
