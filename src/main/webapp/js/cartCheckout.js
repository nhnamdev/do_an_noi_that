document.addEventListener('DOMContentLoaded', function () {
    loadProvinces();
    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');

    if (provinceSelect) {
        provinceSelect.addEventListener('change', loadDistricts);
    }

    if (districtSelect) {
        districtSelect.addEventListener('change', loadWards);
    }

    if (wardSelect) {
        wardSelect.addEventListener('change', calculateShippingFee);
    }
});

function loadProvinces() {
    const provinceSelect = document.getElementById('province');
    provinceSelect.innerHTML = '<option value="">Đang tải...</option>';
    // Gọi API lấy danh sách tỉnh/thành phố
    fetch(contextPath + '/api/provinces', {
        method: 'GET',
        headers: {'Content-Type': 'application/json'}
    })
        .then(response => response.json())
        .then(data => {
            provinceSelect.innerHTML = '<option value="">Chọn Tỉnh/Thành phố</option>';

            if (data.code === 200 && data.data) {
                data.data
                    .sort((a, b) => a.ProvinceName.localeCompare(b.ProvinceName))
                    .forEach(province => {
                        const option = document.createElement('option');
                        option.value = province.ProvinceID;
                        option.textContent = province.ProvinceName;
                        provinceSelect.appendChild(option);
                    });
                processExistingAddress();
            } else {
                provinceSelect.innerHTML = '<option value="">Không thể tải dữ liệu</option>';
            }
        })
        .catch(error => {
            // kiem tra loi in vao console
            console.error("Lỗi khi tải tỉnh/thành phố:", error);
        });
}

function loadDistricts() {
    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');

    const provinceId = provinceSelect.value;
    districtSelect.innerHTML = '<option value="">Đang tải...</option>';
    wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';

    if (!provinceId) {
        districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';
        return;
    }
    // Gọi API lấy danh sách quận/huyện theo province_id
    fetch(contextPath + '/api/districts?province_id=' + encodeURIComponent(provinceId), {
        method: 'GET',
        headers: {'Content-Type': 'application/json'}
    })
        .then(response => response.json())
        .then(data => {
            districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';

            if (data && data.code === 200 && data.data && Array.isArray(data.data)) {
                data.data
                    .sort((a, b) => a.DistrictName.localeCompare(b.DistrictName))
                    .forEach(district => {
                        const option = document.createElement('option');
                        option.value = district.DistrictID;
                        option.textContent = district.DistrictName;
                        districtSelect.appendChild(option);
                    });
            } else {
                districtSelect.innerHTML = '<option value="">Không thể tải dữ liệu</option>';
            }
        })
        .catch(error => {
            console.error("Lỗi khi tải quận/huyện:", error);
            districtSelect.innerHTML = '<option value="">Lỗi kết nối</option>';
        });
}

function loadWards() {
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');

    if (!districtSelect || !wardSelect) return;

    wardSelect.innerHTML = '<option value="">Đang tải...</option>';

    const districtId = districtSelect.value;
    if (!districtId) {
        wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';
        return;
    }
    // Gọi API lấy danh sách phuoường/xã theo district_id
    fetch(contextPath + '/api/wards?district_id=' + districtId, {
        method: 'GET',
        headers: {'Content-Type': 'application/json'}
    })
        .then(response => response.json())
        .then(data => {
            wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';

            if (data.code === 200 && data.data) {
                data.data
                    .sort((a, b) => a.WardName.localeCompare(b.WardName))
                    .forEach(ward => {
                        const option = document.createElement('option');
                        option.value = ward.WardCode;
                        option.textContent = ward.WardName;
                        wardSelect.appendChild(option);
                    });
            } else {
                wardSelect.innerHTML = '<option value="">Không thể tải dữ liệu</option>';
            }
        })
        .catch(error => {
            console.error("Lỗi khi tải phường/xã:", error);
            wardSelect.innerHTML = '<option value="">Lỗi kết nối</option>';
        });
}

// neu dia chi da co ben trang personal.jsp, sync qua va tach dia chi theo tinh/thanh, phuong/xa, quan/huyen
function processExistingAddress() {
    const addressInput = document.getElementById('address');
    if (!addressInput) return;

    const fullAddress = addressInput.value.trim();
    if (!fullAddress) return;

    const addressParts = fullAddress.split(', ');
    if (addressParts.length >= 4) {
        const provinceName = addressParts[addressParts.length - 1].trim();
        const districtName = addressParts[addressParts.length - 2].trim();
        const wardName = addressParts[addressParts.length - 3].trim();
        const streetAddress = addressParts.slice(0, addressParts.length - 3).join(', ').trim();

        document.getElementById('address').value = streetAddress;

        setTimeout(() => selectProvinceByName(provinceName, districtName, wardName), 1000);
    }
}

function selectProvinceByName(provinceName, districtName, wardName) {
    const provinceSelect = document.getElementById('province');
    for (let i = 0; i < provinceSelect.options.length; i++) {
        if (provinceSelect.options[i].textContent === provinceName) {
            provinceSelect.selectedIndex = i;
            loadDistricts();
            setTimeout(() => selectDistrictByName(districtName, wardName), 1000);
            break;
        }
    }
}

function selectDistrictByName(districtName, wardName) {
    const districtSelect = document.getElementById('district');
    for (let i = 0; i < districtSelect.options.length; i++) {
        if (districtSelect.options[i].textContent === districtName) {
            districtSelect.selectedIndex = i;
            loadWards();
            setTimeout(() => selectWardByName(wardName), 1000);
            break;
        }
    }
}

function selectWardByName(wardName) {
    const wardSelect = document.getElementById('ward');
    for (let i = 0; i < wardSelect.options.length; i++) {
        if (wardSelect.options[i].textContent === wardName) {
            wardSelect.selectedIndex = i;
            setTimeout(calculateShippingFee, 500);
            break;
        }
    }
}

// tinh phi van chuyen
function calculateShippingFee() {
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');
    const shippingFeeElement = document.getElementById('shipping-fee-display');
    // debug in ra xem da nhan dc quan/huyen phuong/xa chua
    console.log("District:", districtSelect);
    console.log("Ward:", wardSelect);
    console.log("Shipping fee element:", shippingFeeElement);

    // ktra neu chua chon du dia chi
    if (!districtSelect.value || !wardSelect.value) {
        alert("Chưa chọn đủ địa chỉ")
        return;
    }
    // Gọi API tính phí vận chuyển
    fetch(`${contextPath}/api/shippingFee?to_district_id=${districtSelect.value}&to_ward_code=${wardSelect.value}`)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log("API response:", data);

            if (data.code === 200 && data.data) {
                const shippingFee = parseInt(data.data.total);
                shippingFeeElement.textContent = new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND',
                    minimumFractionDigits: 0
                }).format(shippingFee).replace('₫', 'đ');

                // Thêm input ẩn để lưu thông tin phí vận chuyển khi submit form
                let shippingFeeInput = document.getElementById('shipping-fee-input');
                if (!shippingFeeInput) {
                    shippingFeeInput = document.createElement('input');
                    shippingFeeInput.type = 'hidden';
                    shippingFeeInput.id = 'shipping-fee-input';
                    shippingFeeInput.name = 'shipping-fee';

                    const form = document.querySelector('form.checkout-cart');
                    if (form) {
                        form.appendChild(shippingFeeInput);
                    }
                }

                if (shippingFeeInput) {
                    shippingFeeInput.value = shippingFee;
                }
                // cap nhat thanh toan
                updateTotalPayment(shippingFee);
            } else {
                shippingFeeElement.textContent = 'Không thể tính phí vận chuyển';
            }
        })
        .catch(error => {
            console.error('Chi tiết lỗi:', error);
            shippingFeeElement.textContent = 'Lỗi khi tính phí vận chuyển';
        });
}

function updateTotalPayment(shippingFee) {
    const totalAmountElement = document.getElementById('total-product');

    if (!totalAmountElement) {
        console.error("Không tìm thấy phần tử hiển thị tổng tiền hàng");
        return;
    }

    const totalAmountText = totalAmountElement.textContent;

    // Chuyển đổi từ định dạng "32,000đ" sang số
    const totalAmount = parseInt(totalAmountText.replace(/[^\d]/g, ''));
    console.log("Tổng tiền hàng (số):", totalAmount);

    if (isNaN(totalAmount)) {
        console.error("Không thể chuyển đổi tổng tiền hàng thành số");
        return;
    }

    // tong tien
    const totalPayment = totalAmount + shippingFee;

    const grandTotalElement = document.getElementById('total-invoice');

    if (!grandTotalElement) {
        console.error("Không tìm thấy phần tử hiển thị tổng thanh toán");
        return;
    }

    grandTotalElement.textContent = new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND',
        minimumFractionDigits: 0
    }).format(totalPayment).replace('₫', 'đ');
    // Cập nhật giá trị input ẩn tổng thanh toán gửi lên server
    const totalBillInput = document.getElementById('totalBillInput');
    if (totalBillInput) {
        totalBillInput.value = totalPayment;
    }

    console.log("Đã cập nhật tổng thanh toán thành công");
}