<?php
session_start();

// Minden munkamenet változó törlése
$_SESSION = [];

// Munkamenet megsemmisítése
session_destroy();

// Visszairányítás a bejelentkezési oldalra
echo "<script>
    alert('Sikeresen kijelentkezett!');
    window.location.href = 'login.php';
</script>";
exit;
