package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.mod;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.DashboardDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.PaymentHistoryDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Invoice;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeModController", value = "/mod")
public class HomeModController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        DashboardDao dao = new DashboardDao();

        //        Payment history
        PaymentHistoryDao paymentHistoryDao = new PaymentHistoryDao();
        List<Invoice> listPaymentHistory = paymentHistoryDao.getAllPaymentInvoice();
        //        Payment history
        request.setAttribute("listPaymentHistory", listPaymentHistory);

        request.setAttribute("totalUsers", dao.getTotalUsers());
        request.setAttribute("totalOrders", dao.getTotalOrders());
        request.setAttribute("totalSales", dao.getTotalSales());
        request.setAttribute("totalActiveUsers", dao.getTotalActiveUsers());

        request.getRequestDispatcher("mod.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}