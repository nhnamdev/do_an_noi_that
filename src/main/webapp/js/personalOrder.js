$(document).ready(function () {
    let currentPage = 1;
    let totalPages = 1;
    let totalOrders = 0;
    let isLoading = false; // Prevent multiple requests

    // Load trang đầu tiên khi khởi tạo
    loadOrderPage(1);

    // Event delegation cho pagination links
    $(document).on('click', '.pagination a', function (e) {
        e.preventDefault();
        e.stopPropagation();

        const href = $(this).attr('onclick');
        if (href && !isLoading) {
            const pageMatch = href.match(/loadOrderPage\((\d+)\)/);
            if (pageMatch) {
                const page = parseInt(pageMatch[1]);
                loadOrderPage(page);
            }
        }
        return false;
    });

    function loadOrderPage(page) {
        if (isLoading) return;

        isLoading = true;
        currentPage = page;

        // Smooth loading animation
        $('#order-list-content').addClass('loading-transition').html(`
            <div style="text-align: center; padding: 50px; opacity: 0.8;">
                <div class="spinner-border" role="status" style="width: 2rem; height: 2rem; border: 3px solid #f3f3f3; border-top: 3px solid #007bff; border-radius: 50%; animation: spin 1s linear infinite;">
                    <span class="sr-only"></span>
                </div>
                <br><br>
                <span style="color: #666;">Đang tải đơn hàng...</span>
            </div>
        `);

        // Update URL without page reload
        updateUrlWithoutReload(page);

        $.ajax({
            url: 'orderInformation',
            type: 'GET',
            data: {page: page},
            headers: {'X-Requested-With': 'XMLHttpRequest'},
            timeout: 15000, // 15 second timeout
            success: function (response) {
                try {
                    // Parse pagination info
                    const paginationMatch = response.match(/<!--PAGINATION_INFO:(\d+):(\d+):(\d+)-->/);
                    if (paginationMatch) {
                        currentPage = parseInt(paginationMatch[1]);
                        totalPages = parseInt(paginationMatch[2]);
                        totalOrders = parseInt(paginationMatch[3]);

                        // Remove pagination comment from HTML
                        response = response.replace(/<!--PAGINATION_INFO:\d+:\d+:\d+-->/, '');
                    }

                    // Smooth content transition
                    setTimeout(() => {
                        $('#order-list-content').removeClass('loading-transition').html(response);
                        updatePagination();

                        // Smooth scroll to top of order list
                        $('html, body').animate({
                            scrollTop: $('.order-list-container').offset().top - 20
                        }, 300);
                    }, 300);

                } catch (error) {
                    console.error('Error parsing response:', error);
                    showErrorMessage('Có lỗi xảy ra khi xử lý dữ liệu');
                }
            },
            error: function (xhr, status, error) {
                console.error('AJAX Error:', {xhr, status, error});

                let errorMessage = 'Có lỗi xảy ra khi tải dữ liệu';
                if (status === 'timeout') {
                    errorMessage = 'Tải dữ liệu quá lâu, vui lòng thử lại';
                } else if (xhr.status === 404) {
                    errorMessage = 'Không tìm thấy trang yêu cầu';
                } else if (xhr.status >= 500) {
                    errorMessage = 'Lỗi máy chủ, vui lòng thử lại sau';
                }

                showErrorMessage(errorMessage);
            },
            complete: function () {
                isLoading = false;
            }
        });
    }

    function updatePagination() {
        if (totalPages <= 1) {
            $('#pagination-container').fadeOut(300);
            return;
        }

        let paginationHtml = '';
        const maxVisiblePages = 5; // Show max 5 page numbers

        let startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2));
        let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);

        if (endPage - startPage + 1 < maxVisiblePages) {
            startPage = Math.max(1, endPage - maxVisiblePages + 1);
        }

        // Previous button
        if (currentPage > 1) {
            paginationHtml += `<li><a href="#" onclick="loadOrderPage(${currentPage - 1})" title="Trang trước">« Trước</a></li>`;
        } else {
            paginationHtml += '<li><span class="disabled">« Trước</span></li>';
        }

        // First page + ellipsis
        if (startPage > 1) {
            paginationHtml += `<li><a href="#" onclick="loadOrderPage(1)">1</a></li>`;
            if (startPage > 2) {
                paginationHtml += '<li><span class="disabled">...</span></li>';
            }
        }

        // Page numbers
        for (let i = startPage; i <= endPage; i++) {
            if (i === currentPage) {
                paginationHtml += `<li><span class="current">${i}</span></li>`;
            } else {
                paginationHtml += `<li><a href="#" onclick="loadOrderPage(${i})" title="Trang ${i}">${i}</a></li>`;
            }
        }

        if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
                paginationHtml += '<li><span class="disabled">...</span></li>';
            }
            paginationHtml += `<li><a href="#" onclick="loadOrderPage(${totalPages})">${totalPages}</a></li>`;
        }

        // Next button
        if (currentPage < totalPages) {
            paginationHtml += `<li><a href="#" onclick="loadOrderPage(${currentPage + 1})" title="Trang sau">Sau »</a></li>`;
        } else {
            paginationHtml += '<li><span class="disabled">Sau »</span></li>';
        }

        $('#pagination-list').html(paginationHtml);

        const startItem = (currentPage - 1) * 3 + 1;
        const endItem = Math.min(currentPage * 3, totalOrders);
        $('#pagination-info').html(`
            Hiển thị <strong>${startItem}-${endItem}</strong> của <strong>${totalOrders}</strong> đơn hàng 
            (Trang <strong>${currentPage}</strong>/<strong>${totalPages}</strong>)
        `);

        $('#pagination-container').fadeIn(300);
    }

    function updateUrlWithoutReload(page) {
        if (window.history && window.history.pushState) {
            const newUrl = new URL(window.location);
            if (page === 1) {
                newUrl.searchParams.delete('page');
            } else {
                newUrl.searchParams.set('page', page);
            }
            window.history.pushState({page: page}, '', newUrl);
        }
    }

    function showErrorMessage(message) {
        $('#order-list-content').removeClass('loading-transition').html(`
            <div class="no-orders" style="color: #dc3545;">
                <i class="fa fa-exclamation-triangle" style="font-size: 36px; color: #dc3545; margin-bottom: 15px;"></i>
                <h3>${message}</h3>
                <button onclick="loadOrderPage(${currentPage})" class="back-button" style="margin-top: 15px;">
                    <i class="fa fa-refresh"></i> Thử lại
                </button>
            </div>
        `);
    }

    window.addEventListener('popstate', function (event) {
        if (event.state && event.state.page) {
            loadOrderPage(event.state.page);
        } else {
            const urlParams = new URLSearchParams(window.location.search);
            const page = parseInt(urlParams.get('page')) || 1;
            loadOrderPage(page);
        }
    });

    window.toggleOrderSummary = function (orderId) {
        const summary = $(`#summary-${orderId}`);
        summary.slideToggle(300);
    };

    window.cancelOrder = function (orderId) {
        if (!confirm('Bạn có chắc chắn muốn hủy đơn hàng này?\n\nHành động này không thể hoàn tác.')) {
            return;
        }

        const cancelBtn = $(`button[onclick="cancelOrder(${orderId})"]`);
        const originalText = cancelBtn.text();
        cancelBtn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang hủy...');

        $.ajax({
            url: 'orderInformation',
            type: 'POST',
            data: {
                action: 'cancel',
                orderId: orderId
            },
            timeout: 10000,
            success: function (response) {
                try {
                    const result = typeof response === 'string' ? JSON.parse(response) : response;
                    if (result.success) {
                        // Show success message
                        showSuccessMessage('Hủy đơn hàng thành công!');
                        // Reload current page after short delay
                        setTimeout(() => {
                            loadOrderPage(currentPage);
                        }, 1500);
                    } else {
                        alert('Không thể hủy đơn hàng: ' + (result.message || 'Lỗi không xác định'));
                        cancelBtn.prop('disabled', false).text(originalText);
                    }
                } catch (error) {
                    console.error('Error parsing cancel response:', error);
                    alert('Có lỗi xảy ra khi xử lý phản hồi');
                    cancelBtn.prop('disabled', false).text(originalText);
                }
            },
            error: function (xhr, status, error) {
                console.error('Cancel order error:', {xhr, status, error});
                let errorMessage = 'Có lỗi xảy ra khi hủy đơn hàng!';
                if (status === 'timeout') {
                    errorMessage = 'Quá thời gian chờ, vui lòng thử lại';
                }
                alert(errorMessage);
                cancelBtn.prop('disabled', false).text(originalText);
            }
        });
    };

    function showSuccessMessage(message) {
        const notification = $(`
            <div id="success-notification" style="
                position: fixed; top: 20px; right: 20px; z-index: 9999;
                background: #28a745; color: white; padding: 15px 20px;
                border-radius: 5px; box-shadow: 0 4px 12px rgba(0,0,0,0.3);
                font-family: 'Poppins', sans-serif;
            ">
                <i class="fa fa-check-circle"></i> ${message}
            </div>
        `);

        $('body').append(notification);
        setTimeout(() => {
            notification.fadeOut(300, function () {
                $(this).remove();
            });
        }, 3000);
    }
});