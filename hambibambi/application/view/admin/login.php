<?php
session_start();
require "../../../connect.php"; // Csatlakozás az adatbázishoz

// Ha az admin már be van jelentkezve, irányítsuk át a dashboardra
if (!empty($_SESSION['admin_logged_in']) && $_SESSION['admin_logged_in'] === true) {
    header("Location: dashboard.php");
    exit;
}

// Ellenőrizzük, hogy a POST kérés érkezett-e
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = trim($_POST['username']);
    $password = trim($_POST['password']);

    if (!empty($username) && !empty($password)) {
        // Az admin adatainak lekérdezése az adatbázisból
        $sql = "SELECT admin_id, username, password FROM admin WHERE username = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows == 1) {
            $admin = $result->fetch_assoc();
            // Jelszó ellenőrzése
            if (password_verify($password, $admin['password'])) {
                // Bejelentkezés sikeres, session változók beállítása
                $_SESSION['admin_logged_in'] = true;
                $_SESSION['admin_id'] = $admin['admin_id']; // FONTOS: admin_id helyesen!
                $_SESSION['admin_username'] = $admin['username'];

                // Sikeres bejelentkezés után irányítsuk át a dashboardra
                header("Location: ../admin/dashboard.php");
                exit;
            } else {
                $error = "Hibás jelszó!";
            }
        } else {
            $error = "Nincs ilyen felhasználó!";
        }
    } else {
        $error = "Minden mezőt ki kell tölteni!";
    }
}
?>
<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../../assets/css/adminlogin.css">
    <link rel="stylesheet" href="../../../assets/css/main.css">
    <title>Admin Bejelentkezés</title>
</head>
<body>
    <h1>Admin Bejelentkezés</h1>
    <?php if (!empty($error)) echo "<p style='color: red;'>$error</p>"; ?>
    <div class="container">
    <form method="post">
        <label>Felhasználónév:</label>
        <input type="text" name="username" required>
        <br>
        <label>Jelszó:</label>
        <input type="password" name="password" required>
        <br>
        <button type="submit">Bejelentkezés</button>
    </form>
    </div>
</body>
</html>
