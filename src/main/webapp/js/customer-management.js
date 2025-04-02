function addCustomer() {
    const tableBody = document.getElementById('customer-table-body');
    const newRow = document.createElement('tr');

    newRow.innerHTML = `
        <td><input type="text" placeholder="Họ và Tên"></td>
        <td><input type="text" placeholder="Email / Tên Người Dùng"></td>
        <td><input type="text" placeholder="Số Điện Thoại"></td>
        <td><input type="text" placeholder="Địa Chỉ"></td>
        <td><input type="text" placeholder="Mã Đơn Hàng"></td>
        <td>
            <button class="btn save" onclick="saveCustomer(this)">Lưu</button>
            <button class="btn delete" onclick="deleteCustomer(this)">Xoá</button>
        </td>
    `;
    tableBody.appendChild(newRow);
}

function saveCustomer(button) {
    const row = button.closest('tr');
    const inputs = row.querySelectorAll('input');
    const data = Array.from(inputs).map(input => input.value);

    if (data.some(field => field.trim() === '')) {
        alert('Vui lòng điền đầy đủ thông tin!');
        return;
    }

    row.innerHTML = `
        <td>${data[0]}</td>
        <td>${data[1]}</td>
        <td>${data[2]}</td>
        <td>${data[3]}</td>
        <td>${data[4]}</td>
        <td>
            <button class="btn details" onclick="viewCustomerDetails('${data[0]}')">Chi Tiết</button>
            <button class="btn edit" onclick="editCustomer(this)">Sửa</button>
            <button class="btn delete" onclick="deleteCustomer(this)">Xoá</button>
        </td>
    `;
}

function editCustomer(button) {
    const row = button.closest('tr');
    const cells = row.querySelectorAll('td:not(:last-child)');
    const currentData = Array.from(cells).map(cell => cell.textContent);

    row.innerHTML = `
        <td><input type="text" value="${currentData[0]}"></td>
        <td><input type="text" value="${currentData[1]}"></td>
        <td><input type="text" value="${currentData[2]}"></td>
        <td><input type="text" value="${currentData[3]}"></td>
        <td><input type="text" value="${currentData[4]}"></td>
        <td>
            <button class="btn save" onclick="saveCustomer(this)">Lưu</button>
            <button class="btn delete" onclick="deleteCustomer(this)">Xoá</button>
        </td>
    `;
}

function deleteCustomer(button) {
    const row = button.closest('tr');
    row.remove();
}

function viewCustomerDetails(name) {
    alert(`Hiển thị chi tiết cho khách hàng: ${name}`);
}

// JavaScript for searching members by name or ID

document.querySelector('.search-btn').addEventListener('click', function () {
    const searchInput = document.querySelector('.search-input').value.trim().toLowerCase();
    const filterOption = document.querySelector('.filter-select').value;
    const tableRows = document.querySelectorAll('tbody tr');

    tableRows.forEach(row => {
        const idCell = row.cells[0].textContent.trim().toLowerCase();
        const nameCell = row.cells[2].textContent.trim().toLowerCase();

        if (filterOption === 'ID' && idCell.includes(searchInput)) {
            row.style.display = '';
        } else if (filterOption === 'Tên' && nameCell.includes(searchInput)) {
            row.style.display = '';
        } else if (filterOption === '--Tìm kiếm thành viên theo--' || searchInput === '') {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
});
