@echo off
title AdCrypto User Management System
color 0F

:menu
cls
echo ================================================
echo     AdCrypto User Management System
echo ================================================
echo.
echo Select an option:
echo.
echo 1. View all users and admins
echo 2. Reset a user's password
echo 3. Create a new user
echo 4. Exit
echo.
echo Note: Make sure your MySQL service is running
echo before using these tools.
echo.
echo ================================================
set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto view_users
if "%choice%"=="2" goto reset_password
if "%choice%"=="3" goto create_user
if "%choice%"=="4" goto exit_program

echo.
echo Invalid choice. Please try again.
timeout /t 2 >nul
goto menu

:view_users
cls
echo ================================================
echo     Viewing All Users
echo ================================================
echo.
echo Retrieving user information...
echo.
cd /d "C:\laragon\www\adcrypto\main-files\adcrypto-web\adcrypto-web-v1.4.0"
php get_users.php
echo.
echo Press any key to return to the main menu...
pause >nul
goto menu

:reset_password
cls
echo ================================================
echo     Reset User Password
echo ================================================
echo.
echo To reset a password, you need:
echo 1. User type (admin or user)
echo 2. User ID (get this from option 1)
echo 3. New password
echo.
echo Example: To reset admin with ID 1 to password "newpass123"
echo You would enter: admin 1 newpass123
echo.
set /p user_type="Enter user type (admin/user): "
if "%user_type%"=="" goto reset_password_back

set /p user_id="Enter user ID: "
if "%user_id%"=="" goto reset_password_back

set /p new_pass="Enter new password: "
if "%new_pass%"=="" goto reset_password_back

echo.
echo Resetting password...
echo.
cd /d "C:\laragon\www\adcrypto\main-files\adcrypto-web\adcrypto-web-v1.4.0"
php reset_password.php %user_type% %user_id% %new_pass%

:reset_password_back
echo.
echo Press any key to return to the main menu...
pause >nul
goto menu

:create_user
cls
echo ================================================
echo     Create New User
echo ================================================
echo.
echo To create a new user, you need:
echo 1. User type (admin/user)
echo 2. First name
echo 3. Last name
echo 4. Username
echo 5. Email
echo 6. Password
echo.
echo Example: To create a user named "John Doe" with username "johndoe"
echo You would enter: user John Doe johndoe johndoe@example.com mypassword
echo.
set /p user_type="Enter user type (admin/user): "
if "%user_type%"=="" goto create_user_back

set /p first_name="Enter first name: "
if "%first_name%"=="" goto create_user_back

set /p last_name="Enter last name: "
if "%last_name%"=="" goto create_user_back

set /p username="Enter username: "
if "%username%"=="" goto create_user_back

set /p email="Enter email: "
if "%email%"=="" goto create_user_back

set /p password="Enter password: "
if "%password%"=="" goto create_user_back

echo.
echo Creating new user...
echo.
cd /d "C:\laragon\www\adcrypto\main-files\adcrypto-web\adcrypto-web-v1.4.0"
php create_user.php %user_type% %first_name% %last_name% %username% %email% %password%

:create_user_back
echo.
echo Press any key to return to the main menu...
pause >nul
goto menu

:exit_program
cls
echo ================================================
echo     Thank you for using AdCrypto User Management
echo ================================================
echo.
echo Goodbye!
timeout /t 2 >nul
exit