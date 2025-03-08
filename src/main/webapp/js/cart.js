// Lấy tất cả các phần tử cần thao tác
const selectAllCheckbox = document.getElementById('select-all');
const rowCheckboxes = document.querySelectorAll('.row-checkbox');
const increaseButtons = document.querySelectorAll('.quantity-btn.plus');
const decreaseButtons = document.querySelectorAll('.quantity-btn.minus');
const quantityInputs = document.querySelectorAll('.quantity-input');
const deleteButtons = document.querySelectorAll('.delete');
const totalItemsElement = document.getElementById('total-items');
const totalPriceElement = document.getElementById('total-price');

// Chức năng "chọn tất cả" (checkbox đầu tiên)
selectAllCheckbox.addEventListener('change', function () {
    rowCheckboxes.forEach(function (checkbox) {
        checkbox.checked = selectAllCheckbox.checked;
    });
    updateOrderSummary(); // Cập nhật lại số lượng sản phẩm và tổng tiền
});

// Chức năng chọn từng checkbox
rowCheckboxes.forEach(function (checkbox) {
    checkbox.addEventListener('change', function () {
        updateOrderSummary();
    });
});

// Chức năng tăng giảm số lượng
increaseButtons.forEach(function (button, index) {
    button.addEventListener('click', function () {
        let input = quantityInputs[index];
        let currentValue = parseInt(input.value);
        input.value = currentValue + 1;
        updateTotalPrice();
        updateOrderSummary();
    });
});

decreaseButtons.forEach(function (button, index) {
    button.addEventListener('click', function () {
        let input = quantityInputs[index];
        let currentValue = parseInt(input.value);
        if (currentValue > 1) { // Đảm bảo số lượng không giảm xuống dưới 1
            input.value = currentValue - 1;
            updateTotalPrice();
            updateOrderSummary();
        }
    });
});

// Cập nhật tổng tiền sau mỗi lần thay đổi số lượng
function updateTotalPrice() {
    const rows = document.querySelectorAll('tbody tr');
    rows.forEach(function (row, index) {
        const price = parseInt(row.children[2].innerText.replace(/\./g, '')); // Đơn giá
        const quantity = parseInt(row.children[3].querySelector('.quantity-input').value); // Số lượng
        const total = price * quantity;
        row.children[4].innerText = total.toLocaleString(); // Hiển thị số tiền
    });
}

// Cập nhật số lượng sản phẩm và tổng tiền
function updateOrderSummary() {
    let totalItems = 0;
    let totalPrice = 0;

    const rows = document.querySelectorAll('tbody tr');
    rows.forEach(function (row) {
        const checkbox = row.querySelector('.row-checkbox');
        if (checkbox.checked) {
            const price = parseInt(row.children[2].innerText.replace(/\./g, '')); // Đơn giá
            const quantity = parseInt(row.children[3].querySelector('.quantity-input').value); // Số lượng
            totalItems += quantity;
            totalPrice += price * quantity;
        }
    });

    totalItemsElement.innerText = totalItems; // Cập nhật số sản phẩm
    totalPriceElement.innerText = totalPrice.toLocaleString(); // Cập nhật tổng tiền
}

// Chức năng xoá hàng
deleteButtons.forEach(function (button, index) {
    button.addEventListener('click', function () {
        const row = button.closest('tr');
        row.remove();
        updateTotalPrice();
        updateOrderSummary();
    });
});
