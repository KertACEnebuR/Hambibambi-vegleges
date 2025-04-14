<?php
session_start();
require("../../../connect.php");

// Hibakeresés bekapcsolása
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// JSON adatok feldolgozása
if ($_SERVER['REQUEST_METHOD'] === 'POST' && empty($_POST)) {
    $json = file_get_contents('php://input');
    $_POST = json_decode($json, true);
}

// Ellenőrizzük, hogy a felhasználó be van-e jelentkezve
if (!isset($_SESSION['user_id'])) {
    header('Content-Type: application/json');
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'Nincs bejelentkezve']);
    exit();
}

$user_id = $_SESSION['user_id'];

// Felhasználói adatok lekérése
$sql = "SELECT full_name, email, phone_number, settlements.settlement_name,
        counties.county_name, address 
        FROM users
        LEFT JOIN settlements ON users.settlement_id = settlements.settlement_id
        LEFT JOIN counties ON settlements.county_id = counties.county_id
        WHERE user_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
} else {
    header('Content-Type: application/json');
    http_response_code(404);
    echo json_encode(['success' => false, 'message' => 'Felhasználói adatok nem találhatók']);
    exit();
}

// Rendelés feldolgozása
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['payment']) && isset($_POST['cartItems'])) {
    $cartItems = json_decode($_POST['cartItems'], true);
    $payment_method = (int)$_POST['payment'];
    
    // Ellenőrizzük, hogy van-e kosár tartalom
    if (empty($cartItems)) {
        header('Content-Type: application/json');
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'A kosár üres, nem lehet leadni a rendelést']);
        exit();
    }
    
    // Tranzakció kezdete
    $conn->begin_transaction();
    
    try {
        // Rendelés létrehozása
        $order_date = date('Y-m-d H:i:s');
        $delivery_date = date('Y-m-d');
        
        $sql = "INSERT INTO orders (user_id, payment_id, order_status_id, order_date, delivery_date) 
                VALUES (?, ?, 1, ?, ?)";
        $stmt = $conn->prepare($sql);
        if (!$stmt) {
            throw new Exception("Prepare failed (Orders): " . $conn->error);
        }
        $stmt->bind_param("iiss", $user_id, $payment_method, $order_date, $delivery_date);
        if (!$stmt->execute()) {
            throw new Exception("Execute failed (Orders): " . $stmt->error);
        }
        
        $order_id = $conn->insert_id;
        
        // Termékek hozzáadása a kosárhoz
        foreach ($cartItems as $item) {
            $product_id = (int)$item['id'];
            $quantity = (int)$item['quantity'];
            
            $sql = "INSERT INTO baskets (product_id, order_id, quantity) 
                    VALUES (?, ?, ?)";
            $stmt = $conn->prepare($sql);
            if (!$stmt) {
                throw new Exception("Prepare failed (Baskets): " . $conn->error);
            }
            $stmt->bind_param("iii", $product_id, $order_id, $quantity);
            if (!$stmt->execute()) {
                throw new Exception("Execute failed (Baskets): " . $stmt->error);
            }
        }
        
        // Tranzakció véglegesítése
        $conn->commit();
        
        // Sikeres válasz
        echo json_encode([
            'success' => true,
            'redirect' => 'order_success.php?order_id=' . $order_id
        ]);
        exit();
        
    } catch (Exception $e) {
        $conn->rollback();
        header('Content-Type: application/json');
        http_response_code(400);
        echo json_encode([
            'success' => false,
            'message' => $e->getMessage()
        ]);
        exit();
    }
}

// Megyék lekérése
$counties = [];
$sql = "SELECT * FROM Counties ORDER BY county_name";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $counties[] = $row;
    }
}
?>

<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link rel="stylesheet" href="../../../assets/css/checkout.css">
</head>
<body>
    <div class="container">
        <header class="text-center">
            <h1>Rendelés véglegesítése</h1>
        </header>
        <main>
            <div class="checkout">
                <!-- Kosár tartalma -->
                <div class="cart-summary">
                    <h2>Kosár tartalma</h2>
                    <ul class="cart-items">
                        <li class="total"></li>
                    </ul>
                </div>

                <!-- Számlázási adatok -->
                <div class="rendeles">
                    <h2>Számlázási adatok</h2>
                    <form method="POST">
                        <div class="form-group">
                            <label for="fullName">Teljesnév</label>
                            <input class="adatok" type="text" id="fullName" value="<?= htmlspecialchars($user['full_name']) ?>" disabled>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input class="adatok" type="email" id="email" value="<?= htmlspecialchars($user['email']) ?>" disabled>
                        </div>
                        <div class="form-group">
                            <label for="tel">Telefonszám</label>
                            <input class="adatok" type="tel" id="tel" value="<?= htmlspecialchars($user['phone_number']) ?>" disabled>
                        </div>
                        <div class="form-group">
                            <label for="county">Vármegye</label>
                            <input class="adatok" type="text" id="county" value="<?= htmlspecialchars($user['county_name']) ?>" disabled>
                        </div>
                        <div class="form-group">
                            <label for="settlement">Település</label>
                            <input class="adatok" type="text" id="settlement" value="<?= htmlspecialchars($user['settlement_name']) ?>" disabled>
                        </div>
                        <div class="form-group">
                            <label for="address">Lakcím</label>
                            <input class="adatok" type="text" id="address" value="<?= htmlspecialchars($user['address']) ?>" disabled>
                        </div>
                        <h3>Fizetési mód</h3>
                        <div class="form-group">
                            <label><input type="radio" class="payment" name="payment" value="1" required> Készpénz</label>
                            <label><input type="radio" class="payment" name="payment" value="2" required> Bankkártya</label>
                            <label><input type="radio" class="payment" name="payment" value="3" required> SZÉP-kártya</label>
                        </div>
                        <button type="submit" class="submit-btn">Rendelés véglegesítése</button>
                    </form>
                </div>
            </div>
        </main>
    </div>
    <script src="../../../assets/js/checkout.js"></script>
    <script src="../../../assets/js/cart.js"></script>
    <script>
        const counties = <?= json_encode($counties) ?>;
    </script>
</body>
</html>