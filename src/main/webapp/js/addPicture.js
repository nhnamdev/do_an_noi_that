function handleFile(event) {
    const file = event.target.files[0];
    const filenameDisplay = document.getElementById('filenameDisplay');

    if (file) {
        console.log("Đã chọn file: ", file.name);
        // Hiển thị tên file
        filenameDisplay.textContent = file.name; // Đặt tên file làm nội dung văn bản
    }
}


