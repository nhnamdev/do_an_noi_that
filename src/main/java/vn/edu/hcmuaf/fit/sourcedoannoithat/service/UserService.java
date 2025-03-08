//package vn.edu.hcmuaf.fit.sourcedoannoithat.service;
//
//import org.mindrot.jbcrypt.BCrypt;
//import vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.UserDao;
//
//public class UserService {
//    private UserDao userDao;
//
//    public UserService() {
//        this.userDao = new UserDao();
//    }
//
//    public boolean registerUser(String email, String phone, String address, String username, String password, String confirmPassword) {
//        // Kiểm tra mật khẩu xác nhận
//        if (!password.equals(confirmPassword)) {
//            throw new IllegalArgumentException("Mật khẩu xác nhận không khớp!");
//        }
//
//        // Mã hóa mật khẩu
//        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
//
//        // Gọi DAO để lưu thông tin
//        return userDao.saveUser(email, phone, address, username, hashedPassword);
//    }
//}
