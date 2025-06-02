package vn.edu.hcmuaf.fit.sourcedoannoithat.controller.VNPay;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.OrderDao;
import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Invoice;
import vn.edu.hcmuaf.fit.sourcedoannoithat.service.VNPayService;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/payment")
public class VNPayController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // ✅ Kiểm tra phương thức thanh toán
        String paymentMethod = req.getParameter("payment");

        if ("cod".equals(paymentMethod)) {
            // Chuyển đến CheckoutController để xử lý COD
            req.getRequestDispatcher("/checkout/").forward(req, resp);
            return;
        }

        // ✅ VNPay: Lưu thông tin vào session, không tạo order ngay
        String totalBillStr = req.getParameter("totalBill");

        if (totalBillStr == null) {
            resp.sendRedirect("cart");
            return;
        }

        double totalBillDouble = Double.parseDouble(totalBillStr);

        // ✅ THAY ĐỔI: Lưu thông tin order vào session thay vì tạo order ngay
        Map<String, String> orderInfo = new HashMap<>();
        orderInfo.put("fullname", req.getParameter("fullname"));
        orderInfo.put("phone", req.getParameter("phone"));
        orderInfo.put("address", req.getParameter("address"));
        orderInfo.put("district", req.getParameter("district"));
        orderInfo.put("province", req.getParameter("province"));
        orderInfo.put("ward", req.getParameter("ward"));
        orderInfo.put("notes", req.getParameter("order-notes"));
        orderInfo.put("totalBill", totalBillStr);
        orderInfo.put("paymentMethod", "vnpay");

        // Lưu vào session để sử dụng sau khi thanh toán thành công
        session.setAttribute("pendingOrderInfo", orderInfo);

        VNPayService Config = new VNPayService();

        // ✅ Tạo temporary transaction reference (không phải order_id thật)
        String tempTxnRef = "TEMP_" + System.currentTimeMillis();

        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";

        long amount = (long) (totalBillDouble * 100);
        String vnp_TxnRef = tempTxnRef; // ✅ Dùng temp ID thay vì order_id
        String vnp_IpAddr = Config.getIpAddress(req);

        String vnp_TmnCode = Config.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = req.getParameter("language");
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
        resp.sendRedirect(paymentUrl);
    }
}