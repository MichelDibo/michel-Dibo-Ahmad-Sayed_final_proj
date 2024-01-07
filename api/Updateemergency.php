<?php
$con = new mysqli("localhost", "root", "", "emergency");
mysqli_query($con, 'SET NAMES "utf8" COLLATE "utf8_general_ci"'); // For Arabic language

if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
    exit();
}

$jsonData = file_get_contents("php://input");
$data = json_decode($jsonData, true);

$originalNumber = isset($data["originalNumber"]) ? intval($data["originalNumber"]) : 0;
$number = isset($data["number"]) ? intval($data["number"]) : 0;
$name = isset($data["name"]) ? mysqli_real_escape_string($con, $data["name"]) : '';
$description = isset($data["description"]) ? mysqli_real_escape_string($con, $data["description"]) : '';
$image = isset($data["image"]) ? mysqli_real_escape_string($con, $data["image"]) : '';

if ($originalNumber && $number && $name !== '' && $description !== '' && $image !== '') {
    $updateQuery = "UPDATE `1` SET `number`='$number', `name`='$name', `description`='$description', `image`='$image' WHERE `number`='$originalNumber'";

    if ($con->query($updateQuery) === TRUE) {
        http_response_code(200);
        echo json_encode(['message' => 'Emergency data updated successfully']);
    } else {
        http_response_code(500);
        echo json_encode(['message' => 'Error updating emergency data: ' . $con->error]);
    }
} else {
    http_response_code(400);
    echo json_encode(['message' => 'Invalid input data']);
}

$con->close();
?>
