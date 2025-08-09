<?php
// Database connection parameters for Docker environment
$servername = getenv('MYSQL_HOST') ?: 'db'; // Use 'db' as hostname in Docker
$username = getenv('MYSQL_USER') ?: 'library_user';
$password = getenv('MYSQL_PASSWORD') ?: 'library_pass';
$dbname = getenv('MYSQL_DATABASE') ?: 'library_db';

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Set charset to UTF-8
mysqli_set_charset($conn, "utf8");
?>
