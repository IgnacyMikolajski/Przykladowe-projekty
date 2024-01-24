<?php
session_start();
require_once "config.php";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['dodaj_do_koszyka'])) {
    $produkt_id = $_POST['produkt_id'];
    $user_id = $_SESSION["id"];  

    $sql = "INSERT INTO koszyk (user_id, produkt_id) VALUES ($user_id, $produkt_id)";

    if ($link->query($sql) === TRUE) {
		header("location: dodano_do_koszyka.php");
    } else {
        echo "Błąd podczas dodawania produktu do koszyka: " . $link->error;
    }
}

$link->close();
?>
