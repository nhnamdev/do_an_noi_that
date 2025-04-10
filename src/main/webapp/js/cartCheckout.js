document.addEventListener('DOMContentLoaded', function () {
    loadProvinces();
    document.getElementById('province').addEventListener('change', loadDistricts);
    document.getElementById('district').addEventListener('change', loadWards);
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
        .catch(() => {
            provinceSelect.innerHTML = '<option value="">Lỗi kết nối</option>';
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
        .catch(() => {
            districtSelect.innerHTML = '<option value="">Lỗi kết nối</option>';
        });
}

function loadWards() {
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');

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
        .catch(() => {
            wardSelect.innerHTML = '<option value="">Lỗi kết nối</option>';
        });
}

// neu dia chi da co ben trang personal.jsp, sync qua va tach dia chi theo tinh/thanh, phuong/xa, quan/huyen
function processExistingAddress() {
    const fullAddress = document.getElementById('address').value.trim();
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