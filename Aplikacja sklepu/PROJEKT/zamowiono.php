<?php
session_start();
require_once "config.php";
echo"<h1>Gratulujemy złożenia zamówienia!</h1>";

$user_id = $_SESSION["id"];

$sql = "DELETE FROM koszyk WHERE user_id = $user_id";
$result = $link->query($sql);

if (isset($_POST['OK'])) {
    header('Location: login.php');
    exit();
}

?>

<form method="post" action="">
    <button style='font-size: 26px;' type="submit" name="OK">OK</button>
</form>
