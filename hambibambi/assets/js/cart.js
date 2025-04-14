document.addEventListener("DOMContentLoaded", function() {
    const cartIcon = document.querySelector('.kosarikon');
    const cartCloseBtn = document.querySelector('.fa-close');
    const cartBox = document.querySelector('.cartBox');
    const isLoggedIn = document.body.getAttribute('data-is-logged-in') === 'true'; // Ellenőrizzük a bejelentkezési állapotot

    if (cartIcon) {
        cartIcon.addEventListener("click", function() {
            cartBox.classList.add('active');
            document.body.style.overflow = 'hidden'; // Tiltott görgetés
        });
    }

    if (cartCloseBtn) {
        cartCloseBtn.addEventListener("click", function() {
            cartBox.classList.remove('active');
            document.body.style.overflow = ''; // Alapértelmezett görgetés
        });
    }

    // Kosár feltöltése
    document.body.addEventListener("click", function(e) {
        if (e.target.classList.contains("kosarhoz")) {
            if (!isLoggedIn) {
                alert("A termék hozzáadásához be kell jelentkeznie!");
                return; // Ha nincs bejelentkezve, kilépünk
            }

            console.log("Kosárba gomb megnyomva!");

            let productCard = e.target.closest('.product');

            if (!productCard) return;

            let productId = productCard.getAttribute('data-id'); // A product_id értéke
            let productName = productCard.querySelector('.card-title').innerText;
            let productPrice = parseInt(productCard.querySelector('.ar').innerText);
            let productQuantity = parseInt(productCard.querySelector('#quantity').value);
            let productImage = productCard.querySelector('img').src;

            let item = {
                id: productId, // A product_id értéke kerül ide
                name: productName,
                price: productPrice,
                quantity: productQuantity,
                image: productImage
            };

            let cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
            let existingItem = cartItems.find(data => data.id === item.id);

            if (existingItem) {
                existingItem.quantity += item.quantity;
            } else {
                cartItems.push(item);
            }

            localStorage.setItem("cartItems", JSON.stringify(cartItems));
            console.log("Kosár tartalma:", cartItems);
            updateCartCounter();
            updateCartBox();
        }
    });

    function updateCartCounter() {
        const cartIconCounter = document.querySelector('.kosarikon p');
        let totalQuantity = 0;
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
        cartItems.forEach(data => totalQuantity += data.quantity);
        if (cartIconCounter) {
            cartIconCounter.innerText = totalQuantity;
        }
    }

    function updateCartBox() {
        if (!cartBox) return;
        const cartBoxTable = cartBox.querySelector('table');
        if (!cartBoxTable) return;

        let tableData = '<tr><th>Termék</th><th>Név</th><th>Mennyiség</th><th>Ár</th><th></th></tr>';
        let cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

        if (cartItems.length === 0) {
            tableData += '<tr><td colspan="5">A kosár üres</td></tr>';
        } else {
            cartItems.forEach(data => { 
                let totalPrice = data.price * data.quantity;
                tableData += `<tr>
                    <td><img src="${data.image}" width="50"></td>
                    <td>${data.name}</td>
                    <td>${data.quantity}</td>
                    <td class="prices">${totalPrice} Ft</td>
                    <td><a href="#" class="termekTorlese" onclick="Delete('${data.id}');">Termék törlése</a></td>
                </tr>`;            
            });
        }

        let totalSum = cartItems.reduce((sum, data) => sum + data.price * data.quantity, 0);
        tableData += `<tr>
            <th colspan="3"><a href="/hambibambi/application/view/checkout/checkout.php">Megrendelés</a></th>
            <th>Végösszeg: ${totalSum} Ft</th>
            <th><a href="#" onclick="clearAll();">Minden termék törlése</a></th>
        </tr>`;

        cartBoxTable.innerHTML = tableData;
    }

    window.Delete = function(itemId) {
        let cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
        cartItems = cartItems.filter(data => data.id !== itemId);
        localStorage.setItem('cartItems', JSON.stringify(cartItems));
        updateCartCounter();
        updateCartBox();
    };

    window.clearAll = function() {
        localStorage.removeItem('cartItems');
        updateCartCounter();
        updateCartBox();
    };

    updateCartCounter();
    updateCartBox();
});
