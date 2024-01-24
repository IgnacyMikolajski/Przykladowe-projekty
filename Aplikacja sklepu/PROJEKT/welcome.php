<?php
// Initialize the session
session_start();
 
// Check if the user is logged in, if not then redirect him to login page
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}
?>
 
<?php
require_once "config.php";

//Pobierz produkty z bazy danych
$sql = "SELECT id, nazwa, cena, obraz_link, opis FROM Produkty";
$result = $link->query($sql);

$link->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sklep</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Dodaj styl CSS tutaj */
    </style>
</head>
<body>

<h1>Produkty dostępne do dodania do koszyka</h1>
<div>
    <a href="koszyk.php" style="text-decoration: none; margin-right: 10px;">
        <button type="button" style="font-size: 20px;">
            <i class="fas fa-shopping-cart" style="font-size: 20px;"></i> Przejdź do koszyka
        </button>
    </a>

    <a href="logout.php" style="text-decoration: none; margin-left: 10px;">
        <button type="button" style="font-size: 20px;">
            <i style="font-size: 20px;"></i> Wyloguj się
        </button>
    </a>
</div>


<?php

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        echo "<div>";
        echo "<h3 style='font-size: 24px;'>" . $row["nazwa"] . "</h3>";
        echo "<p style='font-size: 24px;'>Cena: " . $row["cena"] . " zł</p>";
		$obraz = $row["obraz_link"];
		echo $obraz;
        echo "<p style='font-size: 20px;'>" . $row["opis"] . "</p>";
		echo "<form method='post' action='dodaj_do_koszyka.php'>";
		echo "<input type='hidden' name='produkt_id' value='" . $row["id"] . "'>";
        echo "<button type='submit' style='font-size: 24px;' name='dodaj_do_koszyka'>Dodaj do koszyka</button>";
        echo "</form>";
		echo "<hr>";
        echo "</div>";
    }
} else {
    echo "Brak dostępnych produktów.";
}
?>

</body>
</html>
