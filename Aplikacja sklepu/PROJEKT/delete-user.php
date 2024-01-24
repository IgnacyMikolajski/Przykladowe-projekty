<?php

if(isset($_GET["id"]) && is_numeric($_GET["id"])) {
    
   
    require_once "config.php";

    // Przekonwertuj ID na liczbę całkowitą
    $user_id = intval($_GET["id"]);

    // Przygotuj zapytanie DELETE
    $sql = "DELETE FROM users WHERE id = $user_id";

  
    if(mysqli_query($link, $sql)){
       
        mysqli_close($link);

       
        header("location: welcomeA.php");
        exit();
    } else {
        echo "Oops! Something went wrong. Please try again later.";
    }
} else {
    
    header("location: welcomeA.php");
    exit();
}
?>
