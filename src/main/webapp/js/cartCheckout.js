document.addEventListener('DOMContentLoaded', function () {
    fetch('data/provinceList.json')
        .then(response => response.json())
        .then(data => {
            const provinceSelect = document.getElementById('province');

            const uniqueProvinces = [...new Set(data.map(item => item.provinceName))];

            uniqueProvinces.forEach(provinceName => {
                const option = new Option(provinceName, provinceName);
                provinceSelect.add(option);
            });
        })
        .catch(error => {
            console.error('Lỗi tải danh sách tỉnh:', error);
        });
});

// load quận huyện khi chọn tỉnh thành
function loadDistricts() {
    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');

    districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';

    fetch('data/provinceList.json')
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
            console.error('Lỗi tải danh sách quận huyện:', error);
        });
}