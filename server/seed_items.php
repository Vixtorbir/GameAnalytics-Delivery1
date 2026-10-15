<?php
include "db.php";

$items = array(
    1 => 0.99,
    2 => 1.99,
    3 => 9.99,
    4 => 49.99,
    5 => 99.99
);

foreach ($items as $id => $price) {
    $sql = "INSERT INTO Item (ItemID, ItemPrice) VALUES ($id, $price)";

    if ($conn->query($sql) === TRUE) {
        echo "Item " . $id . " inserted (" . $price . ")<br>";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error . "<br>";
    }
}

$conn->close();
?>
