    <footer>
    <nav>
            <ul class="navbar">
                <li><a href=<?= $Path."index.php";?>>Kezdőlap</a></li>
                <li><a href=<?= $Path."application/view/menu/menu.php";?>>Étlap</a></li>
                <li><a href=<?= $Path."application/view/contacts/contact.php";?>>Kapcsolat</a></li>
                <li><a href=<?= $Path."application/view/logreg/loginreg.php";?>>Belépés / Regisztráció</a></li>
            </ul>
        </nav>
        <h3>HambiBambi Étterem</h3>
        <div class="logo">
            <img src="<?= $Path."assets/img/HambiBambi_Logo.png"?>" alt="HambiBambi Étterem Logó">
        </div>  
        
    </footer>

        <script>
            var counties = <?= json_encode($counties, JSON_UNESCAPED_UNICODE); ?>;
            function updateSettlements() {
                const county = document.getElementById('county').value;
                const settlementDropdown = document.getElementById('settlement');

                settlementDropdown.innerHTML = '<option value="">Válasszon</option>';

                <?php foreach ($counties as $county => $settlements): ?>
                    if (county === <?= json_encode($county) ?>) {
                        <?php foreach ($settlements as $settlement): ?>
                            settlementDropdown.innerHTML += `<option value="<?= htmlspecialchars($settlement['settlement_id']) ?>"><?= htmlspecialchars($settlement['settlement_name']) ?></option>`;
                        <?php endforeach; ?>
                    }
                <?php endforeach; ?>
            }
        </script>
    <script src="../../../assets/js/loginreg.js"></script>
</body>
</html>