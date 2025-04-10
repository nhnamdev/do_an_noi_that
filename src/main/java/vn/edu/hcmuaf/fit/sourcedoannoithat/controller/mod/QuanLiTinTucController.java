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

//        Vì đây không phải môi trường deploy nên mặc định tomcat sẽ lưu vào ổ đĩa C.
//        Phần này phải setup theo máy thì mới chạy được source lưu chỗ nào thì ảnh sẽ luôn ở đó
        Part filePart = request.getPart("image");
        String originalFileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();

// Tạo file name duy nhất
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String baseName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
        String uniqueFileName = baseName + "_" + System.currentTimeMillis() + fileExtension;

// Đường dẫn upload
        String uploadPath = "D:\\a_hk2_nam3\\TTWEB\\Project\\do_an_noi_that\\src\\main\\webapp\\img\\tintuc";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

// Lưu file
        File file = new File(uploadDir, uniqueFileName);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, file.toPath());
        }

// Lưu vào DB
        NewsDAO dao = new NewsDAO();
        dao.insertNews(title, description, content, uniqueFileName, categoryId);


        // Quay lại trang quản lý
        response.sendRedirect(request.getContextPath() + "/mod/newsmanager");
    }
}