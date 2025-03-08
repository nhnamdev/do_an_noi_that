document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("product-form");
    const productTable = document.getElementById("product-table");
    let products = [];
    let idCounter = 1;

    // Thêm sản phẩm mới
    form.addEventListener("submit", (e) => {
        e.preventDefault();

        const name = document.getElementById("product-name").value;
        const code = document.getElementById("product-code").value;
        const price = document.getElementById("price").value;
        const description = document.getElementById("description").value;

        products.push({ id: idCounter, name, code, price, description });
        idCounter++;
        renderTable();
        form.reset();
    });

    // Hiển thị danh sách sản phẩm
    function renderTable() {
        productTable.innerHTML = "";
        products.forEach((product, index) => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${index + 1}</td>
                <td>${product.name}</td>
                <td>${product.code}</td>
                <td>${product.price}</td>
                <td>${product.description}</td>
                <td class="action-buttons">
                    <button class="edit" onclick="editProduct(${product.id})">Sửa</button>
                    <button class="delete" onclick="deleteProduct(${product.id})">Xóa</button>
                </td>
            `;
            productTable.appendChild(row);
        });
    }

    // Sửa thông tin sản phẩm
    window.editProduct = (id) => {
        const product = products.find((p) => p.id === id);
        if (product) {
            document.getElementById("product-name").value = product.name;
            document.getElementById("product-code").value = product.code;
            document.getElementById("price").value = product.price;
            document.getElementById("description").value = product.description;

            deleteProduct(id); // Xóa sản phẩm cũ trước khi cập nhật
        }
    };

    // Xóa sản phẩm
    window.deleteProduct = (id) => {
        products = products.filter((p) => p.id !== id);
        renderTable();
    };
});
