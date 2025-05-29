package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.VNPay;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.OrderDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.service.VNPayService;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/vnpayReturn")
public class VNPayReturnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    OrderDao orderDao = new OrderDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        VNPayService Config = new VNPayService();
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements(); ) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
            if (signValue.equals(vnp_SecureHash)) {
                String paymentCode = request.getParameter("vnp_TransactionNo");

                String orderId = request.getParameter("vnp_TxnRef");

//                Order order = new Order();
//                order.setId(Integer.parseInt(orderId));
//
//                boolean transSuccess = false;
//                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
//                    //update banking system
//                    order.setStatus("Completed");
//                    transSuccess = true;
//                } else {
//                    order.setStatus("Failed");
//                }
//                orderDao.updateOrderStatus(order);
//                request.setAttribute("transResult", transSuccess);
                request.getRequestDispatcher("paymentResult.jsp").forward(request, response);
            } else {
                //RETURN PAGE ERROR
                System.out.println("GD KO HOP LE (invalid signature)");
            }
        }
    }
}