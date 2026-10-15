<?php
include "db.php";

$userId = intval($_POST["userId"]);
$startDate = $conn->real_escape_string($_POST["startDate"]);

$sql = "INSERT INTO SessionUser (UserID, StartSession)
VALUES ($userId, '$startDate')";

if ($conn->query($sql) === TRUE) {
    $last_id = $conn->insert_id;
    echo $last_id;
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
