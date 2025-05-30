// xử lí sự kiện js cho trang sản phẩm
document.addEventListener('DOMContentLoaded', function () {
    // hiển thị hình ảnh phụ
    const mainImage = document.querySelector('.main-image img');
    const subImages = document.querySelectorAll('.sub-image');

    subImages.forEach(image => {
        image.addEventListener('click', function () {
            // Xóa active từ ảnh phụ
            subImages.forEach(img => {
                img.classList.remove('active');
            });

            // Thêm đuôi active vào ảnh được click
            this.classList.add('active');

            // Cập nhật ảnh chính
            const imgSrc = this.querySelector('img').src;
            mainImage.src = imgSrc;
        });
    });
    // xử lí sự kiện ấn chuyển qua lại giữa các ảnh
    const prevBtn = document.querySelector('.prev-btn');
    const nextBtn = document.querySelector('.next-btn');
    let currentIndex = 0;

    function updateMainImage(index) {
        // Xóa active từ ảnh phụ
        subImages.forEach(img => {
            img.classList.remove('active');
        });

        // Thêm đuôi active vào ảnh phụ hiện tại
        subImages[index].classList.add('active');

        // Cập nhật ảnh chính
        const imgSrc = subImages[index].querySelector('img').src;
        mainImage.src = imgSrc;
    }

    if (prevBtn && nextBtn && subImages.length > 0) {
        prevBtn.addEventListener('click', function () {
            currentIndex = (currentIndex - 1 + subImages.length) % subImages.length;
            updateMainImage(currentIndex);
        });

        nextBtn.addEventListener('click', function () {
            currentIndex = (currentIndex + 1) % subImages.length;
            updateMainImage(currentIndex);
        });
    }
    // Xử lý phần tabs thông tin
    const tabButtons = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-pane');

    tabButtons.forEach(button => {
        button.addEventListener('click', function () {
            // Xóa class active từ tất cả nút tab
            tabButtons.forEach(btn => btn.classList.remove('active'));

            // Xóa class active từ tất cả nội dung tab
            tabContents.forEach(content => content.classList.remove('active'));

            // Thêm class active cho nút được click
            this.classList.add('active');

            // Hiển thị nội dung tab tương ứng
            const tabId = this.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
        });
    });
});
