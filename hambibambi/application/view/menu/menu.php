<?php

include("header.php");

include("../navbar/navbar.php");
?>

<div class="insideNavbar">
    <nav id = "navbar">
        <a class ="nav-link" href ="#hamburgers">Hamburgerek</a>
        <a class ="nav-link" href="#soups">Levesek</a>
        <a class ="nav-link" href="#salads">Saláták</a>
        <a class ="nav-link" href="#pastas">Tészták</a>
        <a class ="nav-link" href="#desserts">Sütemények</a>
        <a class ="nav-link" href="#drinks">Üdítők</a>
        <a class ="nav-link" href="#drinks2">Alkoholos italok</a>
    </nav>
</div>

<?php
require $Path . "application/view/product.php";

include("footer.php");

?>