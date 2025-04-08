document.addEventListener('DOMContentLoaded', function () {
    // Bước 1: Load danh sách tỉnh/thành phố (giữ nguyên code hiện tại)
    fetch(contextPath + '/data/provinceList.json')
        .then(response => response.json())
        .then(data => {
            const provinceSelect = document.getElementById('province');

            // Thêm options cho tỉnh/thành phố
            const uniqueProvinces = [...new Set(data.map(item => item.provinceName))];
            uniqueProvinces.forEach(provinceName => {
                const option = new Option(provinceName, provinceName);
                provinceSelect.add(option);
            });

            // Bước 2: Phân tích địa chỉ từ session
            const fullAddress = document.getElementById('address').value.trim();
            console.log("Đang phân tích địa chỉ đầy đủ:", fullAddress);

            if (fullAddress) {
                // Tách địa chỉ theo dấu phẩy
                const addressParts = fullAddress.split(', ');

                if (addressParts.length >= 3) {
                    // Lấy phần tỉnh/thành phố (phần cuối)
                    const province = addressParts[addressParts.length - 1].trim();
                    // Lấy phần quận/huyện (phần gần cuối)
                    const district = addressParts[addressParts.length - 2].trim();
                    // Phần địa chỉ chi tiết (các phần còn lại)
                    const streetAddress = addressParts.slice(0, addressParts.length - 2).join(', ').trim();

                    console.log("Tỉnh/TP được phát hiện:", province);
                    console.log("Quận/Huyện được phát hiện:", district);
                    console.log("Địa chỉ chi tiết:", streetAddress);

                    // Cập nhật ô địa chỉ chỉ với phần đường/số nhà
                    document.getElementById('address').value = streetAddress;

                    // Bước 3: Chọn tỉnh/thành phố
                    if (province && provinceSelect) {
                        provinceSelect.value = province;

                        // Bước 4: Load quận/huyện dựa trên tỉnh/thành đã chọn
                        loadDistrictsAndSelect(district);
                    }
                }
            }
        })
        .catch(error => {
            console.error('Lỗi tải danh sách tỉnh:', error);
        });
});

// Hàm load quận/huyện và chọn một giá trị cụ thể
function loadDistrictsAndSelect(districtToSelect) {
    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');

    // Xóa các option cũ
    districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';

    // Lấy tỉnh/thành phố đã chọn
    const selectedProvinceName = provinceSelect.value;
    if (!selectedProvinceName) return;

    console.log("Đang load quận/huyện cho tỉnh:", selectedProvinceName);

    fetch(contextPath + '/data/provinceList.json')
        .then(response => response.json())
        .then(data => {
            // Lọc quận/huyện thuộc tỉnh/thành phố đã chọn
            const districtsForProvince = data
                .filter(item => item.provinceName === selectedProvinceName)
                .map(item => item.districtName);

            const uniqueDistricts = [...new Set(districtsForProvince)];

            // Thêm các options quận/huyện
            uniqueDistricts.forEach(districtName => {
                const option = new Option(districtName, districtName);
                districtSelect.add(option);
            });

            console.log("Đã load", uniqueDistricts.length, "quận/huyện");
            console.log("Đang cố gắng chọn quận/huyện:", districtToSelect);

            // Chọn quận/huyện đã xác định
            if (districtToSelect) {
                districtSelect.value = districtToSelect;

                // Nếu không tìm thấy, thử lại sau một chút
                if (districtSelect.value !== districtToSelect) {
                    console.log("Chưa tìm thấy quận/huyện, thử lại sau 500ms");
                    setTimeout(function () {
                        districtSelect.value = districtToSelect;
                    }, 500);
                }
            }
        })
        .catch(error => {
            console.error('Lỗi tải danh sách quận/huyện:', error);
        });
}

// Giữ nguyên hàm loadDistricts hiện tại cho sự kiện onChange
function loadDistricts() {
    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');

    districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';

    fetch(contextPath + '/data/provinceList.json')
        .then(response => response.json())
        .then(data => {
            const selectedProvinceName = provinceSelect.value;

            const districtsForProvince = data
                .filter(item => item.provinceName === selectedProvinceName)
                .map(item => item.districtName);

            const uniqueDistricts = [...new Set(districtsForProvince)];

            uniqueDistricts.forEach(districtName => {
                const option = new Option(districtName, districtName);
                districtSelect.add(option);
            });
        })
        .catch(error => {
            console.error('Lỗi tải danh sách quận/huyện:', error);
        });
}