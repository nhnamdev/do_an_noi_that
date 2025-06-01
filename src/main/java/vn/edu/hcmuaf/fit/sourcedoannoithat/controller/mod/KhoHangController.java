
package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.mod;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.NewsDAO;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.ProductDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.News;
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
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String description = request.getParameter("description");

        Part filePart = request.getPart("image");
        String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = request.getServletContext().getRealPath("/uploads");

        // Tạo thư mục nếu chưa có
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        File file = new File(uploadDir, fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        Product product = new Product();
        product.setName(name);
        product.setPrice(Double.parseDouble(priceStr));
        product.setStock(Integer.parseInt(stockStr));
        product.setQuantitySold(0); // sản phẩm mới chưa có bán
        product.setImg("uploads/" + fileName);


        ProductDao dao = new ProductDao();
        //dao.insert(product); // đảm bảo bạn đã có hàm insert(Product)

        response.sendRedirect(request.getContextPath() + "/mod/khohang");
    }}