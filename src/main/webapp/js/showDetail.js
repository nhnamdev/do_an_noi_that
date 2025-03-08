// Hàm hiển thị một phần tử chi tiết cụ thể và ẩn các phần khác
function showDetail(sectionId) {
    const details = document.querySelectorAll('.detail');
    details.forEach(detail => {
        detail.style.display = 'none';
    });

    const selectedDetail = document.getElementById(sectionId);
    if (selectedDetail) {
        selectedDetail.style.display = 'block';
    }
}

// Hàm ẩn/hiện danh sách chức năng (toggle)
function toggleFunctionList() {
    const functionList = document.getElementById('functionList');
    functionList.style.display = functionList.style.display === 'none' || functionList.style.display === '' ? 'block' : 'none';
}

// Các hàm toggle tương tự cho từng danh sách
function mailBoxList() {
    const functionList = document.getElementById('mailBoxList');
    functionList.style.display = functionList.style.display === 'none' || functionList.style.display === '' ? 'block' : 'none';
}

function manageList() {
    const functionList = document.getElementById('manageList');
    functionList.style.display = functionList.style.display === 'none' || functionList.style.display === '' ? 'block' : 'none';
}

function showProductList() {
    const functionList = document.getElementById('showProductList');
    functionList.style.display = functionList.style.display === 'none' || functionList.style.display === '' ? 'block' : 'none';
}

function showContentList() {
    const functionList = document.getElementById('showContentList');
    functionList.style.display = functionList.style.display === 'none' || functionList.style.display === '' ? 'block' : 'none';
}

function guaranteeList() {
    const nestedList = document.getElementById('guaranteeList');
    nestedList.style.display = nestedList.style.display === 'none' || nestedList.style.display === '' ? 'block' : 'none';
}

// Thay đổi màu nút đang được chọn
let currentActiveButton = null;

function changeColor(button) {
    if (currentActiveButton === button) {
        button.classList.remove('active');
        currentActiveButton = null;
    } else {
        if (currentActiveButton) {
            currentActiveButton.classList.remove('active');
        }
        button.classList.add('active');
        currentActiveButton = button;
    }
}

// Thay đổi trạng thái mục đang được chọn
let currentActiveItem = null;

function selectItem(item) {
    if (currentActiveItem === item) {
        item.classList.remove('activeLi');
        currentActiveItem = null;
    } else {
        if (currentActiveItem) {
            currentActiveItem.classList.remove('activeLi');
        }
        item.classList.add('activeLi');
        currentActiveItem = item;
    }
}

// Hiển thị phần Doanh thu khi tải trang
window.onload = function () {
    showDetail('revenue'); // Hiển thị phần Doanh thu
};
