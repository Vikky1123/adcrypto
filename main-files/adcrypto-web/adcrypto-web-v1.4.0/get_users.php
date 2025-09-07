<?php
// Database connection script to retrieve user and admin credentials
// Save this as get_users.php in the project root directory

require_once 'vendor/autoload.php';

// Load .env file
$env = parse_ini_file('.env');

try {
    // Create PDO connection
    $host = $env['DB_HOST'] ?? 'localhost';
    $port = $env['DB_PORT'] ?? '3306';
    $dbname = $env['DB_DATABASE'] ?? 'adcrypto';
    $username = $env['DB_USERNAME'] ?? 'root';
    $password = $env['DB_PASSWORD'] ?? '';
    
    $dsn = "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4";
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "=== Admin Users ===\n";
    $stmt = $pdo->query("SELECT id, firstname, lastname, username, email FROM admins ORDER BY id");
    $admins = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($admins as $admin) {
        echo "ID: " . $admin['id'] . "\n";
        echo "Name: " . $admin['firstname'] . " " . $admin['lastname'] . "\n";
        echo "Username: " . $admin['username'] . "\n";
        echo "Email: " . $admin['email'] . "\n";
        echo "------------------------\n";
    }
    
    echo "\n=== Regular Users ===\n";
    $stmt = $pdo->query("SELECT id, firstname, lastname, username, email FROM users ORDER BY id LIMIT 10");
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($users as $user) {
        echo "ID: " . $user['id'] . "\n";
        echo "Name: " . $user['firstname'] . " " . $user['lastname'] . "\n";
        echo "Username: " . $user['username'] . "\n";
        echo "Email: " . $user['email'] . "\n";
        echo "------------------------\n";
    }
    
    echo "\nNote: Passwords are hashed and cannot be displayed for security reasons.\n";
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
    echo "Please check your database configuration in the .env file.\n";
}
?>