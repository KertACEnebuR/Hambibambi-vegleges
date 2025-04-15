<?php

include "../../../connect.php";

// Ellenőrzi, hogy a felhasználó már be van-e jelentkezve
if (isset($_SESSION['user_id'])) {
    header("Location: ./../loginreg.php");
    exit();
}

$sql = "SELECT counties.county_id, counties.county_name, settlements.settlement_name, settlements.settlement_id 
        FROM counties 
        LEFT JOIN settlements 
        ON counties.county_id = settlements.county_id
        ORDER BY county_name, settlement_name";

$result = $conn->query($sql);

$counties = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $countyName = $row['county_name'];
        $settlementName = $row['settlement_name'];

        // Ellenőrizzük, hogy a vármegye már létezik-e a tömbben
        if (!isset($counties[$countyName])) {
            $counties[$countyName] = [];
        }

        // Hozzáadjuk a települést a vármegyéhez
        if (!empty($settlementName)) { // Csak akkor adjuk hozzá, ha a település neve nem üres
            $counties[$countyName][] = $row;
        }
    }
}

// Regisztrációs adatok kezelése
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['full_name'], $_POST['email'], $_POST['password'], $_POST['phone_number'], $_POST['address'], $_POST['settlement_id'])) {
    $full_name = trim($_POST['full_name']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    $phone_number = trim($_POST['phone_number']);
    $address = trim($_POST['address']);
    $settlement_id = intval($_POST['settlement_id']);

    // Ellenőrizzük, hogy az e-mail már létezik-e
    $stmt = $conn->prepare("SELECT user_id FROM users WHERE email = ?");
    $stmt->bind_param("s", $email); // 's' jelzi, hogy az email egy string típusú paraméter
    $stmt->execute();
    $stmt->store_result(); // Ez tárolja az eredményeket

    if ($stmt->num_rows > 0) {
        echo "<script>
            alert('A felhasználó már regisztrálva van ezzel az e-mail címmel!');
            window.location.href = 'loginreg.php';
        </script>";
    } else {
        // Jelszó érvényesítése
        if (!preg_match('/^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$/', $password)) {
            echo "<script>
                    alert('A jelszónak legalább 8 karakter hosszúnak kell lennie, tartalmaznia kell egy nagybetűt és egy számot!');
                    window.location.href = 'loginreg.php';
                </script>";
            exit();
        }

        // Jelszó titkosítása
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        // Adatok mentése az adatbázisba
        $stmt = $conn->prepare("INSERT INTO users (full_name, email, password, phone_number, address, settlement_id, registration_date) 
        VALUES (?, ?, ?, ?, ?, ?, NOW())");
        $stmt->bind_param("sssssi", $full_name, $email, $hashed_password, $phone_number, $address, $settlement_id); // A paraméterek típusa: 's' (string)
        $stmt->execute();

        // Sikeres regisztráció után átirányítás
        echo "<script>
        alert('Sikeres regisztráció!');
        window.location.href = 'loginregLogin.php';
        </script>";
        exit();
    }
}

// Bejelentkezés a weboldalra
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['email'], $_POST['password'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Ellenőrizzük, hogy az email szerepel-e az adatbázisban
    $stmt = $conn->prepare("SELECT user_id, password FROM users WHERE email = ?");
    $stmt->bind_param("s", $email); // 's' jelzi, hogy az email egy string típusú paraméter
    $stmt->execute();
    $stmt->store_result();
    $stmt->bind_result($user_id, $hashed_password); // Az eredmény tárolása és a változókhoz rendelése
    $stmt->fetch();

    if ($user_id && password_verify($password, $hashed_password)) {
        // Bejelentkezés sikeres, munkamenet beállítása
        $_SESSION['user_id'] = $user_id;
        header("Location: ../../../index.php"); // Átirányítás a főoldalra
        exit();
    } else {
        $error = "Hibás email vagy jelszó!";
    }
}


$conn->close();
?>