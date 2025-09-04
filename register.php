<?php
include 'db_connect.php';

$error = "";
$success = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // SQL Injection vulnerability - using direct input in SQL query
    $username = $_POST['username'];
    $password = $_POST['password'];
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    
    // Check if username exists
    $check_sql = "SELECT * FROM users WHERE username='$username'";
    $result = mysqli_query($conn, $check_sql);
    
    if (mysqli_num_rows($result) > 0) {
        $error = "Username already exists";
    } else {
        // Insert new user
        $sql = "INSERT INTO users (username, password, first_name, last_name) 
                VALUES ('$username', '$password', '$first_name', '$last_name')";
        
        if (mysqli_query($conn, $sql)) {
            $success = "Registration successful! <a href='login.php'>Login now</a>";
        } else {
            $error = "Error: " . mysqli_error($conn);
        }
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
        .container { max-width: 400px; margin: 0 auto; padding: 20px; border: 1px solid #ccc; }
        .error { color: red; margin-bottom: 10px; }
        .success { color: green; margin-bottom: 10px; }
        input { width: 100%; padding: 8px; margin: 5px 0 15px; box-sizing: border-box; }
        button { background-color: #4CAF50; color: white; padding: 10px 15px; border: none; cursor: pointer; }
        button:hover { opacity: 0.8; }
        .login-link { margin-top: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register</h2>
        <?php if(!empty($error)): ?>
            <div class="error"><?php echo $error; ?></div>
        <?php endif; ?>
        
        <?php if(!empty($success)): ?>
            <div class="success"><?php echo $success; ?></div>
        <?php else: ?>
            <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
                
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                
                <label for="first_name">First Name:</label>
                <input type="text" id="first_name" name="first_name" required>
                
                <label for="last_name">Last Name:</label>
                <input type="text" id="last_name" name="last_name" required>
                
                <button type="submit">Register</button>
            </form>
        <?php endif; ?>
        
        <div class="login-link">
            <a href="login.php">Back to login</a>
        </div>
    </div>
</body>
</html>
