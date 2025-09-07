<?php
// User creation script for AdCrypto
// Save this as create_user.php in the project root directory

require_once 'vendor/autoload.php';

// Load .env file
$env = parse_ini_file('.env');

function showUsage() {
    echo "Usage: php create_user.php [admin|user] [firstname] [lastname] [username] [email] [password]\n";
    echo "Example: php create_user.php admin John Doe johndoe johndoe@example.com mypassword\n";
    echo "Example: php create_user.php user Jane Smith janesmith janedoe@example.com userpass\n";
}

if ($argc < 7) {
    showUsage();
    exit(1);
}

$userType = $argv[1]; // admin or user
$firstname = $argv[2];
$lastname = $argv[3];
$username = $argv[4];
$email = $argv[5];
$password = $argv[6];

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
    $dbUsername = $env['DB_USERNAME'] ?? 'root';
    $dbPassword = $env['DB_PASSWORD'] ?? '';
    
    $dsn = "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4";
    $pdo = new PDO($dsn, $dbUsername, $dbPassword);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Check if username or email already exists
    $table = $userType === 'admin' ? 'admins' : 'users';
    $stmt = $pdo->prepare("SELECT id FROM $table WHERE username = ? OR email = ?");
    $stmt->execute([$username, $email]);
    $existingUser = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($existingUser) {
        echo "Error: Username or email already exists\n";
        exit(1);
    }
    
    // Hash the password
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);
    
    // Insert new user
    if ($userType === 'admin') {
        $stmt = $pdo->prepare("INSERT INTO admins (firstname, lastname, username, email, password, created_at, status) VALUES (?, ?, ?, ?, ?, NOW(), 1)");
        $stmt->execute([$firstname, $lastname, $username, $email, $hashedPassword]);
    } else {
        $stmt = $pdo->prepare("INSERT INTO users (firstname, lastname, username, email, password, created_at, status, email_verified, sms_verified, kyc_verified) VALUES (?, ?, ?, ?, ?, NOW(), 1, 1, 1, 1)");
        $stmt->execute([$firstname, $lastname, $username, $email, $hashedPassword]);
    }
    
    $newUserId = $pdo->lastInsertId();
    
    echo "New $userType created successfully:\n";
    echo "ID: $newUserId\n";
    echo "Name: $firstname $lastname\n";
    echo "Username: $username\n";
    echo "Email: $email\n";
    echo "Password: $password (stored as hashed value)\n";
    
} catch (PDOException $e) {
    echo "Database error: " . $e->getMessage() . "\n";
    echo "Please check your database configuration in the .env file.\n";
    exit(1);
}
?>