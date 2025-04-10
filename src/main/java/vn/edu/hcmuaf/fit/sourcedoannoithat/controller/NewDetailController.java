package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.NewsDAO;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.News;

import java.io.IOException;

@WebServlet(name = "NewDetailController", value = "/NewDetailController")
public class NewDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        NewsDAO news = new NewsDAO();
        News news1 = news.getNewsByID(id);

        request.setAttribute("news", news1);
        request.getRequestDispatcher("newsDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}