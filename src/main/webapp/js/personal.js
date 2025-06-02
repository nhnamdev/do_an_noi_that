// personal.js - Script cho trang personal.jsp

document.addEventListener('DOMContentLoaded', function () {
    loadProvincesFromGHN();
});

function loadProvincesFromGHN() {
    const provinceSelect = document.getElementById('province');
    if (!provinceSelect) return;

    provinceSelect.innerHTML = '<option value="">Đang tải...</option>';

    fetch('/api/provinces', {
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
                        option.setAttribute('data-name', province.ProvinceName);
                        provinceSelect.appendChild(option);
                    });
            } else {
                provinceSelect.innerHTML = '<option value="">Không thể tải dữ liệu</option>';
            }
        })
        .catch(error => {
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

    fetch('/api/districts?province_id=' + encodeURIComponent(provinceId), {
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
                        option.setAttribute('data-name', district.DistrictName);
                        districtSelect.appendChild(option);
                    });
            } else {
                districtSelect.innerHTML = '<option value="">Không thể tải dữ liệu</option>';
            }
        })
        .catch(error => {
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

    fetch('/api/wards?district_id=' + districtId, {
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
                        option.setAttribute('data-name', ward.WardName);
                        wardSelect.appendChild(option);
                    });
            } else {
                wardSelect.innerHTML = '<option value="">Không thể tải dữ liệu</option>';
            }
        })
        .catch(error => {
            wardSelect.innerHTML = '<option value="">Lỗi kết nối</option>';
        });
}

function saveAddressToStorage() {
    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');
    const addressInput = document.getElementById('userAddressInput');

    if (provinceSelect.value && districtSelect.value && wardSelect.value) {
        const addressData = {
            provinceId: provinceSelect.value,
            provinceName: provinceSelect.options[provinceSelect.selectedIndex].getAttribute('data-name'),
            districtId: districtSelect.value,
            districtName: districtSelect.options[districtSelect.selectedIndex].getAttribute('data-name'),
            wardCode: wardSelect.value,
            wardName: wardSelect.options[wardSelect.selectedIndex].getAttribute('data-name'),
            streetAddress: addressInput ? addressInput.value : '',
            timestamp: new Date().getTime()
        };

        localStorage.setItem('selectedAddress', JSON.stringify(addressData));
    }
}

function parseAndSetAddress(fullAddress) {
    if (!fullAddress || fullAddress === '') return;

    const addressParts = fullAddress.split(", ");

    if (addressParts.length >= 4) {
        const provinceName = addressParts[addressParts.length - 1].trim();
        const districtName = addressParts[addressParts.length - 2].trim();
        const wardName = addressParts[addressParts.length - 3].trim();
        const streetAddress = addressParts.slice(0, addressParts.length - 3).join(", ").trim();

        $("#userAddressInput").val(streetAddress);

        setTimeout(() => {
            $("#province option").each(function () {
                if ($(this).attr('data-name') === provinceName) {
                    $(this).prop('selected', true);
                    loadDistricts();

                    setTimeout(() => {
                        $("#district option").each(function () {
                            if ($(this).attr('data-name') === districtName) {
                                $(this).prop('selected', true);
                                loadWards();

                                setTimeout(() => {
                                    $("#ward option").each(function () {
                                        if ($(this).attr('data-name') === wardName) {
                                            $(this).prop('selected', true);
                                            saveAddressToStorage();
                                            return false;
                                        }
                                    });
                                }, 1000);
                                return false;
                            }
                        });
                    }, 1000);
                    return false;
                }
            });
        }, 500);
    } else {
        $("#userAddressInput").val(fullAddress);
    }
}