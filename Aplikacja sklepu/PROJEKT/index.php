<?php
// Initialize the session
session_start();
if (isset($_POST['Log_in'])) {
    header('Location: login.php');
    exit();
}
if (isset($_POST['Sign_up'])) {
    header('Location: register.php');
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body { 
            font: 14px sans-serif; 
            text-align: center; 
            padding-top: 50px; 
        }
        .center-container {
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>
    <h1>Witamy na naszej stronie!</h1>

    <div class="center-container">
        <form class="form-inline" method="post" action="">
            <button class="btn btn-primary btn-lg mr-3" type="submit" name="Log_in">Log in</button>
            <button class="btn btn-success btn-lg" type="submit" name="Sign_up">Sign up</button>
        </form>
    </div>
</body>
</html>
