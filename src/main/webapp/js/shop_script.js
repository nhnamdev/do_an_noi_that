// Danh sách sản phẩm từ HTML
const products = [
    {id: 1, name: "Sofa X12B", category: "ghe-sofa", price: 2350000},
    {id: 2, name: "Sofa K45M", category: "ghe-sofa", price: 3100000},
    {id: 3, name: "Sofa P89C", category: "ghe-sofa", price: 4750000},
    {id: 4, name: "Sofa A7F3", category: "ghe-sofa", price: 2800000},
    {id: 5, name: "Sofa Q32L", category: "ghe-sofa", price: 3050000},
    {id: 6, name: "Sofa Z91Y", category: "ghe-sofa", price: 4600000},
    {id: 7, name: "Sofa B4T8", category: "ghe-sofa", price: 3500000},
    {id: 8, name: "Sofa J7H2", category: "ghe-sofa", price: 5200000},
    {id: 9, name: "Sofa V21L", category: "ghe-sofa", price: 2900000},
    {id: 10, name: "Sofa T76Y", category: "ghe-sofa", price: 3400000},
    {id: 11, name: "Sofa R55F", category: "ghe-sofa", price: 4200000},
    {id: 12, name: "Sofa H5J7", category: "ghe-sofa", price: 5800000},
];

// Hàm hiển thị danh sách sản phẩm
function renderProducts(productList) {
    const productContainer = document.querySelector(".product-list .row");
    productContainer.innerHTML = ""; // Xóa nội dung cũ

    productList.forEach(product => {
        productContainer.innerHTML += `
            <div class="col-sm-3 p-3 col-md-3">
                <div class="product-block">
                    <div class="product-tumb">
                        <a href="../page_SingleProduct/SProduct.html">
                            <img src="../img/sofa${product.id}.jpg" alt="${product.name}">
                        </a>
                    </div>
                    <div class="product-detail">
                        <h4><a href="../page_SingleProduct/SProduct.html">${product.name}</a></h4>
                        <div class="product-bottom_detail">
                            <div class="price">${product.price.toLocaleString()} VND</div>
                        </div>
                    </div>
                </div>
            </div>
        `;
    });
}

document.getElementById("categoryFilter").addEventListener("change", function () {
    const selectedCategory = this.value;
    const filteredProducts = products.filter(product =>
        selectedCategory === "all" || product.category === selectedCategory
    );
    renderProducts(filteredProducts);
});

document.getElementById("priceFilter").addEventListener("change", function () {
    const selectedPrice = this.value;
    const filteredProducts = products.filter(product => {
        if (selectedPrice === "below-2") return product.price < 2000000;
        if (selectedPrice === "2-5") return product.price >= 2000000 && product.price <= 5000000;
        if (selectedPrice === "5-10") return product.price > 5000000 && product.price <= 10000000;
        if (selectedPrice === "above-10") return product.price > 10000000;
        return true;
    });
    renderProducts(filteredProducts);
});

document.getElementById("sortFilter").addEventListener("change", function () {
    const selectedSort = this.value;
    const sortedProducts = [...products].sort((a, b) => {
        if (selectedSort === "price_asc") return a.price - b.price;
        if (selectedSort === "price_desc") return b.price - a.price;
        return 0;
    });
    renderProducts(sortedProducts);
});

renderProducts(products);
    // Lấy phần tử icon và form tìm kiếm
    const searchIcon = document.getElementById("searchIcon");
    const searchForm = document.getElementById("searchForm");

    // Thêm sự kiện click cho icon tìm kiếm
    searchIcon.addEventListener("click", function (event) {
    event.preventDefault(); // Ngăn chặn hành động mặc định của link
    searchForm.style.display = (searchForm.style.display === "block") ? "none" : "block";
});
