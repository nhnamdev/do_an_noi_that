// ĐÂY LÀ TRANG JS XỬ LÍ SỰ KIỆN CHO PHẦN GIỎ HÀNG cart.jsp

document.addEventListener('DOMContentLoaded', function () {
    const quantityInputs = document.querySelectorAll('.quantity-input');
    const minusButtons = document.querySelectorAll('.quantity-btn.minus');
    const plusButtons = document.querySelectorAll('.quantity-btn.plus');
    const removeButtons = document.querySelectorAll('.remove-btn');

    // Xử lý sự kiện nút tăng số lượng
    plusButtons.forEach(button => {
        button.addEventListener('click', function () {
            const input = this.parentElement.querySelector('.quantity-input');
            const currentValue = parseInt(input.value);

            // Tăng số lượng sp
            input.value = currentValue + 1;
        });
    });

    // Xử lý sự kiện nút giảm số lượng
    minusButtons.forEach(button => {
        button.addEventListener('click', function () {
            const input = this.parentElement.querySelector('.quantity-input');
            const currentValue = parseInt(input.value);

            // Không cho phép số lượng nhỏ hơn 1
            if (currentValue > 1) {
                input.value = currentValue - 1;
            }
        });
    });

    // Xử lý sự kiện nút xóa sản phẩm
    removeButtons.forEach(button => {
        button.addEventListener('click', function () {
            if (confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                const cartItem = this.closest('tr');
                cartItem.remove();
            }
        });
    });
});