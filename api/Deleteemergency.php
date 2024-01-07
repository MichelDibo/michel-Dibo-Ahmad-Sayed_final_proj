<?php
$con = new mysqli("localhost", "root", "", "emergency");
mysqli_query($con, 'SET NAMES "utf8" COLLATE "utf8_general_ci"'); // For Arabic language

if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
    exit();
}

$jsonData = file_get_contents("php://input");
$data = json_decode($jsonData, true);

$number = isset($data["number"]) ? intval($data["number"]) : 0;

if ($number) {
    $deleteQuery = "DELETE FROM `1` WHERE `number`='$number'";

    if ($con->query($deleteQuery) === TRUE) {
        http_response_code(200);
        echo json_encode(['message' => 'Emergency data deleted successfully']);
    } else {
        http_response_code(500);
        echo json_encode(['message' => 'Error deleting emergency data: ' . $con->error]);
    }
} else {
    http_response_code(400);
    echo json_encode(['message' => 'Invalid input data']);
}

$con->close();
?>
