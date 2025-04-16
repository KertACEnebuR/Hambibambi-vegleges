<?php
session_start();

// Ellenőrizzük, hogy az admin be van-e jelentkezve
if (!isset($_SESSION['admin_logged_in']) || $_SESSION['admin_logged_in'] !== true) {
    header("Location: login.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="hu" ng-app="productApp">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Új termék felvitele</title>
    <link rel="stylesheet" href="../../../assets/css/productform.css">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
</head>

<body ng-controller="ProductController">
    <h2>Új termék felvitele</h2>
    <form ng-submit="addProduct()">
        <label>Termék neve:</label>
        <input type="text" ng-model="product.product_name" required>

        <label>Ár:</label>
        <input type="number" ng-model="product.price" min="0" required>

        <label>Leírás:</label>
        <textarea ng-model="product.description" required></textarea>

        <label>Kép neve (pl. cezar_salata.jpg):</label>
        <input type="text" ng-model="product.picture" required>

        <label>Kategória név</label>
<select ng-model="product.product_category_id" required>
  <option value="">Válassz kategóriát</option>
  <option value="1">Saláta</option>
  <option value="2">Levesek</option>
  <option value="3">Hamburgerek</option>
  <option value="4">Tészták</option>
  <option value="5">Alkoholos italok</option>
  <option value="6">Üdítők</option>
  <option value="7">Sütemények</option>
</select>

<label>Mennyiségi egység</label>
<select ng-model="product.quantity_unit_id" required>
  <option value="">Válassz mennyiségi egységet</option>
  <option value="1">darab</option>
  <option value="2">adag</option>
  <option value="3">liter</option>
</select>

        <button type="submit">➕ Hozzáadás</button>
        <button type="button" onclick="window.location.href='dashboard.php'" class="dashboard-button">くくくVissza</button>
    </form>

    <p ng-if="message">{{ message }}</p>
    <script>
        let app = angular.module('productApp', []);

        app.controller('ProductController', function ($scope, $http, $window) { // $window injektálása
            $scope.product = {
                product_name: "",
                price: "",
                description: "",
                picture: "",
                product_category_name: "",
                quantity_unit_id: ""
            };

            $scope.addProduct = function () {
                $http.post("http://localhost/hambibambi/application/controller/add_product.php",
                    $scope.product)
                    .then(function (response) {
                        alert(response.data.message); // Visszajelzés
                        $scope.product = {}; // Űrlap ürítése
                        $window.location.href = "product_list.php";
                        // Átirányítás
                    })
                    .catch(function (error) {
                        console.error("Hiba történt:", error);
                        alert("Hiba történt a feltöltés során.");
                    });
            };
        });


    </script>
</body>

</html>