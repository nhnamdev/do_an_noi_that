package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.mod;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.NewsDAO;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;

@MultipartConfig
@WebServlet(name = "QuanLiTinTucController", value = "/mod/newsmanager")
public class QuanLiTinTucController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.getRequestDispatcher("newsmanager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String content = request.getParameter("content");
        String cateRaw = request.getParameter("category_id");
        int categoryId = Integer.parseInt(cateRaw); // nếu có select loại tin

        // Xử lý ảnh
        Part filePart = request.getPart("image");
        String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();

        // Thư mục lưu ảnh
        String uploadPath = request.getServletContext().getRealPath("/") + "tintuc";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        // Lưu file vào thư mục
        File file = new File(uploadDir, fileName);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, file.toPath());
        }

        // Lưu thông tin vào DB
        NewsDAO dao = new NewsDAO();
        dao.insertNews(title, description, content, "tintuc/" + fileName, categoryId);

        // Quay lại trang quản lý
        response.sendRedirect(request.getContextPath() + "/mod/newsmanager");
    }
}