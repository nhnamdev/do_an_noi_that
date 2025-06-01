document.addEventListener('DOMContentLoaded', function () {
    let currentFilters = {
        index: 1,
        search: getUrlParameter('search') || '',
        categoryId: getUrlParameter('categoryId') || '',
        subcategoryId: getUrlParameter('subcategoryId') || '',
        sortBy: getUrlParameter('sortBy') || '',
        priceRanges: getUrlParameterArray('price-range') || []
    };
    // Xử lý dropdown sắp xếp
    const sortBtn = document.querySelector('.sort-btn');
    const sortDropdown = document.querySelector('.sort-dropdown-content');
    const sortOptions = document.querySelectorAll('.sort-dropdown-content a');

    if (sortBtn && sortDropdown) {
        sortBtn.addEventListener('click', function () {
            sortDropdown.style.display = sortDropdown.style.display === 'block' ? 'none' : 'block';
        });

        document.addEventListener('click', function (event) {
            if (!sortBtn.contains(event.target) && !sortDropdown.contains(event.target)) {
                sortDropdown.style.display = 'none';
            }
        });
    }

    sortOptions.forEach(option => {
        option.addEventListener('click', function (e) {
            e.preventDefault();

            sortOptions.forEach(opt => opt.classList.remove('active'));
            this.classList.add('active');

            const sortBy = this.getAttribute('data-sort');
            currentFilters.sortBy = sortBy;
            currentFilters.index = 1;

            document.getElementById('sortLabel').textContent = this.textContent + ' ';
            sortDropdown.style.display = 'none';

            loadProducts();
        });
    });
    // Xử lý mở/đóng danh mục
    const categoryHeaders = document.querySelectorAll('.category-header');
    categoryHeaders.forEach(header => {
        header.addEventListener('click', function (e) {
            if (e.target.tagName !== 'SPAN') {
                this.classList.toggle('expanded');

                const subcategory = this.closest('.category-item').querySelector('.subcategory');
                const allSubcategories = document.querySelectorAll('.subcategory');

                allSubcategories.forEach(sub => {
                    if (sub !== subcategory) {
                        sub.classList.remove('active');
                        sub.style.maxHeight = null;

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
            }
        });
    });

    // Xử lý bộ lọc giá
    const priceCheckboxes = document.querySelectorAll('input[name="price-range"]');
    priceCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function () {
            updatePriceFilter();
        });
    });

    initializeFavoriteButtons();

    function getUrlParameter(name) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(name);
    }

    function getUrlParameterArray(name) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.getAll(name);
    }

    // tải danh sách sản phẩm dùng ajax
    function loadProducts() {
        showLoadingState();

        const formData = {};
        formData.index = currentFilters.index;
        formData.search = currentFilters.search || '';
        formData.categoryId = currentFilters.categoryId || '';
        formData.subcategoryId = currentFilters.subcategoryId || '';
        formData.sortBy = currentFilters.sortBy || '';

        // chuyen khoang gia thanh mang
        if (currentFilters.priceRanges && currentFilters.priceRanges.length > 0) {
            formData['price-range'] = currentFilters.priceRanges;
        }

        $.ajax({
            url: "shop",
            type: "post",
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            },
            data: formData,
            traditional: true,
            success: function (data) {
                const productContainer = document.querySelector('.product-list .row');
                if (productContainer) {
                    productContainer.innerHTML = data;
                }

                const paginationMatch = data.match(/<!--PAGINATION_INFO:(\d+):(\d+):(\d+)-->/);
                if (paginationMatch) {
                    const currentPage = parseInt(paginationMatch[1]);
                    const totalPages = parseInt(paginationMatch[2]);
                    updatePagination(currentPage, totalPages);
                }
                // Cập nhật trang shop
                updateURL();
                updateActiveFiltersDisplay();
                initializeFavoriteButtons();
                hideLoadingState();
            },
            error: function (xhr) {
                hideLoadingState();
                showToast('Lỗi', 'Không thể tải sản phẩm. Vui lòng thử lại.', 'error');
            }
        });
    }

    function updatePagination(currentPage, totalPages) {
        const paginationContainer = document.querySelector('.pagination');

        if (totalPages <= 1) {
            if (paginationContainer) {
                paginationContainer.style.display = 'none';
            }
            return;
        }

        if (paginationContainer) {
            paginationContainer.style.display = 'block';
        }

        let html = '<ul class="pagination-container">';

        // nut quay ve truoc
        if (currentPage > 1) {
            html += `
                <li class="pagination-item">
                    <a href="#" onclick="goToPage(${currentPage - 1})" 
                       class="pagination-link pagination-prev" aria-label="Previous page">
                        <i class="fa-solid fa-angle-left"></i>
                    </a>
                </li>
            `;
        }

        // so trang
        for (let i = 1; i <= totalPages; i++) {
            const activeClass = i === currentPage ? 'active' : '';
            html += `
                <li class="pagination-item">
                    <a href="#" onclick="goToPage(${i})" 
                       class="pagination-link ${activeClass}">${i}</a>
                </li>
            `;
        }

        // nut chuyen trang ke
        if (currentPage < totalPages) {
            html += `
                <li class="pagination-item">
                    <a href="#" onclick="goToPage(${currentPage + 1})" 
                       class="pagination-link pagination-next" aria-label="Next page">
                        <i class="fa-solid fa-angle-right"></i>
                    </a>
                </li>
            `;
        }

        html += '</ul>';

        if (paginationContainer) {
            paginationContainer.innerHTML = html;
        }
    }

    function updateURL() {
        const params = new URLSearchParams();

        // Only show search keyword and page on URL, hide other filters
        if (currentFilters.search) {
            params.append('search', currentFilters.search);
        }
        if (currentFilters.index > 1) {
            params.append('page', currentFilters.index);
        }

        const newURL = window.location.pathname + (params.toString() ? '?' + params.toString() : '');
        window.history.pushState({}, '', newURL);
    }

    function showLoadingState() {
        const productContainer = document.querySelector('.product-list .row');
        if (productContainer) {
            productContainer.innerHTML = `
                <div class="col-12 text-center" style="padding: 50px;">
                    <i class="fas fa-spinner fa-spin" style="font-size: 48px; color: #ccc;"></i>
                    <p style="margin-top: 20px; color: #666;">Đang tải sản phẩm...</p>
                </div>
            `;
        }
    }

    function hideLoadingState() {
    }

    function initializeFavoriteButtons() {
        const favoriteButtons = document.querySelectorAll(".favorite-product");
        favoriteButtons.forEach(function (element) {
            const newElement = element.cloneNode(true);
            element.parentNode.replaceChild(newElement, element);
        });

        // Add event listeners to new elements
        document.querySelectorAll(".favorite-product").forEach(function (element) {
            element.addEventListener("click", function () {
                const span = this;
                const productId = span.getAttribute("data-product-id");

                $.ajax({
                    url: "addToFavorites",
                    type: "post",
                    data: {
                        productId: productId
                    },
                    success: function (data) {
                        try {
                            const response = typeof data === 'string' ? JSON.parse(data) : data;
                            if (response.success || response["Đã thêm sản phẩm yêu thích"]) {
                                const isActive = span.classList.contains("active");
                                if (isActive) {
                                    span.classList.remove("active");
                                    span.setAttribute("title", "Thêm vào yêu thích");
                                    span.innerHTML = `<i class="fa-regular fa-heart"></i>`;
                                    showToast('Thông báo', 'Đã xóa khỏi danh sách yêu thích', 'success');
                                } else {
                                    span.classList.add("active");
                                    span.setAttribute("title", "Bỏ khỏi yêu thích");
                                    span.innerHTML = `<i class="fa-solid fa-heart"></i>`;
                                    showToast('Thông báo', 'Đã thêm vào danh sách yêu thích', 'success');
                                }
                            } else {
                                showToast('Thông báo', response.message || "Đã có lỗi xảy ra", 'error');
                            }
                        } catch (e) {
                            console.error("Error parsing response:", e);
                            showToast('Thông báo', "Đã có lỗi xảy ra", 'error');
                        }
                    },
                    error: function (xhr) {
                        console.error("Error:", xhr);
                        showToast('Thông báo', "Đã xảy ra lỗi khi xử lý yêu cầu", 'error');
                    }
                });
            });
        });
    }

    function showToast(title, message, type = 'success') {
        let container = document.getElementById('toastContainer');
        if (!container) {
            container = document.createElement('div');
            container.id = 'toastContainer';
            container.className = 'toast-container';
            document.body.appendChild(container);
        }

        const toast = document.createElement('div');
        toast.className = `toast toast-${type}`;

        toast.innerHTML = `
            <div class="toast-icon">
                <i class="fas ${type == 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
            </div>
            <div class="toast-body">
                <div class="toast-title">${title}</div>
                <div class="toast-message">${message}</div>
            </div>
        `;

        container.appendChild(toast);

        setTimeout(() => {
            toast.classList.add('show');
        }, 10);

        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => {
                if (toast.parentNode) {
                    toast.parentNode.removeChild(toast);
                }
            }, 300);
        }, 3000);
    }

    function updateActiveFiltersDisplay() {
        const activeFiltersContainer = document.getElementById('activeFilters');
        if (!activeFiltersContainer) return;

        let filtersHTML = '';

        // lọc danh mục
        if (currentFilters.categoryId) {
            const categoryName = getCategoryName(currentFilters.categoryId);
            if (categoryName) {
                filtersHTML += `
                <div class="filter-badge">
                    ${categoryName}
                    <i class="fas fa-times" onclick="removeFilter('category')"></i>
                </div>
            `;
            }
        }

        // lọc theo danh mục con
        if (currentFilters.subcategoryId) {
            const subcategoryName = getSubcategoryName(currentFilters.subcategoryId);
            if (subcategoryName) {
                filtersHTML += `
                <div class="filter-badge">
                    ${subcategoryName}
                    <i class="fas fa-times" onclick="removeFilter('subcategory')"></i>
                </div>
            `;
            }
        }

        // lọc theo khoảng giá
        if (currentFilters.priceRanges && currentFilters.priceRanges.length > 0) {
            currentFilters.priceRanges.forEach(range => {
                let rangeText = '';
                switch (range) {
                    case '0-1m':
                        rangeText = 'Dưới 1 triệu';
                        break;
                    case '1m-2m':
                        rangeText = '1-2 triệu';
                        break;
                    case '2m-3m':
                        rangeText = '2-3 triệu';
                        break;
                    case '3m-5m':
                        rangeText = '3-5 triệu';
                        break;
                    case '5m+':
                        rangeText = 'Trên 5 triệu';
                        break;
                }
                if (rangeText) {
                    filtersHTML += `
                    <div class="filter-badge">
                        ${rangeText}
                        <i class="fas fa-times" onclick="removePriceRange('${range}')"></i>
                    </div>
                `;
                }
            });
        }

        activeFiltersContainer.innerHTML = filtersHTML;
    }

    function getCategoryName(categoryId) {
        const categorySpan = document.querySelector(`span[onclick="selectCategory(${categoryId})"]`);
        return categorySpan ? categorySpan.textContent.trim() : null;
    }

    function getSubcategoryName(subcategoryId) {
        const subcategoryLink = document.querySelector(`a[onclick="selectSubcategory(${subcategoryId})"]`);
        return subcategoryLink ? subcategoryLink.textContent.trim() : null;
    }

    // Global functions that need to be accessible from HTML
    window.selectCategory = function (categoryId) {
        currentFilters.categoryId = categoryId;
        currentFilters.subcategoryId = '';
        currentFilters.index = 1;
        loadProducts();
    };

    window.selectSubcategory = function (subcategoryId) {
        currentFilters.subcategoryId = subcategoryId;
        currentFilters.index = 1;
        loadProducts();
    };

    window.updatePriceFilter = function () {
        const checkedRanges = document.querySelectorAll('input[name="price-range"]:checked');
        currentFilters.priceRanges = Array.from(checkedRanges).map(cb => cb.value);
        currentFilters.index = 1;
        loadProducts();
    };

    window.removeFilter = function (type) {
        if (type === 'category') {
            currentFilters.categoryId = '';
            currentFilters.subcategoryId = '';
        } else if (type === 'subcategory') {
            currentFilters.subcategoryId = '';
        }
        currentFilters.index = 1;
        loadProducts();
    };

    window.removePriceRange = function (range) {
        const checkbox = document.querySelector(`input[name="price-range"][value="${range}"]`);
        if (checkbox) {
            checkbox.checked = false;
            currentFilters.priceRanges = currentFilters.priceRanges.filter(r => r !== range);
            currentFilters.index = 1;
            loadProducts();
        }
    };

    window.clearAllFilters = function () {
        currentFilters = {
            index: 1,
            search: '',
            categoryId: '',
            subcategoryId: '',
            sortBy: '',
            priceRanges: []
        };

        // Reset UI elements
        document.querySelectorAll('input[name="price-range"]').forEach(cb => cb.checked = false);

        const sortLabel = document.getElementById('sortLabel');
        if (sortLabel) {
            sortLabel.textContent = 'Sắp xếp theo: Mặc định ';
        }

        loadProducts();
    };

    window.goToPage = function (page) {
        currentFilters.index = page;
        loadProducts();

        // Scroll to top of product list
        const productList = document.querySelector('.product-list');
        if (productList) {
            productList.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    };
});