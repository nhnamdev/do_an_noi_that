// Hàm để hiển thị tab khi click
function showTab(tabName) {
    // Lấy tất cả các phần tử có lớp 'order-section-product'
    var sections = document.querySelectorAll('.order-section-product');

    // Ẩn tất cả các phần tử đơn hàng
    sections.forEach(function (section) {
        section.classList.remove('active-tab');
    });

    // Nếu tab là 'all', hiển thị tất cả các phần tử đơn hàng
    if (tabName === 'all') {
        sections.forEach(function (section) {
            section.classList.add('active-tab');
        });
    } else {
        // Hiển thị phần tử tương ứng với tab được chọn
        var activeSection = document.getElementById(tabName + '-orders');
        if (activeSection) {
            activeSection.classList.add('active-tab');
        }
    }

    // Thêm class 'active' cho tab đã chọn
    var tabs = document.querySelectorAll('.tab-link');
    tabs.forEach(function (tab) {
        tab.classList.remove('active');
    });
    var activeTab = document.querySelector('.tab-link[onclick="showTab(\'' + tabName + '\')"]');
    if (activeTab) {
        activeTab.classList.add('active');
    }
}

// Hàm chạy khi trang được tải để chọn tab mặc định (ví dụ tab "all")
window.onload = function () {
    showTab('all');  // Hiển thị tab "Tất cả" khi trang vừa được tải
};
