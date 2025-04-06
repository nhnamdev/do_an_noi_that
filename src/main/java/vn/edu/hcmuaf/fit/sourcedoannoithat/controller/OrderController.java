package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.OrderDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Contact;

import java.io.IOException;
import java.util.List;

@WebServlet("/oderInformation")
public class OrderController extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        req.setCharacterEncoding("UTF-8");
//        resp.setCharacterEncoding("UTF-8");
//        HttpSession session = req.getSession();
//        Integer userId = (Integer) session.getAttribute("userIdLogin");
//        OrderDao orderDao = new OrderDao();
//        List<Order> list =orderDao.getOrderByUserName(userId);
//
//        req.setAttribute("orderList", list);
//        req.getRequestDispatcher("oderInformation.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }
}
