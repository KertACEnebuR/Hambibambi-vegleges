<?php
// Ellenőrizzük, hogy a felhasználó be van-e jelentkezve
$isLoggedIn = isset($_SESSION['user_id']);
?>
<!DOCTYPE html>
<html lang="hu" ng-app="HambiBambiApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../../assets/css/product.css">
    <link rel="stylesheet" href="../../../assets/css/main.css">
    <link rel="stylesheet" href="../../../assets/css/cart.css">
    <title>Termékek</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
</head>
<body ng-controller="ProductController" data-is-logged-in="<?= $isLoggedIn ? 'true' : 'false' ?>">
    <main>
        <div class="product-container">
        <button onclick="toTheTop()" id="top" title="Visszagörgetés">↑</button>
        <div class="hamburgers con">
            <legend>Hamburgerek</legend>
            <div class="container" id="hamburgers">
                <div class="product" style="width: 18rem;" ng-repeat="product in products | filter:{product_category_id: 3}" data-id="{{product.product_id}}">
                    <img ng-src="http://localhost/hambibambi/assets/img/{{product.picture}}" alt="{{product.product_name}}">
                    <div class="card-body product-body">
                        <h5 class="card-title">{{ product.product_name }}</h5>
                        <p class="card-text">{{ product.description }}</p>
                        <p class="ar">{{ product.price }} Ft</p>
                        <input type='number' id='quantity' name='quantity' min='1' max="9" value='1'>
                        <button type='button' class="kosarhoz">Kosárba</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="soups con">
        <legend>Levesek</legend>
            <div id="soups" class="container">
                <div class="product" style="width: 18rem;" ng-repeat="product in products | filter:{product_category_id: 2}" data-id="{{product.product_id}}">
                    <img ng-src="http://localhost/hambibambi/assets/img/{{product.picture}}" alt="{{product.product_name}}">
                    <div class="card-body product-body">
                        <h5 class="card-title">{{ product.product_name }}</h5>
                        <p class="card-text">{{ product.description }}</p>
                        <p class="ar">{{ product.price }} Ft</p>
                        <input type='number' id='quantity' name='quantity' min='1' max="9" value='1'>
                        <button type='button' class="kosarhoz">Kosárba</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="salads con">
            <legend>Saláták</legend>
            <div id="salads" class="container">
                <div class="product " style="width: 18rem;" ng-repeat="product in products | filter:{product_category_id: 1}" data-id="{{product.product_id}}">
                    <img ng-src="http://localhost/hambibambi/assets/img/{{product.picture}}" alt="{{product.product_name}}">
                    <div class="card-body product-body">
                        <h5 class="card-title">{{ product.product_name }}</h5>
                        <p class="card-text">{{ product.description }}</p>
                        <p class="ar">{{ product.price }} Ft</p>
                        <input type='number' id='quantity' name='quantity' min='1' max="9" value='1'>
                        <button type='button' class="kosarhoz">Kosárba</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="pastas con">
            <legend>Tészták</legend>
            <div id="pastas" class="container">
                <div class="product" style="width: 18rem;" ng-repeat="product in products | filter:{product_category_id: 4}" data-id="{{product.product_id}}">
                    <img ng-src="http://localhost/hambibambi/assets/img/{{product.picture}}" alt="{{product.product_name}}">
                    <div class="card-body product-body">
                        <h5 class="card-title">{{ product.product_name }}</h5>
                        <p class="card-text">{{ product.description }}</p>
                        <p class="ar">{{ product.price }} Ft</p>
                        <input type='number' id='quantity' name='quantity' min='1' max="9" value='1'>
                        <button type='button' class="kosarhoz">Kosárba</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="desserts con">
            <legend>Sütemények</legend>
            <div id="desserts" class="container">
                <div class="product " style="width: 18rem;" ng-repeat="product in products | filter:{product_category_id: 7}" data-id="{{product.product_id}}">
                    <img ng-src="http://localhost/hambibambi/assets/img/{{product.picture}}" alt="{{product.product_name}}">
                    <div class="card-body product-body">
                        <h5 class="card-title">{{ product.product_name }}</h5>
                        <p class="card-text">{{ product.description }}</p>
                        <p class="ar">{{ product.price }} Ft</p>
                        <input type='number' id='quantity' name='quantity' min='1' max="9" value='1'>
                        <button type='button' class="kosarhoz">Kosárba</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="drinks con">
            <legend>Üdítők</legend>
            <div id="drinks" class="container">
                <div class="product " style="width: 18rem;" ng-repeat="product in products | filter:{product_category_id: 6}" data-id="{{product.product_id}}">
                    <img ng-src="http://localhost/hambibambi/assets/img/{{product.picture}}" alt="{{product.product_name}}">
                    <div class="card-body product-body">
                        <h5 class="card-title">{{ product.product_name }}</h5>
                        <p class="card-text">{{ product.description }}</p>
                        <p class="ar">{{ product.price }} Ft</p>
                        <input type='number' id='quantity' name='quantity' min='1' max="9" value='1'>
                        <button type='button' class="kosarhoz">Kosárba</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="drinks2 con">
            <legend>Aloholos italok</legend>
            <div id="drinks2" class="container">
                <div class="product " style="width: 18rem;" ng-repeat="product in products | filter:{product_category_id: 5}" data-id="{{product.product_id}}">
                    <img ng-src="http://localhost/hambibambi/assets/img/{{product.picture}}" alt="{{product.product_name}}">
                    <div class="card-body product-body">
                        <h5 class="card-title">{{ product.product_name }}</h5>
                        <p class="card-text">{{ product.description }}</p>
                        <p class="ar">{{ product.price }} Ft</p>
                        <input type='number' id='quantity' name='quantity' min='1' max="9" value='1'>
                        <button type='button' class="kosarhoz">Kosárba</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </main>

    <script>
        let app = angular.module('HambiBambiApp', []);
        app.controller('ProductController', function($scope, $http) {
            $http.get('http://localhost/hambibambi/application/controller/api.php')
            .then(function(response) {
                $scope.products = response.data;
            })
            .catch(function(error) {
                console.error("Hiba történt az API hívás során:", error);
            });
        });
    </script>
</body>
</html>
