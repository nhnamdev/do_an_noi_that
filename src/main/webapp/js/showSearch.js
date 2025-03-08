document.getElementById('toggleButton').addEventListener('click', function() {
    var searchForm = document.getElementById('searchForm');
    if (searchForm.style.display === 'none' || searchForm.style.display === '') {
        searchForm.style.display = 'block';
    } else {
        searchForm.style.display = 'none';
    }
});