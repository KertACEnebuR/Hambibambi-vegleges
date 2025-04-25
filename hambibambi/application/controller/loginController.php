<?php
session_start();

include "../../../connect.php";

// Ellenőrzi, hogy a felhasználó már be van-e jelentkezve
if (isset($_SESSION['user_id'])) {
    header("location: loginregLogin.php");
    exit();
}

//Bejelentkezés a weboldalra
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['email'], $_POST['password'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Ellenőrizzük, hogy az email szerepel-e az adatbázisban
    $stmt = $conn->prepare("SELECT user_id, password FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();

    if (!$user) {
        $error = "A felhasználó nem található!";
    } else {
        error_log("Hashed password from DB: " . $user['password']);
        error_log("Entered password: " . $password);

        if (password_verify($password, $user['password'])) {
            // Bejelentkezés sikeres, munkamenet beállítása
            $_SESSION['user_id'] = $user['user_id'];
            echo "<script>
                    alert('Sikerkes bejelentkezés!');
                    window.location.href = '../../../index.php';
                </script>";
            exit();
        } else {
            $error = "Hibás email vagy jelszó!";
        }
    }
}
?>