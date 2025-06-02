package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.mod;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;

import java.io.IOException;

@WebServlet(name = "XoaSanPham", value = "/mod/newsmanager/xoasanpham")
public class XoaSanPham extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idRaw = request.getParameter("id");
        try {
            int id = Integer.parseInt(idRaw);
            ProductDao dao = new ProductDao();
            boolean deleted = dao.deleteProductById(id);

            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/mod/khohang");
            } else {
                response.sendRedirect(request.getContextPath() + "/mod/khohang");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/mod/khohang");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}