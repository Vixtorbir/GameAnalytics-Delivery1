<?php
include "db.php";

$sessionId = intval($_POST["sessionId"]);
$endDate = $conn->real_escape_string($_POST["endDate"]);

$sql = "UPDATE SessionUser SET EndSession = '$endDate' WHERE SessionID = $sessionId";

if ($conn->query($sql) === TRUE) {
    echo $sessionId;
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
