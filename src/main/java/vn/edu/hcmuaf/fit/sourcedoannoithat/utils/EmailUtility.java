package vn.edu.hcmuaf.fit.sourcedoannoithat.utils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class EmailUtility {
    public static void sendEmail(String to, String subject, String content) throws MessagingException {
        String from = "hominhhai2k4@gmail.com"; // Thay bằng email của bạn
        String password = "dzun udle mljk qgpk"; // Thay bằng mật khẩu ứng dụng

        // Cấu hình server SMTP 
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(content);

        Transport.send(message);
    }

    public static String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // Tạo số ngẫu nhiên từ 100000 - 999999
        return String.valueOf(otp);
    }

    public static void sendOTP(String to, String otp) throws MessagingException {
        String subject = "Mã OTP xác nhận đăng ký";
        String content = "Mã OTP của bạn là: " + otp + "\nVui lòng nhập mã này để kích hoạt tài khoản.";
        sendEmail(to, subject, content);
    }

    public static void main(String[] args) throws MessagingException {
        sendOTP("hominhhai2k4@gmail.com",generateOTP());
    }
}
