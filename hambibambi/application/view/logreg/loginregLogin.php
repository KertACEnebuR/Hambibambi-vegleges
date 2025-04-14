<?php include("../../controller/LoginController.php")?>
<?php include("header.php");?>
<?php include("../navbar/navbar.php");?>
<div class="container">
<div class="area2">
<div class="login-form">
    <h2>Bejelentkezés</h2>
    <?php if (isset($error)) echo "<p style='color:red;'>$error</p>"; ?>
    <form action="" method="POST">
        <div class="field input">
            <label for="email">Email:</label>
            <input type="email" name="email" placeholder="Email" required>
        </div>
        <div class="field input">
            <label for="password">Jelszó:</label>
            <input type="password" name="password" placeholder="Jelszó" required>
        </div>
        <button type="submit">Bejelentkezés</button>
        <div class="link">Ha még nincs regisztrációja: <a href="loginreg.php">Regisztráció</a></div>
    </form>
</div>
</div>
</div>
<?php include("../footer.php"); ?>