<?php
$con = new mysqli("localhost", "root", "", "emergency");
mysqli_query($con, 'SET NAMES "utf8" COLLATE "utf8_general_ci"'); // For Arabic language

if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
    exit();
}

// Get JSON data from the request body
$jsonData = file_get_contents("php://input");
$data = json_decode($jsonData, true);

// Extract data from JSON
$emergencyName = mysqli_real_escape_string($con, $data["EmergencyName"]);
$number = intval($data["Number"]);
$description = mysqli_real_escape_string($con, $data["Description"]);
$imageUrl = mysqli_real_escape_string($con, $data["ImageUrl"]);

// Insert data into the database
$query = "INSERT INTO `1`(`Name`, `Number`, `Description`, `Image`) VALUES ('$emergencyName', $number, '$description', '$imageUrl')";
$result = mysqli_query($con, $query);

// Check the result of the query
if ($result) {
    $response = array("status" => "success", "message" => "Emergency inserted successfully");
} else {
    $response = array("status" => "error", "message" => "Failed to insert emergency");
}

// Send JSON response
header('Content-Type: application/json');
echo json_encode($response);

// Close the database connection
mysqli_close($con);
?>
