document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    const cartItems = JSON.parse(localStorage.getItem("cartItems")) || [];

    // Kosár tartalmának megjelenítése
    const cartList = document.querySelector(".cart-items");
    let totalSum = 0;

    if (cartItems.length === 0) {
        cartList.innerHTML = `
            <li class="cart-item">
                <div>
                    <h3>A kosár üres</h3>
                </div>
            </li>`;
    } else {
        cartList.innerHTML = "";
        cartItems.forEach((item) => {
            const itemTotal = item.price * item.quantity;
            totalSum += itemTotal;

            cartList.innerHTML += `
                <li class="cart-item">
                    <div>
                        <h3>${item.name}</h3>
                        <small>Mennyiség: ${item.quantity}</small>
                    </div>
                    <span>${itemTotal} Ft</span>
                </li>`;
        });

        cartList.innerHTML += `
            <li class="cart-item total">
                <span>Végösszeg:</span>
                <strong>${totalSum} Ft</strong>
            </li>`;
    }

    // Form elküldése
    form.addEventListener("submit", function (event) {
        event.preventDefault();

        // Ellenőrizzük, hogy van-e termék a kosárban
        if (cartItems.length === 0) {
            alert("A kosár üres, nem lehet leadni a rendelést!");
            return;
        }

        // Ellenőrizzük a fizetési módot
        const paymentMethod = form.querySelector('input[name="payment"]:checked');
        if (!paymentMethod) {
            alert("Kérjük, válasszon fizetési módot!");
            return;
        }

        // Ellenőrizzük, hogy minden elem rendelkezik-e ID-val
        const invalidItems = cartItems.filter(item => !item.id || isNaN(item.id));
        if (invalidItems.length > 0) {
            alert("Hiba: Egy vagy több termék érvénytelen ID-val rendelkezik.");
            console.error("Érvénytelen termékek:", invalidItems);
            return;
        }

        // AJAX kérés a rendelés elküldéséhez
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "checkout.php", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    const response = JSON.parse(xhr.responseText);
                    if (response.success) {
                        localStorage.removeItem("cartItems");
                        window.location.href = response.redirect; // Átirányítás az URL-re
                    } else {
                        alert("Hiba: " + response.message);
                    }
                } catch (e) {
                    alert("Hiba történt a válasz feldolgozása során.");
                    console.error("JSON feldolgozási hiba:", e);
                }
            } else {
                alert("Hiba történt a rendelés feldolgozása során: " + xhr.responseText);
            }
        };

        xhr.onerror = function() {
            console.error("Hiba történt a kérés küldése során.");
            alert("Hiba történt a kérés küldése során.");
        };

        // Adatok összeállítása
        const data = new URLSearchParams();
        data.append("payment", paymentMethod.value);
        data.append("cartItems", JSON.stringify(cartItems));

        console.log("Küldött adatok:", JSON.stringify(cartItems));
        xhr.send(data.toString());
    });
});