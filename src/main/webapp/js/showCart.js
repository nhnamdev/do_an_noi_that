const shoppingButton = document.querySelector('.Shopping');
const infoBox = document.getElementById('infoBox');
const overlay = document.getElementById('overlay');
const shoppingIcon = shoppingButton.querySelector('.Shopping i');

shoppingButton.addEventListener('click', (event) => {
    event.preventDefault();
    infoBox.classList.toggle('active');
    overlay.classList.toggle('active');
    shoppingIcon.classList.toggle('active-icon');
});

overlay.addEventListener('click', () => {
    infoBox.classList.remove('active');
    overlay.classList.remove('active');
    shoppingIcon.classList.remove('active-icon');
});