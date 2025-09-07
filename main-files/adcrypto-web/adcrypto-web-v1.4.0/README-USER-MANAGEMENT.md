# AdCrypto User Management Tools

This package contains several tools to help you manage users and passwords in your AdCrypto application.

## Available Tools

### 1. Interactive User Management (Recommended)
**File**: `user_management.bat`
**Purpose**: Main menu system for all user management tasks
**Usage**: Double-click to run the interactive menu

### 2. View Users
**File**: `get_users.bat`
**Purpose**: Display all users and admins
**Usage**: Double-click to run

### 3. Reset Password
**File**: `reset_password.bat`
**Purpose**: Reset password for existing users
**Usage**: Command line with parameters

### 4. Create User
**File**: `create_user.bat`
**Purpose**: Create new users with known passwords
**Usage**: Command line with parameters

## How to Use

### Option 1: Interactive Menu (Easiest)
1. Double-click on `user_management.bat`
2. Use the menu to navigate between options
3. Follow the on-screen instructions

### Option 2: Individual Tools
1. **To see all users**: Double-click `get_users.bat`
2. **To reset a password**: 
   - First run `get_users.bat` to find the user ID
   - Then run: `reset_password.bat [admin|user] [id] [new_password]`
3. **To create a new user**: 
   - Run: `create_user.bat [admin|user] [firstname] [lastname] [username] [email] [password]`

## Important Security Notes

### Why Passwords Are Not Shown
- Passwords are stored as hashed values using bcrypt (one-way encryption)
- Hashed passwords cannot be converted back to plain text
- This is a security feature to protect user accounts

### What You Can Do Instead
1. **Reset Passwords**: Set new known passwords using the reset tool
2. **Create New Users**: Add users with passwords you know
3. **Use Application Features**: Use the app's built-in password reset

## Database Connection

All tools use the database configuration from your `.env` file:
- Make sure your MySQL service is running
- Verify database credentials in `.env` are correct

## Troubleshooting

### If tools don't work:
1. Ensure MySQL service is running
2. Check database configuration in `.env`
3. Run command prompt as administrator if needed

### Common Issues:
1. **"Access denied"**: Check database username/password
2. **"Database not found"**: Verify database exists
3. **"Table not found"**: Run database migrations/seeds

## Files Included
- `get_users.php` - PHP script to retrieve users
- `get_users.bat` - Batch file to run get_users.php
- `reset_password.php` - PHP script to reset passwords
- `reset_password.bat` - Batch file to run reset_password.php
- `create_user.php` - PHP script to create new users
- `create_user.bat` - Batch file to run create_user.php
- `user_management.bat` - Interactive menu system (recommended)