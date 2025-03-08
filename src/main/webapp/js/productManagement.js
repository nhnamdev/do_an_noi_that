// Xuất file CSV khi nhấn nút 'exportFileButton'
document.getElementById('exportFileButton').addEventListener('click', function () {
    // Tạo nội dung CSV với dòng tiêu đề
    let csvContent = "Mã SP,Tên SP,Giá Bán,Giá Vốn,Số Lượng,Tồn Kho,Giá Trị Tồn Kho\n";
    const rows = document.querySelectorAll('#productTable tbody tr');

    // Duyệt qua từng dòng trong bảng và chuyển đổi thành chuỗi CSV
    rows.forEach(function (row) {
        const cols = row.querySelectorAll('td');
        let rowData = Array.from(cols).map(col => col.textContent).join(',');
        csvContent += rowData + "\n";
    });

    // Tạo file CSV và tự động tải về
    const blob = new Blob([csvContent], { type: 'text/csv' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = 'product_list.csv';
    link.click();
});


document.getElementById('closePanelButton').addEventListener('click', function () {
    document.getElementById('addProductPanel').style.display = 'none';
});

// Hiển thị form thêm sản phẩm khi nhấn nút 'addProductButton'
document.getElementById('addProductButton').addEventListener('click', function () {
    const addProductPanel= document.getElementById('addProductPanel');
    addProductPanel.style.display = 'block';
    addProductPanel.style.width = '300px';
    addProductPanel.style.margin = '20px auto';
    addProductPanel.style.padding = '20px';
    addProductPanel.style.border = '1px solid #ccc';
    addProductPanel.style.borderRadius = '8px';
    addProductPanel.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.1)';
    addProductPanel.style.backgroundColor = '#f9f9f9';

    const panelContent = addProductPanel.querySelector('.panel-content');
    panelContent.querySelector('h3').style.textAlign = 'center';
    panelContent.querySelector('h3').style.color = '#333';

    const formElements = addProductPanel.querySelectorAll('input[type="text"], input[type="number"]');
    formElements.forEach(input => {
        input.style.padding = '10px';
        input.style.border = '1px solid #ccc';
        input.style.borderRadius = '4px';
        input.style.marginBottom = '15px';
    });

    const buttons = addProductPanel.querySelectorAll('button');
    buttons.forEach(button => {
        button.style.padding = '10px';
        button.style.border = 'none';
        button.style.borderRadius = '4px';
        button.style.cursor = 'pointer';
        button.style.fontWeight = 'bold';
        button.style.marginTop = '10px';
    });

    buttons[0].style.backgroundColor = '#4CAF50';
    buttons[0].style.color = 'white';

    buttons[1].style.backgroundColor = '#f44336';
    buttons[1].style.color = 'white';
});

document.getElementById('closePanelButton').addEventListener('click', function () {
    document.getElementById('addProductPanel').style.display = 'none';
});


// Sửa thông tin sản phẩm
document.addEventListener("DOMContentLoaded", () => {
    const table = document.getElementById("productTable");
    const editForm = document.getElementById("editForm");
    const productCodeInput = document.getElementById("editProductCode");
    const productNameInput = document.getElementById("editProductName");
    const sellingPriceInput = document.getElementById("editSellingPrice");
    const costPriceInput = document.getElementById("editCostPrice");
    const quantityInput = document.getElementById("editQuantity");

    let editingRow = null;

    table.addEventListener("click", (event) => {
        if (event.target.classList.contains("editButton")) {
            editingRow = event.target.closest("tr");

            // Đưa dữ liệu của dòng vào form chỉnh sửa
            productCodeInput.value = editingRow.children[0].innerText;
            productNameInput.value = editingRow.children[1].innerText;
            sellingPriceInput.value = editingRow.children[2].innerText.replace(/,/g, "");
            costPriceInput.value = editingRow.children[3].innerText.replace(/,/g, "");
            quantityInput.value = editingRow.children[4].innerText;


            editForm.style.display = "block";
        }
    });

    editForm.addEventListener("submit", (event) => {
        event.preventDefault();

        if (editingRow) {
            // Cập nhật dữ liệu
            editingRow.children[0].innerText = productCodeInput.value;
            editingRow.children[1].innerText = productNameInput.value;
            editingRow.children[2].innerText = parseInt(sellingPriceInput.value).toLocaleString();
            editingRow.children[3].innerText = parseInt(costPriceInput.value).toLocaleString();
            editingRow.children[4].innerText = quantityInput.value;
            editingRow.children[5].innerText = (
                parseInt(sellingPriceInput.value) * parseInt(quantityInput.value)
            ).toLocaleString();

            alert("Sản phẩm đã được cập nhật.");
            editForm.style.display = "none";
            editingRow = null;
        }
    });

    // Hủy chỉnh sửa
    document.getElementById("cancelEdit").addEventListener("click", () => {
        editForm.style.display = "none";
        editingRow = null;
    });
});

//phân trang
document.addEventListener("DOMContentLoaded", function () {
    const rowsPerPage = 10;
    let currentPage = 1;

    const tableBody = document.querySelector("#productTable tbody");
    const rows = Array.from(tableBody.querySelectorAll("tr"));
    const totalRows = rows.length;
    const totalPages = Math.ceil(totalRows / rowsPerPage);

    const paginationInfo = document.querySelector("#paginationInfo");
    const prevButton = document.querySelector("#prevPageButton");
    const nextButton = document.querySelector("#nextPageButton");

    function renderPage(page) {
        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;

        rows.forEach((row, index) => {
            row.style.display = index >= start && index < end ? "" : "none";
        });

        paginationInfo.textContent = `Hiển thị ${start + 1}-${Math.min(
            end,
            totalRows
        )} trên tổng số ${totalRows} sản phẩm`;

        prevButton.disabled = page === 1;
        nextButton.disabled = page === totalPages;
    }

    prevButton.addEventListener("click", () => {
        if (currentPage > 1) {
            currentPage--;
            renderPage(currentPage);
        }
    });

    nextButton.addEventListener("click", () => {
        if (currentPage < totalPages) {
            currentPage++;
            renderPage(currentPage);
        }
    });

    renderPage(currentPage);
});
