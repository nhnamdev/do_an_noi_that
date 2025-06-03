// ĐÂY LÀ TRANG JS XỬ LÍ SỰ KIỆN CHO PHẦN GIỎ HÀNG cart.jsp

document.addEventListener('DOMContentLoaded', function () {
    const plusButtons = document.querySelectorAll('.quantity-btn.plus');
    const minusButtons = document.querySelectorAll('.quantity-btn.minus');
    const quantityInputs = document.querySelectorAll('.quantity-input');
    const cartForm = document.querySelector('form[action*="/cart/updateQuantity"]');
    const updateCartButton = document.getElementById('updateCartButton');

    // Xử lý sự kiện nút tăng số lượng
    plusButtons.forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault();
            const control = this.closest('.quantity-control');
            const input = control.querySelector('.quantity-input');
            const productId = control.getAttribute('data-product-id');
            const hiddenInput = document.getElementById('quantity_' + productId);

            let value = parseInt(input.value);
            if (!isNaN(value)) {
                value++;
                input.value = value;
                if (hiddenInput) {
                    hiddenInput.value = value;
                }
            }
        });
    });

    // Xử lý sự kiện nút giảm số lượng
    minusButtons.forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault();
            const control = this.closest('.quantity-control');
            const input = control.querySelector('.quantity-input');
            const productId = control.getAttribute('data-product-id');
            const hiddenInput = document.getElementById('quantity_' + productId);

            let value = parseInt(input.value);
            if (!isNaN(value)) {
                if (value === 1) {
                    // ktra nếu quantity = 1 và ấn giảm số lượng nữa thì xóa sản phẩm
                    if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                        const removeForm = document.getElementById('removeForm_' + productId);
                        if (removeForm) {
                            removeForm.submit();
                        }
                    }
                } else if (value > 1) {
                    // Giảm số lượng bình thường
                    value--;
                    input.value = value;
                    if (hiddenInput) {
                        hiddenInput.value = value;
                    }
                }
            }
        });
    });

    // so luong san pham thay doi se dc hien thi o day
    quantityInputs.forEach(input => {
        input.addEventListener('change', function () {
            const control = this.closest('.quantity-control');
            const productId = control.getAttribute('data-product-id');
            const hiddenInput = document.getElementById('quantity_' + productId);

            let value = parseInt(this.value);
            if (isNaN(value) || value < 1) {
                value = 1;
                this.value = value;
            }

            if (hiddenInput) {
                hiddenInput.value = value;
            }
        });
    });

    // Connect the external update button to the form
    if (updateCartButton && cartForm) {
        updateCartButton.addEventListener('click', function (e) {
            e.preventDefault();

            // Update all hidden inputs with current values from visible inputs
            document.querySelectorAll('.quantity-control').forEach(control => {
                const visibleInput = control.querySelector('.quantity-input');
                const productId = control.getAttribute('data-product-id');
                const hiddenInput = document.getElementById('quantity_' + productId);

                if (visibleInput && hiddenInput) {
                    hiddenInput.value = visibleInput.value;
                }
            });
            cartForm.submit();
        });
    }

    // XỬ LÝ NÚT XÓA SẢN PHẨM
    const removeButtons = document.querySelectorAll('.remove-btn');
    removeButtons.forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault();

            const productId = this.getAttribute('data-product-id');

            if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                // Tìm form tương ứng và submit
                const removeForm = document.getElementById('removeForm_' + productId);
                if (removeForm) {
                    removeForm.submit();
                }
            }
        });
    });
});