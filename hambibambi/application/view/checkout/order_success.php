<?php
session_start();
if (!isset($_GET['order_id'])) {
    die("Hibás rendelés azonosító.");
}

$order_id = (int)$_GET['order_id'];
?>
<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../../assets/css/order_success.css">
    <title>Köszönjük a rendelést!</title>
</head>
<body>
    <div class="container">
        <header>
            <h1>Köszönjük a rendelést!</h1>
        </header>
        <main>
            <p>Köszönjük, hogy nálunk vásárolt! Hamarosan felvesszük Önnel a kapcsolatot a rendelés kiszállításával kapcsolatban.</p>
            <a href="/hambibambi/index.php" class="btn">Vissza a főoldalra</a>
        </main>
    </div>
    <script src="<?= $Path."assets/js/main.js";?>"></script>
</body>
</html>