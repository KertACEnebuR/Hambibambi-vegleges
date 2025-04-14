<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require_once "../../connect.php"; // Az adatbázis kapcsolódási fájl

$input = json_decode(file_get_contents("php://input"), true);

if (!empty($input['product_name']) && !empty($input['price']) && !empty($input['description']) && !empty($input['picture']) && !empty($input['product_category_id']) && !empty($input['quantity_unit_id'])) {



    $stmt = $conn->prepare("INSERT INTO products (product_name, price, description, picture, product_category_id, quantity_unit_id) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sissii", $input['product_name'], $input['price'], $input['description'], $input['picture'], $input['product_category_id'], $input['quantity_unit_id']);

    if ($stmt->execute()) {
        echo json_encode(["message" => "Sikeres mentés!"]);
    } else {
        echo json_encode(["message" => "Hiba történt a mentés során."]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["message" => "Hiányzó adatok!"]);
}
