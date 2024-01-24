<?php
// Initialize the session
session_start();

// Check if the user is not logged in or not an admin, redirect to login page
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true || $_SESSION["type"] !== 1){
    header("location: login.php");
    exit;
}


require_once "config.php";


$sql = "SELECT id, username FROM users";
$result = mysqli_query($link, $sql);


if (!$result) {
    die("Query failed: " . mysqli_error($link));
}


function displayUsers($result) {
    echo "<ul>";
    while ($row = mysqli_fetch_assoc($result)) {
        echo "<li>{$row['username']} <a href='delete-user.php?id={$row['id']}'>Delete</a></li>";
    }
    echo "</ul>";
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body{ font: 14px sans-serif; }
        .wrapper{ width: 360px; padding: 20px; }
    </style>
</head>
<body>
    <div class="wrapper">
        <h2>Admin Panel</h2>
        <p>Welcome, Admin. Here you can manage users:</p>

        <?php 
        
        displayUsers($result);
        ?>

        <p><a href="logout.php">Logout</a></p>
    </div>
</body>
</html>

<?php

mysqli_free_result($result);


mysqli_close($link);
?>
