document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("about-form");
    const aboutTable = document.getElementById("about-table");
    let aboutItems = [];
    let idCounter = 1;

    // Thêm nội dung giới thiệu mới
    form.addEventListener("submit", (e) => {
        e.preventDefault();

        const title = document.getElementById("title").value;
        const content = document.getElementById("content").value;

        aboutItems.push({ id: idCounter, title, content });
        idCounter++;
        renderTable();
        form.reset();
    });

    // Hiển thị danh sách nội dung
    function renderTable() {
        aboutTable.innerHTML = "";
        aboutItems.forEach((item, index) => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${index + 1}</td>
                <td>${item.title}</td>
                <td>${item.content}</td>
                <td class="action-buttons">
                    <button class="edit" onclick="editAbout(${item.id})">Sửa</button>
                    <button class="delete" onclick="deleteAbout(${item.id})">Xóa</button>
                </td>
            `;
            aboutTable.appendChild(row);
        });
    }

    // Sửa nội dung giới thiệu
    window.editAbout = (id) => {
        const item = aboutItems.find((a) => a.id === id);
        if (item) {
            document.getElementById("title").value = item.title;
            document.getElementById("content").value = item.content;

            deleteAbout(id); // Xóa nội dung cũ trước khi cập nhật
        }
    };

    // Xóa nội dung giới thiệu
    window.deleteAbout = (id) => {
        aboutItems = aboutItems.filter((a) => a.id !== id);
        renderTable();
    };
});
