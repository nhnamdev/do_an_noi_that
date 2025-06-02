package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/orderInformation")
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
