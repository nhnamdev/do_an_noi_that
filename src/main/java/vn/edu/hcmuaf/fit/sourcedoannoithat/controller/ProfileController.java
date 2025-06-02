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

            String provinceId = req.getParameter("provinceId");
            String provinceName = req.getParameter("provinceName");
            String districtId = req.getParameter("districtId");
            String districtName = req.getParameter("districtName");
            String wardCode = req.getParameter("wardCode");
            String wardName = req.getParameter("wardName");
            String fullAddress = req.getParameter("fullAddress");

            String currentName = (String) session.getAttribute("userName");
            String currentBirthday = (String) session.getAttribute("userBirthday");
            String currentNumberPhone = (String) session.getAttribute("userPhone");
            String currentAddress = (String) session.getAttribute("userAddress");
            String currentEmail = (String) session.getAttribute("userEmail");

            String finalAddress;
            if (fullAddress != null && !fullAddress.trim().isEmpty()) {
                finalAddress = fullAddress;
            } else if (newAddress != null && !newAddress.trim().isEmpty()) {
                if (currentAddress != null && currentAddress.contains(", ")) {
                    String[] parts = currentAddress.split(", ");
                    if (parts.length >= 4) {
                        finalAddress = newAddress + ", " + parts[parts.length - 3] + ", " + parts[parts.length - 2] + ", " + parts[parts.length - 1];
                    } else {
                        finalAddress = newAddress;
                    }
                } else {
                    finalAddress = newAddress;
                }
            } else {
                finalAddress = currentAddress;
            }

            boolean isChanged =
                    (newName != null && !newName.equals(currentName)) ||
                            (newBirthday != null && !newBirthday.equals(currentBirthday)) ||
                            (newNumberPhone != null && !newNumberPhone.equals(currentNumberPhone)) ||
                            (newEmail != null && !newEmail.equals(currentEmail)) ||
                            (finalAddress != null && !finalAddress.equals(currentAddress));

            if (isChanged) {
                Profile profile = new Profile(newName, newBirthday, newNumberPhone, finalAddress, newEmail);
                boolean isUpdated = profileDao.updateProfile(profile, userId);

                if (isUpdated) {
                    session.setAttribute("userName", newName);
                    session.setAttribute("userBirthday", newBirthday);
                    session.setAttribute("userPhone", newNumberPhone);
                    session.setAttribute("userAddress", finalAddress);
                    session.setAttribute("userEmail", newEmail);

                    if (provinceId != null && !provinceId.trim().isEmpty()) {
                        session.setAttribute("provinceId", provinceId);
                        session.setAttribute("provinceName", provinceName);
                        session.setAttribute("districtId", districtId);
                        session.setAttribute("districtName", districtName);
                        session.setAttribute("wardCode", wardCode);
                        session.setAttribute("wardName", wardName);
                    }

                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("status", "success");
                    JSONObject updatedUserJson = new JSONObject();
                    updatedUserJson.put("userName", newName);
                    updatedUserJson.put("userBirthday", newBirthday);
                    updatedUserJson.put("userPhone", newNumberPhone);
                    updatedUserJson.put("userAddress", finalAddress);
                    updatedUserJson.put("userEmail", newEmail);

                    jsonResponse.put("updatedUser", updatedUserJson);
                    resp.getWriter().write(jsonResponse.toString());
                } else {
                    resp.getWriter().write("{\"status\": \"error\", \"message\": \"Update failed\"}");
                }
            } else {
                resp.getWriter().write("{\"status\": \"info\", \"message\": \"No changes detected\"}");
            }
        } catch (Exception e) {
            resp.getWriter().write("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}