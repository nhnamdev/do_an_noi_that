document.querySelectorAll('.pagination .page-link').forEach(link => {
    link.addEventListener('click', function (e) {
        e.preventDefault();
        if (this.parentElement.classList.contains('disabled') || this.parentElement.classList.contains('active')) {
            return;
        }

        const currentActive = document.querySelector('.pagination .active');
        currentActive.classList.remove('active');
        this.parentElement.classList.add('active');

        console.log(`Chuyển tới trang: ${this.textContent.trim()}`);
        // Thêm logic tải dữ liệu tương ứng với trang ở đây
    });
});
