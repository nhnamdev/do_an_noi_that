package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.NewsDAO;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.News;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "NewsController", value = "/news")
public class NewsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NewsDAO dao = new NewsDAO();
        List<News> listNew = dao.getAllNews();
        request.setAttribute("listNews", listNew);
        request.getRequestDispatcher("news.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}