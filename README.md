🏠 Website Bán Đồ Nội Thất
Đây là website thương mại điện tử chuyên cung cấp các sản phẩm nội thất với giao diện thân thiện, dễ sử dụng và tích hợp giỏ hàng, thanh toán online.

🚀 Tính Năng Chính
✅ Trang chủ – Hiển thị sản phẩm nổi bật,...
✅ Tin tức - Xem các tin tức về nội thất mới nhất. 
✅ Danh mục Tin tức – Duyệt Tin tức theo loại.
✅ Danh mục sản phẩm – Duyệt sản phẩm theo loại, thương hiệu.
✅ Chi tiết sản phẩm – Xem thông tin chi tiết và hình ảnh.
✅ Tìm kiếm & Lọc sản phẩm – Hỗ trợ tìm kiếm nhanh chóng.
✅ Giỏ hàng – Quản lý sản phẩm trước khi thanh toán.
✅ Thanh toán & Đặt hàng – Lưu thông tin đơn hàng, quản lý trạng thái.
✅ Đăng nhập & Đăng ký – Quản lý tài khoản khách hàng.
✅ Quản trị viên – Thêm, sửa, xóa sản phẩm, user, bài đăng, Quản lí contact
✅ Mod – Thêm, sửa, xóa sản phẩm , bài đăng

🛠 Công Nghệ Sử Dụng
Backend: JSP, Servlet, JDBC
Frontend: HTML, CSS, JavaScript, Bootstrap
Cơ sở dữ liệu: MySQL
Máy chủ: Apache Tomcat

🔧 Cài Đặt & Cấu Hình
1. Clone Repository
git clone [https://github.com/your-repo/furniture-store.git]
2. Cấu Hình Cơ Sở Dữ Liệu
Tạo database MySQL có tên donoithat.
Import file donoithat.sql vào database.
Cấu hình thông tin kết nối MySQL trong dbConfig.java:
public class DBConfig {
    private static final String URL = "jdbc:mysql://localhost:3306/furniture_store";
    private static final String USER = "root";
    private static final String PASSWORD = "your_password";
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}



📸 Hình Ảnh Giao Diện
![image](https://github.com/user-attachments/assets/647ecf53-3ecb-43bb-8bb4-fb8a11e9dfe4)


