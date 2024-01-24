<?php
require_once "config.php";

if (isset($_POST['OK'])) {
    header('Location: login.php');
    exit();
}

echo "Produkt dodano do koszyka";
?>

<form method="post" action="">
    <button type="submit" name="OK">OK</button>
</form>
