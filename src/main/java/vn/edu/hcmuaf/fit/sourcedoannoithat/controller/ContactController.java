package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ContactDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ReturnProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Contact;
import vn.edu.hcmuaf.fit.sourcedoannoithat.utils.EmailUtility;

import java.io.IOException;

@WebServlet("/contact")
public class ContactController extends HttpServlet {
    private static final String TO_EMAIL = "hominhhai2k4@gmail.com";
    private ContactDao contactDao = new ContactDao();

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String topic = req.getParameter("subject");
            String content = req.getParameter("message");

            Contact contact = new Contact(name, email, topic, content);
            boolean isSaved = contactDao.createContact(contact);
            if (isSaved) {
                String subject = (topic != null && !topic.isEmpty() ? topic : email + "đã gửi một lời nhắn nè");
                String body = "Bạn nhận được một liên hệ mới từ khách hàng:\n\n"
                        + "Họ tên: " + name + "\n"
                        + "Email: " + email + "\n"
                        + "Chủ đề: " + topic + "\n"
                        + "Nội dung:\n" + content;

                EmailUtility.sendEmail(TO_EMAIL, subject, body);
                req.setAttribute("message", "Thông tin của bạn đã được gửi và lưu thành công. Cảm ơn bạn!");
                req.getRequestDispatcher("contact.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Đã gửi email nhưng không lưu được thông tin.");
                req.getRequestDispatcher("contact.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi gửi email. Vui lòng thử lại sau.");
            req.getRequestDispatcher("contact").forward(req, resp);
        }
    }
}
