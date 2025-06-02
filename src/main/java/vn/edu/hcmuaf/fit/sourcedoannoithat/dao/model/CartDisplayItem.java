package vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model;

import java.io.Serializable;

// hien thi thong tin san pham len tren gio hang
public class CartDisplayItem implements Serializable {
    private int quantity;
    private Product product;
    private ProductDetail productDetail;

    public CartDisplayItem(int quantity, Product product, ProductDetail productDetail) {
        this.quantity = quantity;
        this.product = product;
        this.productDetail = productDetail;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public ProductDetail getProductDetail() {
        return productDetail;
    }

    public void setProductDetail(ProductDetail productDetail) {
        this.productDetail = productDetail;
    }

    @Override
    public String toString() {
        return "CartDisplayItem{" +
                "quantity=" + quantity +
                ", product=" + product +
                ", productDetail=" + productDetail +
                '}';
    }

    public void increaseQuantity() {
        this.quantity++;
    }

    // tính tiền cho item mà người dùng ấn vào mua ngay, chứ không chuyển sang giỏ hàng nữa
    public double getTotalPrice() {
        if (product != null) {
            return product.getPrice() * quantity;
        }
        return 0;
    }
}
