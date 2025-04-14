let mybutton = document.getElementById("top");

// Ha a felhasználó lejjebb görget 100px-et, a gomb megjelenik
window.onscroll = function () {
    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
        mybutton.style.display = "block";
    } else {
        mybutton.style.display = "none";
    }
};

// Visszagörgetés a tetejére
function toTheTop() {
    window.scrollTo({ top: 0, behavior: "smooth" });
}

document.addEventListener("input", function (event) {
    if (event.target.id === "quantity") {
        const input = event.target;
        if (input.value.length > 1) {
            input.value = input.value.slice(0, 1); // Csak az első számjegyet tartja meg
        }
    }
});

