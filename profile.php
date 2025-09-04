<?php
session_start();
include 'db_connect.php';

// Check if user is logged in
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header("Location: login.php");
    exit;
}

// SQL Injection vulnerability - using direct input in SQL query
$username = $_SESSION['username'];
$sql = "SELECT * FROM users WHERE username='$username'";
$result = mysqli_query($conn, $sql);
$user = mysqli_fetch_assoc($result);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ccc; }
        .profile-info { margin-bottom: 20px; }
        .profile-info p { margin: 5px 0; }
        .profile-info label { font-weight: bold; display: inline-block; width: 100px; }
        .logout-btn { background-color: #f44336; color: white; padding: 10px 15px; border: none; cursor: pointer; }
        .logout-btn:hover { opacity: 0.8; }
    </style>
</head>
<body>
    <div class="container">
        <h2>User Profile</h2>
        <div class="profile-info">
            <p><label>Username:</label> <?php echo $user['username']; ?></p>
            <p><label>First Name:</label> <?php echo $user['first_name']; ?></p>
            <p><label>Last Name:</label> <?php echo $user['last_name']; ?></p>
        </div>
        <a href="logout.php"><button class="logout-btn">Logout</button></a>
    </div>
</body>
</html>
