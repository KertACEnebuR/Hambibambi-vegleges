<?php

header("Content-Type: application/json");

require "../../connect.php";

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

if ($_SERVER["REQUEST_METHOD"] === "OPTIONS") {
    http_response_code(200);
    exit();
}

$request_method = $_SERVER["REQUEST_METHOD"];

switch ($request_method) {
    case 'GET':
        if (isset($_GET['id'])) {
            getProduct($_GET['id']);
        } else {
            getProducts();
        }
        break;
    case 'POST':
        addProduct();
        break;
    case 'PUT':
        $data = json_decode(file_get_contents("php://input"), true);
        if (isset($data['product_id'])) {
            updateProduct($data['product_id'], $data);
        } else {
            echo json_encode(["error" => "Product ID is required"]);
        }
        break;
    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"), true);
        if (isset($data['id'])) {
            deleteProduct($data['id']);
        } else {
            echo json_encode(["error" => "Product ID is required"]);
        }
        break;
    default:
        echo json_encode(["error" => "Invalid request method"]);
        break;
}

function getProducts() {
    global $conn;
    $sql = "SELECT * FROM products";
    $result = $conn->query($sql);
    $products = [];
    while ($row = $result->fetch_assoc()) {
        $products[] = $row;
    }
    echo json_encode($products);
}

function getProduct($id) {
    global $conn;
    $sql = "SELECT * FROM products WHERE product_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    echo json_encode($result->fetch_assoc());
}

function addProduct() {
    global $conn;
    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data['product_category_id'], $data['quantity_unit_id'], $data['product_name'], $data['price'], $data['description'], $data['picture'])) {
        echo json_encode(["error" => "Missing required fields"]);
        return;
    }

    $sql = "INSERT INTO products (product_category_id, quantity_unit_id, product_name, price, description, picture) VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iisiss", $data['product_category_id'], $data['quantity_unit_id'], $data['product_name'], $data['price'], $data['description'], $data['picture']);
    
    if ($stmt->execute()) {
        echo json_encode(["message" => "Product added successfully", "id" => $conn->insert_id]);
    } else {
        echo json_encode(["error" => "Failed to add product"]);
    }
}

function updateProduct($id, $data) {
    global $conn;

    if (!isset($data['product_category_id'], $data['quantity_unit_id'], $data['product_name'], $data['price'], $data['description'], $data['picture'])) {
        echo json_encode(["error" => "Missing required fields"]);
        return;
    }

    $sql = "UPDATE products SET product_category_id = ?, quantity_unit_id = ?, product_name = ?, price = ?, description = ?, picture = ? WHERE product_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iisissi", $data['product_category_id'], $data['quantity_unit_id'], $data['product_name'], $data['price'], $data['description'], $data['picture'], $id);
    
    if ($stmt->execute()) {
        echo json_encode(["message" => "Product updated successfully"]);
    } else {
        echo json_encode(["error" => "Failed to update product"]);
    }
}

function deleteProduct($id) {
    global $conn;
    $sql = "DELETE FROM products WHERE product_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $id);
    
    if ($stmt->execute()) {
        echo json_encode(["message" => "Product deleted successfully"]);
    } else {
        echo json_encode(["error" => "Failed to delete product"]);
    }
}

$conn->close();
