function showDetail(target) {
    // Ẩn tất cả các detail sections
    const details = document.querySelectorAll('.detail');
    details.forEach(detail => {
        detail.style.display = 'none';
    });

    // Xóa class active khỏi tất cả buttons
    const buttons = document.querySelectorAll('.btn');
    buttons.forEach(btn => {
        btn.classList.remove('active');
    });

    // Hiển thị section được chọn
    switch (target) {
        case 'main_contentt':
            document.getElementById('main_contentt').style.display = 'block';
            break;
        case 'orderManagement':
            document.getElementById('orderManagement').style.display = 'block';
            // Refresh order counts when showing order management
            if (window.orderManager) {
                window.orderManager.refreshOrderCounts();
            }
            break;
        case 'mailBox2':
            document.getElementById('mailBox2').style.display = 'block';
            break;
        case 'showPL1':
            document.getElementById('showPL1').style.display = 'block';
            break;
        case 'showPL2':
            document.getElementById('showPL2').style.display = 'block';
            break;
        case 'manageList2':
            document.getElementById('manageList2').style.display = 'block';
            break;
        case 'warranty-container':
            document.getElementById('warranty-container').style.display = 'block';
            break;
        default:
            document.getElementById('main_contentt').style.display = 'block';
    }
    event.target.classList.add('active');
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

// // Hiển thị phần Doanh thu khi tải trang
// window.onload = function () {
//     showDetail('revenue'); // Hiển thị phần Doanh thu
// };
window.onload = function () {
    const revenueSection = document.getElementById('revenue');

    if (revenueSection) {
        showDetail('revenue'); // Chỉ hiển thị nếu phần revenue tồn tại
    } else {
        document.getElementById("main_contentt").style.display = 'block'; // Nếu không, hiển thị nội dung chính
    }
};