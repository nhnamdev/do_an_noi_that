package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/admin")
public class AdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        ReturnProductDao returnProductDao = new ReturnProductDao();
        List<ReturnProduct> list = returnProductDao.getReturnProduct();

        String date = req.getParameter("filterDate");
        ContactDao contactDao = new ContactDao();
        List<Contact> contact = new ArrayList<>();

        if (date != null && !date.trim().isEmpty()) {
            contact = contactDao.getContactsByDate(date);
        } else {
            req.setAttribute("errorMessage", "Vui lòng chọn một ngày để lọc phản hồi.");
        }
        List<String> names = contactDao.getName();

        WarrantyProductDao warrantyProductDao = new WarrantyProductDao();
        List<WarrantyProduct> warrantyProduct = warrantyProductDao.getListWarrantyProduct();

        SearchDao searchDao = new SearchDao();
        List<ProductShop> listP = searchDao.getAllProducts();

        ProfileDao profileDao = new ProfileDao();
        List<AccountManagement> profile = profileDao.getAccountAdmin();

        String selectedName = req.getParameter("name");
        List<String> content = contactDao.getContentByName(selectedName);

        OrderDao orderDao = new OrderDao();
        List<Order> order = orderDao.getListOrder();

        req.setAttribute("selectedContent", content);
        req.setAttribute("warranty", warrantyProduct);
        req.setAttribute("profile", profile);
        req.setAttribute("listP", listP);
        req.setAttribute("order", order);
        req.setAttribute("names", names);
        req.setAttribute("contact", contact);
        req.setAttribute("product", list);

        req.getRequestDispatcher("admin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String pid = req.getParameter("pid");
        String name = req.getParameter("name");

        String nameProduct = req.getParameter("name");
        String priceStr = req.getParameter("price");
        String image = req.getParameter("image");

        if (nameProduct != null && priceStr != null && image != null) {
            try {
                double price = Double.parseDouble(priceStr);
                ProductShop newProduct = new ProductShop(nameProduct, price, image, 0);
                SearchDao searchDao = new SearchDao();
                ProductShop addedProduct = searchDao.addProduct(newProduct);

                if (addedProduct != null) {
                    req.setAttribute("successMessage", "Sản phẩm đã được thêm thành công!");
                } else {
                    req.setAttribute("errorMessage", "Không thể thêm sản phẩm.");
                }
            } catch (NumberFormatException e) {
                req.setAttribute("errorMessage", "Giá không hợp lệ.");
            }
        } else {
            req.setAttribute("errorMessage", "Thông tin sản phẩm không đầy đủ.");
        }
        if (pid != null) {
            try {
                int orderId = Integer.parseInt(pid);
                OrderDao orderDao = new OrderDao();
                orderDao.updatePending(name, orderId);
            } catch (NumberFormatException e) {
                req.setAttribute("errorMessage", "Mã đơn hàng không hợp lệ.");
            }
        }
        doGet(req, resp);
    }
}
