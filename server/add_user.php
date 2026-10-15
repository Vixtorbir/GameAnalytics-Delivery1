<?php
include "db.php";

$name = $conn->real_escape_string($_POST["name"]);
$country = $conn->real_escape_string($_POST["country"]);
$age = intval($_POST["age"]);
$gender = floatval($_POST["gender"]);

$sql = "INSERT INTO User (UserName, UserCountry, UserAge, UserGender)
VALUES ('$name', '$country', $age, $gender)";

if ($conn->query($sql) === TRUE) {
    $last_id = $conn->insert_id;
    echo $last_id;
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
