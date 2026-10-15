<?php
include "db.php";

$sessionId = intval($_POST["sessionId"]);
$itemId = intval($_POST["itemId"]);

$sql = "INSERT INTO Purchases (SessionID, ItemID)
VALUES ($sessionId, $itemId)";

if ($conn->query($sql) === TRUE) {
    $last_id = $conn->insert_id;
    echo $last_id;
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
