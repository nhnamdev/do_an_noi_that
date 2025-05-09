package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProfileDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Profile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/updateProfile")
public class ProfileController extends HttpServlet {
    ProfileDao profileDao = new ProfileDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write("{\"status\": \"error\", \"message\": \"GET request is not allowed\"}");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("application/json");

            HttpSession session = req.getSession();
            Integer userId = (Integer) session.getAttribute("userIdLogin");

            String newName = req.getParameter("userNameInput");
            String newBirthday = req.getParameter("userBirthdayInput");
            String newNumberPhone = req.getParameter("userPhoneInput");
            String newAddress = req.getParameter("userAddressInput");
            String newEmail = req.getParameter("userEmailInput");

            String newDistrict = req.getParameter("district");
            String newProvince = req.getParameter("province");
            String fullAddress = newAddress + ", " + newDistrict + ", " + newProvince;

            // Lấy dữ liệu hiện tại từ session
            String currentName = (String) session.getAttribute("userName");
            String currentBirthday = (String) session.getAttribute("userBirthday");
            String currentNumberPhone = (String) session.getAttribute("userPhone");
            String currentAddress = (String) session.getAttribute("userAddress");
            String currentEmail = (String) session.getAttribute("userEmail");

            boolean isChanged =
                    (newName != null && !newName.equals(currentName)) ||
                            (newBirthday != null && !newBirthday.equals(currentBirthday)) ||
                            (newNumberPhone != null && !newNumberPhone.equals(currentNumberPhone)) ||
                            (newEmail != null && !newEmail.equals(currentEmail)) ||
                            (newProvince != null && !newProvince.isEmpty()) ||
                            (newDistrict != null && !newDistrict.isEmpty()) ||
                            (newAddress != null && !newAddress.equals(currentAddress));

            if (isChanged) {
                Profile profile = new Profile(newName, newBirthday, newNumberPhone, fullAddress, newEmail);
                boolean isUpdated = profileDao.updateProfile(profile, userId);

                if (isUpdated) {
                    session.setAttribute("userName", newName);
                    session.setAttribute("userBirthday", newBirthday);
                    session.setAttribute("userPhone", newNumberPhone);
                    session.setAttribute("userAddress", fullAddress);
                    session.setAttribute("userEmail", newEmail);

                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("status", "success");
                    JSONObject updatedUserJson = new JSONObject();
                    updatedUserJson.put("userName", newName);
                    updatedUserJson.put("userBirthday", newBirthday);
                    updatedUserJson.put("userPhone", newNumberPhone);
                    updatedUserJson.put("userAddress", fullAddress);
                    updatedUserJson.put("userEmail", newEmail);

                    jsonResponse.put("updatedUser", updatedUserJson);

                    resp.getWriter().write(jsonResponse.toString());
                } else {
                    resp.getWriter().write("{\"status\": \"error\", \"message\": \"Update failed\"}");
                }
            } else {
                // No changes detected
                resp.getWriter().write("{\"status\": \"info\", \"message\": \"No changes detected\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}
