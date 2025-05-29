package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.LogDAO;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.LoginDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProfileDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.FBAccount;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.GoogleAccount;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Profile;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.RegisterModel;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    LogDAO logDAO = new LogDAO();
    private LoginDao loginDao = new LoginDao();
    private static final String SECRET_KEY = "6Lek8vsqAAAAAFPIGu-R9RS3RNck2axw1BWy3fU6";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String code = request.getParameter("code");
        String error = request.getParameter("error");
        if (error != null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        if (request.getParameter("provider") != null && request.getParameter("provider").equals("google")) {
            GoogleLogin gg = new GoogleLogin();
            String accessToken = gg.getToken(code);
            GoogleAccount acc = gg.getUserInfo(accessToken);
            boolean isUserExist = loginDao.isUserExist(acc.getEmail());
            //check tk da dky chua
            if (!isUserExist) {
                loginDao.addGoogleAccount(acc);
            }
            HttpSession session = request.getSession();
            session.setAttribute("googleAccount", acc);
            session.setAttribute("userEmail", acc.getEmail());
            session.setAttribute("userName", acc.getName());
            response.sendRedirect("index");
        }
        if (request.getParameter("provider") != null && request.getParameter("provider").equals("facebook")) {
            FacebookLogin fb = new FacebookLogin();
            String accessToken = fb.getToken(code);
            FBAccount acc = fb.getUserInfo(accessToken);
            boolean isUserExist = loginDao.isUserExist(acc.getEmail());
            if (!isUserExist) {
                loginDao.addFacebookAccount(acc);
            }
            HttpSession session = request.getSession();
            session.setAttribute("facebookAccount", acc);
            session.setAttribute("userEmail", acc.getEmail());
            session.setAttribute("userName", acc.getName());
            response.sendRedirect("index");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
        if (!verifyRecaptcha(gRecaptchaResponse)) {
            request.setAttribute("error", "Xác nhận reCAPTCHA thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

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
            int active = loginDao.getUserActive(username);
            session.setAttribute("active", active);
            boolean isValidUser = loginDao.checkLogin(loginModel);
            if (!isValidUser) {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            if (active == 1) {
                logDAO.insertLog(username, "alert", "login", "", "");
                session.setAttribute("loginModel", loginModel);
                Integer userId = loginDao.getIdByUsername(username);
                session.setAttribute("userIdLogin", userId);
                session.setAttribute("userNameAccount", username);
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
                    response.sendRedirect("mod.jsp");
                } else if (role == 2) {
                    response.sendRedirect("admin");
                } else {
                    response.sendRedirect("login.jsp");
                }
            } else if (active == 0) {
                response.sendRedirect("ConfirmOTP.jsp");
            } else if (active == -1) {
                response.sendRedirect("blockedaccount.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private boolean verifyRecaptcha(String gRecaptchaResponse) throws IOException {
        String url = "https://www.google.com/recaptcha/api/siteverify";
        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        // Dữ liệu cần gửi
        String postParams = "secret=" + SECRET_KEY + "&response=" + gRecaptchaResponse;
        // Gửi request với body
        try (OutputStream os = conn.getOutputStream()) {
            os.write(postParams.getBytes("UTF-8"));
            os.flush();
        }
        // Đọc phản hồi từ Google
        StringBuilder response = new StringBuilder();
        try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
        }
        // Parse JSON và kiểm tra kết quả
        JSONObject jsonResponse = new JSONObject(response.toString());
        return jsonResponse.getBoolean("success");
    }
}