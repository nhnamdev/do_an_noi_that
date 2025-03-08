package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ContactDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ReturnProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Contact;

import java.io.IOException;

@WebServlet("/contact")
public class ContactController extends HttpServlet {
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
            boolean isSuccess = contactDao.createContact(contact);
            if (isSuccess) {
                resp.sendRedirect("index.jsp");
            } else {
                resp.sendRedirect("contact.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("Có lỗi xảy ra: " + e.getMessage());
        }
    }
}
