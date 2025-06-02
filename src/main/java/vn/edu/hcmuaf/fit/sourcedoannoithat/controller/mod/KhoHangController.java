package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.mod;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product;
import vn.edu.hcmuaf.fit.sourcedoannoithat.utils.ConstantsStatic;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;

@MultipartConfig
@WebServlet(name = "KhoHangController", value = "/mod/khohang")
public class KhoHangController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        ProductDao productDao = new ProductDao();
        List<Product> listProduct = productDao.getAllProduct();

        request.setAttribute("listProduct", listProduct);
        request.getRequestDispatcher("khohang.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// Lấy dữ liệu từ form
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String description = request.getParameter("description");

        // detail
        String material = request.getParameter("material");
        String brand = request.getParameter("brand");
        String color = request.getParameter("color");
        double length = parseDouble(request.getParameter("length"));
        double width = parseDouble(request.getParameter("width"));
        double height = parseDouble(request.getParameter("height"));
        double weight = parseDouble(request.getParameter("weight"));
        String feature = request.getParameter("feature");

        // Xử lý ảnh chính
        Part filePart = request.getPart("image");
        String originalFileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();

        // Đường dẫn upload ảnh sản phẩm
        String uploadPath = ConstantsStatic.UPLOAD_PATH + "sanpham";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs(); // Tạo thư mục nếu chưa có

        // Lưu ảnh vào thư mục
        File file = new File(uploadDir, originalFileName);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        // Gọi DAO để lưu vào DB
        ProductDao dao = new ProductDao();
        dao.insertProductWithDetail(name, price, stock, originalFileName, description,
                material, brand, color, length, width, height, weight, feature);

        // Chuyển hướng về trang quản lý
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Thêm sản phẩm thành công!");
        response.sendRedirect(request.getContextPath() + "/mod/khohang");
    }

    private double parseDouble(String value) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            return 0;
        }

    }
}