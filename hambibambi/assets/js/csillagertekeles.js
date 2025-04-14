let stars = document.querySelectorAll('.star');
let ratingValue = document.getElementById('rating-value');
let ratingInput = document.getElementById('rating-input'); // Rejtett input mező
let selectedRating = 0;

stars.forEach(star => {
    star.addEventListener('click', () => {
        selectedRating = star.getAttribute('data-value');
        ratingValue.textContent = selectedRating;
        ratingInput.value = selectedRating; // Frissítjük a hidden input mező értékét

        stars.forEach(s => s.classList.remove('selected'));
        star.classList.add('selected');
        
        let prevSibling = star.previousElementSibling;
        while (prevSibling) {
            prevSibling.classList.add('selected');
            prevSibling = prevSibling.previousElementSibling;
        }
    });
});
