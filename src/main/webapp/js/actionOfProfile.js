const shoppingButtonHeader = document.querySelector('.User');
const infoBoxHeader = document.getElementById('boxHeader');
const overlayHeader = document.getElementById('layoutHeader');

shoppingButtonHeader.addEventListener('click', (event) => {
    event.preventDefault();
    infoBoxHeader.classList.toggle('activeHeader');
    overlayHeader.classList.toggle('activeHeader');
});

overlayHeader.addEventListener('click', () => {
    infoBoxHeader.classList.remove('activeHeader');
    overlayHeader.classList.remove('activeHeader');
});
    // Lấy phần tử icon và form tìm kiếm
    const searchIcon = document.getElementById("searchIcon");
    const searchForm = document.getElementById("searchForm");

    // Thêm sự kiện click cho icon tìm kiếm
    searchIcon.addEventListener("click", function (event) {
    event.preventDefault(); // Ngăn chặn hành động mặc định của link
    searchForm.style.display = (searchForm.style.display === "block") ? "none" : "block";
});
