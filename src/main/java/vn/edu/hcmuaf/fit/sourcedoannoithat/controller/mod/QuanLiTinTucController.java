package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.mod;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.NewsDAO;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.News;
import vn.edu.hcmuaf.fit.sourcedoannoithat.utils.ConstantsStatic;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;

@MultipartConfig
@WebServlet(name = "QuanLiTinTucController", value = "/mod/newsmanager")
public class QuanLiTinTucController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NewsDAO dao = new NewsDAO();
        List<News> listNew = dao.getAllNews();
        request.setAttribute("listNews", listNew);
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
        // Lấy file từ form
        Part filePart = request.getPart("image");
        String originalFileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString(); // tên gốc

        // Đường dẫn upload (giữ nguyên như cũ hoặc cập nhật tương đối nếu muốn)
        String uploadPath = ConstantsStatic.UPLOAD_PATH + "tintuc";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs(); // tạo thư mục nếu chưa có

        // Lưu file (ghi đè nếu trùng tên)
        File file = new File(uploadDir, originalFileName);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING); // cho phép ghi đè
        }
        // Lưu vào DB
        NewsDAO dao = new NewsDAO();
        dao.insertNews(title, description, content, originalFileName, categoryId);


        // Quay lại trang quản lý
        response.sendRedirect(request.getContextPath() + "/mod/newsmanager");
    }
}