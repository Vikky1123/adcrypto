<?php
// Password reset script for AdCrypto users
// Save this as reset_password.php in the project root directory

require_once 'vendor/autoload.php';

use Illuminate\Support\Facades\Hash;

// Load .env file
$env = parse_ini_file('.env');

function showUsage() {
    echo "Usage: php reset_password.php [admin|user] [id] [new_password]\n";
    echo "Example: php reset_password.php admin 1 newpassword123\n";
    echo "Example: php reset_password.php user 1 mynewpass\n";
}

if ($argc < 4) {
    showUsage();
    exit(1);
}

$userType = $argv[1]; // admin or user
$userId = $argv[2]; // user ID
$newPassword = $argv[3]; // new password

if (!in_array($userType, ['admin', 'user'])) {
    echo "Error: User type must be 'admin' or 'user'\n";
    showUsage();
    exit(1);
}

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
    
    // Check if user exists
    $table = $userType === 'admin' ? 'admins' : 'users';
    $stmt = $pdo->prepare("SELECT id, firstname, lastname, username, email FROM $table WHERE id = ?");
    $stmt->execute([$userId]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$user) {
        echo "Error: No $userType found with ID $userId\n";
        exit(1);
    }
    
    // Hash the new password
    // Note: We're using a simple approach here. In a real Laravel environment,
    // you would use Hash::make() which is not available in this standalone script
    $hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT);
    
    // Update the password
    $stmt = $pdo->prepare("UPDATE $table SET password = ? WHERE id = ?");
    $stmt->execute([$hashedPassword, $userId]);
    
    echo "Password successfully reset for $userType:\n";
    echo "ID: " . $user['id'] . "\n";
    echo "Name: " . $user['firstname'] . " " . $user['lastname'] . "\n";
    echo "Username: " . $user['username'] . "\n";
    echo "Email: " . $user['email'] . "\n";
    echo "New Password: $newPassword\n";
    echo "Note: Password has been hashed and stored in the database.\n";
    
} catch (PDOException $e) {
    echo "Database error: " . $e->getMessage() . "\n";
    echo "Please check your database configuration in the .env file.\n";
    exit(1);
}
?>