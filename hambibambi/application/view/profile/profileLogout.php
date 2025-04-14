<?php
session_start();

// Minden munkamenet változó törlése
$_SESSION = [];

// Munkamenet megsemmisítése
session_destroy();

// JavaScript alert üzenet megjelenítése és átirányítás a főoldalra, a kosár tartalmának törlése
echo "<script>
    localStorage.removeItem('cartItems'); // Kosár tartalmának törlése
    alert('Sikeresen kijelentkezett!');
    window.location.href = '../../../index.php';
</script>";
exit;