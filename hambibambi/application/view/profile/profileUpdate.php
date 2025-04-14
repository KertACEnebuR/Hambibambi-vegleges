<?php 
session_start();
include_once "../../../connect.php";

if (!isset($_SESSION['user_id'])) {
    echo "<script>
            alert('Hozzáférés megtagadva!');
        </script>";
    exit(); 
}

// Megyék és települések lekérdezése
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
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user_id = $_SESSION['user_id'];

    // Ellenőrizzük, hogy a szükséges mezők léteznek-e
    $full_name = isset($_POST['fullname']) ? mysqli_real_escape_string($conn, $_POST['fullname']) : '';
    $email = isset($_POST['email']) ? mysqli_real_escape_string($conn, $_POST['email']) : '';
    $phone_number = isset($_POST['phone_number']) ? mysqli_real_escape_string($conn, $_POST['phone_number']) : '';
    $address = isset($_POST['address']) ? mysqli_real_escape_string($conn, $_POST['address']) : '';
    $county_name = isset($_POST['county_name']) ? mysqli_real_escape_string($conn, $_POST['county_name']) : '';
    $settlement_id = isset($_POST['settlement_id']) ? mysqli_real_escape_string($conn, $_POST['settlement_id']) : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';
    $new_password = isset($_POST['new_password']) ? $_POST['new_password'] : '';
    $confirm_password = isset($_POST['confirm_password']) ? $_POST['confirm_password'] : '';

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo "<script>
                alert('Érvénytelen e-mail cím formátum!');
                window.location.href = 'profileUpdate.php';
            </script>";
        exit();
    }

    $sql = "SELECT password FROM users WHERE user_id = '$user_id'";
    $result = mysqli_query($conn, $sql);
    $row = mysqli_fetch_assoc($result);

    if (!$row || !password_verify($password, $row['password'])) {
        echo "<script>
                alert('Hibás jelszó!');
                window.location.href = 'profileUpdate.php';
              </script>";
        exit();
    }

    if (!empty($new_password)) {
        if (!preg_match('/^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$/', $new_password)) {
            echo "<script>
                    alert('Az új jelszónak legalább 8 karakter hosszúnak kell lennie, tartalmaznia kell egy nagybetűt és egy számot!');
                    window.location.href = 'profileUpdate.php';
                </script>";
            exit();
        }

        if ($new_password !== $confirm_password) {
            echo "<script>
                    alert('Az új jelszavak nem egyeznek meg!');
                    window.location.href = 'profileUpdate.php';
                </script>";
            exit();
        }

        $hashed_password = password_hash($new_password, PASSWORD_DEFAULT);
    } else {
        $hashed_password = $row['password'];
    }

    $update_query = "
        UPDATE users 
        SET 
            full_name = '$full_name', 
            email = '$email', 
            phone_number = '$phone_number', 
            address = '$address', 
            settlement_id = '$settlement_id',
            password = '$hashed_password'
        WHERE user_id = '$user_id'
    ";

    if (mysqli_query($conn, $update_query)) {
        // Sikeres frissítés esetén átirányítás a profil oldalra
        echo "<script>
                alert('Sikeres az adatok szerkesztése!');
                window.location.href = 'profileUpdate.php';
            </script>";
        exit();
    } else {
        echo "<script>
                alert('Hiba történt az adatok frissítése során!'. mysqli_error($conn));
                window.location.href = 'profileUpdate.php';
            </script>";
    }
} else {
    //űrlap adatok beolvasása
    $user_id = $_SESSION['user_id'];

    $sql = "SELECT * FROM users
            LEFT JOIN settlements 
            ON users.settlement_id = settlements.settlement_id
            LEFT JOIN counties 
            ON settlements.county_id = counties.county_id  
            WHERE user_id = {$user_id}";
    $result = mysqli_query($conn, $sql) or die(mysqli_error($conn));

    $row = mysqli_fetch_assoc($result);

    $full_name = $row['full_name'] ?? "Nincs adat";
    $email = $row['email'] ?? "Nincs adat";
    $phone_number = $row['phone_number'] ?? "Nincs adat";
    $address = $row['address'] ?? "Nincs adat";
    $settlementName = $row['settlement_name'] ?? "Nincs adat";
    $countyName = $row['county_name'] ?? "Nincs adat";
    $hash = $row['password'] ?? "Nincs adat"; //a titkosított jelszó beolvasása
    $writtenpass = "" ?? "Nincs adat";
}
?>
<!DOCTYPE html>
<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../../assets/css/profileUpdate.css">
    <link rel="stylesheet" href="../../../assets/css/main.css">
    <title>Chat</title>
</head>
<body>

<div class="content">
    <div class="wrapper">
        <h1>Adatok módosítása</h1>
        <section class="form signup">
            <form action="profileUpdate.php" method="POST" enctype="multipart/form-data" autocomplete="off">
                <div class="error-txt" hidden></div>
                <input type="hidden" id="user_id" name="user_id" value="<?php echo $user_id; ?>">
                <div class="field input">
                    <label>Teljes név:</label>
                    <input type="text" placeholder="Teljes név" name="fullname" value="<?php echo $full_name; ?>" required>
                </div>
                <div class="field input">
                    <label>E-mail:</label>
                    <input type="email" placeholder="E-mail cím" name="email" value="<?php echo $email; ?>" required>
                </div>
                <div class="field input">
                    <label>Telefonszám:</label>
                    <input type="text" placeholder="Telefonszám" maxlength="11" name="phone_number" value="<?php echo $phone_number; ?>" required 
                    pattern="^36\d{9}$"
                    title="A telefonszámnak 36-tal kell kezdődnie, és pontosan 11 számjegyből kell állnia.">
                </div>
                <div class="field input">
                    <label for="county">Vármegye:</label>
                    <select id="county" name="county_name" required onchange="updateSettlements()">
                        <option value="">Válasszon</option>
                        <?php foreach ($counties as $county => $settlements): ?>
                            <option value="<?= htmlspecialchars($county) ?>" <?= $county === $countyName ? 'selected' : '' ?>>
                                <?= htmlspecialchars($county) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="field input">
                    <label for="address">Település:</label>
                    <select id="settlement" name="settlement_id" required>
                        <option value="">Válasszon</option>
                        <?php foreach ($counties[$countyName] as $settlement): ?>
                            <option value="<?= htmlspecialchars($settlement['settlement_id']) ?>" 
                                <?= $settlement['settlement_id'] == $row['settlement_id'] ? 'selected' : '' ?>>
                                <?= htmlspecialchars($settlement['settlement_name']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="field input">
                    <label>Lakcím:</label>
                    <input type="text" placeholder="Lakcím" name="address" value="<?php echo $address; ?>" required>
                </div>
                <div class="field input">
                    <label for="password">Jelszó:</label>
                    <input type="password" placeholder="Jelenlegi jelszó" name="password" required>
                </div>
                <div class="field input">
                    <label>Új jelszó (opcionális):</label>
                    <input type="password" placeholder="Új jelszó" name="new_password"
                           pattern="(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}" 
                           title="A jelszónak legalább 8 karakter hosszúnak kell lennie, tartalmaznia kell egy nagybetűt és egy számot.">
                </div>
                <div class="field input">
                    <label>Új jelszó megerősítése:</label>
                    <input type="password" placeholder="Új jelszó megerősítése" name="confirm_password">
                </div>
                <div class="field button">
                    <input type="submit" class="mentes" value="Módosítások mentése">
                    <input type="submit" class="vissza" onclick="window.location.href='profile.php'" value="くくくVissza">
                </div>
            </form>
        </section>
    </div>
</div>
<script src="<?= $Path."assets/js/main.js";?>"></script>
<script>
    var counties = <?= json_encode($counties, JSON_UNESCAPED_UNICODE); ?>;
    function updateSettlements() {
        const county = document.getElementById('county').value;
        const settlementDropdown = document.getElementById('settlement');

        settlementDropdown.innerHTML = '<option value="">Válasszon</option>';

        if (counties[county]) {
            counties[county].forEach(settlement => {
                const isSelected = settlement.settlement_id == <?= json_encode($row['settlement_id']); ?>;
                settlementDropdown.innerHTML += `<option value="${settlement.settlement_id}" ${isSelected ? 'selected' : ''}>${settlement.settlement_name}</option>`;
            });
        }
    }

    if (!preg_match('/^36\d{9}$/', $phone_number)) {
    alert("A telefonszám formátuma érvénytelen. A telefonszámnak 36-tal kell kezdődnie, és pontosan 11 számjegyből kell állnia.");
    exit();
    }
</script>
</body>

</html>