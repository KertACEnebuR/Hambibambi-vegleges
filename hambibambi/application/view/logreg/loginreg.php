<?php include("../../controller/registrationController.php")?>
<?php include("header.php"); ?>
<?php include("../navbar/navbar.php"); ?>
<div class="container">
<div class="area1">
<div id="register" class="registration-form form-container">
        <h2>Regisztráció</h2>
        <form action="" method="POST">
            <div class="field input">
                <label for="full_name">Teljesnév:</label>
                <input type="text" name="full_name" placeholder="Teljesnév" required>
            </div>
            <div class="field input">
                <label for="email">Email:</label>
                <input type="email" name="email" placeholder="minta@gmail.com" required>
            </div>
            <div class="field input">
                <label for="password">Jelszó:</label>
                <input type="password" name="password" placeholder="Jelszó" required
                       pattern="(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}" 
                       title="A jelszónak legalább 8 karakter hosszúnak kell lennie, tartalmaznia kell egy nagybetűt és egy számot.">
            </div>
            <div class="field input">
                <label for="phone_number">Telefonszám:</label>
                <input type="text" name="phone_number" placeholder="36301234567" maxlength="11" required
                    pattern="^36\d{9}$"
                    title="A telefonszámnak 36-tal kell kezdődnie, és pontosan 11 számjegyből kell állnia.">
            </div>
            <div class="field input">
                <label for="address">Vármegye:</label>
                <select id="county" required onchange="updateSettlements()">
                    <option id="county" value="">Válasszon</option>
                    <?php foreach ($counties as $county => $settlements): ?>
                        <option id="county" value="<?= htmlspecialchars($county) ?>"><?= htmlspecialchars($county) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="field input">
                <label for="address">Település:</label>
                <select id="settlement" name="settlement_id" required>
                    <option id="settlement" value="">Válasszon</option>
                </select>
            </div>
            <div class="field input">   
                <label for="address">Cím:</label>
                <input type="text" name="address" placeholder="Lakcím" required>
            </div>
            <button type="submit">Regisztráció</button>
            <div class="link">Ha már van regisztrációja, <a href="loginregLogin.php">lépjen be</a></div>
        </form>
</div>
</div>
</div>
<?php include("footer.php"); ?>

