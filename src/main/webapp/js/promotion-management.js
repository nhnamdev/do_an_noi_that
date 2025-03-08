document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("promotion-form");
    const promoTable = document.getElementById("promotion-table");
    let promotions = [];
    let idCounter = 1;

    // Thêm khuyến mãi mới
    form.addEventListener("submit", (e) => {
        e.preventDefault();

        const title = document.getElementById("promo-title").value;
        const code = document.getElementById("promo-code").value;
        const discount = document.getElementById("discount").value;
        const startDate = document.getElementById("start-date").value;
        const endDate = document.getElementById("end-date").value;

        promotions.push({ id: idCounter, title, code, discount, startDate, endDate });
        idCounter++;
        renderTable();
        form.reset();
    });

    // Hiển thị danh sách khuyến mãi
    function renderTable() {
        promoTable.innerHTML = "";
        promotions.forEach((promo, index) => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${index + 1}</td>
                <td>${promo.title}</td>
                <td>${promo.code}</td>
                <td>${promo.discount}</td>
                <td>${promo.startDate}</td>
                <td>${promo.endDate}</td>
                <td class="action-buttons">
                    <button class="edit" onclick="editPromotion(${promo.id})">Sửa</button>
                    <button class="delete" onclick="deletePromotion(${promo.id})">Xóa</button>
                </td>
            `;
            promoTable.appendChild(row);
        });
    }

    // Sửa thông tin khuyến mãi
    window.editPromotion = (id) => {
        const promo = promotions.find((p) => p.id === id);
        if (promo) {
            document.getElementById("promo-title").value = promo.title;
            document.getElementById("promo-code").value = promo.code;
            document.getElementById("discount").value = promo.discount;
            document.getElementById("start-date").value = promo.startDate;
            document.getElementById("end-date").value = promo.endDate;

            deletePromotion(id); // Xóa khuyến mãi cũ trước khi cập nhật
        }
    };

    // Xóa khuyến mãi
    window.deletePromotion = (id) => {
        promotions = promotions.filter((p) => p.id !== id);
        renderTable();
    };
});
