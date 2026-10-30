<?php
$servername = "localhost";
$username = "marcam5";
$password = "bHpeqRC6m94wdKY";
$dbname = "marcam5";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
