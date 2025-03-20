// menu dropdown
document.addEventListener('DOMContentLoaded', function () {
    const sortBtn = document.querySelector('.sort-btn');
    const sortDropdown = document.querySelector('.sort-dropdown-content');
    const sortOptions = document.querySelectorAll('.sort-dropdown-content a');

    sortBtn.addEventListener('click', function () {
        sortDropdown.style.display = sortDropdown.style.display === 'block' ? 'none' : 'block';
    });

    document.addEventListener('click', function (event) {
        if (!sortBtn.contains(event.target) && !sortDropdown.contains(event.target)) {
            sortDropdown.style.display = 'none';
        }
    });

    sortOptions.forEach(option => {
        option.addEventListener('click', function (e) {
            e.preventDefault();

            sortOptions.forEach(opt => opt.classList.remove('active'));

            this.classList.add('active');

            sortBtn.firstChild.textContent = this.textContent + ' ';

            sortDropdown.style.display = 'none';
        });
    });
});