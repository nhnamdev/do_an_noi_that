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

//     sidebar extend
    const categoryHeaders = document.querySelectorAll('.category-header');

    categoryHeaders.forEach(header => {
        header.addEventListener('click', function (e) {
            this.classList.toggle('expanded');

            const subcategory = this.closest('.category-item').querySelector('.subcategory');

            const allSubcategories = document.querySelectorAll('.subcategory');
            allSubcategories.forEach(sub => {
                if (sub !== subcategory) {
                    sub.classList.remove('active');
                    sub.style.maxHeight = null;

                    // Reset expanded state cho category headers khác
                    const otherCategoryHeader = sub.closest('.category-item').querySelector('.category-header');
                    if (otherCategoryHeader && otherCategoryHeader !== this) {
                        otherCategoryHeader.classList.remove('expanded');
                    }
                }
            });

            if (subcategory) {
                subcategory.classList.toggle('active');

                if (subcategory.classList.contains('active')) {
                    subcategory.style.maxHeight = subcategory.scrollHeight + "px";
                } else {
                    subcategory.style.maxHeight = null;
                }
            }
        });
    });
    const subcategoryHeaders = document.querySelectorAll('.subcategory-header');

    subcategoryHeaders.forEach(header => {
        header.addEventListener('click', function (e) {
            // Toggle expanded class
            this.classList.toggle('expanded');

            const subcategoryLevel2 = this.closest('.subcategory-item').querySelector('.subcategory-level-2');

            if (subcategoryLevel2) {
                subcategoryLevel2.classList.toggle('active');

                if (subcategoryLevel2.classList.contains('active')) {
                    subcategoryLevel2.style.maxHeight = subcategoryLevel2.scrollHeight + "px";

                    const parentSubcategory = this.closest('.subcategory');
                    if (parentSubcategory) {
                        parentSubcategory.style.maxHeight = parentSubcategory.scrollHeight + subcategoryLevel2.scrollHeight + "px";
                    }
                } else {
                    subcategoryLevel2.style.maxHeight = null;

                    const parentSubcategory = this.closest('.subcategory');
                    if (parentSubcategory) {
                        parentSubcategory.style.maxHeight = parentSubcategory.scrollHeight + "px";
                    }
                }
            }
        });
    });
});