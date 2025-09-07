@echo off
title AdCrypto User Creation Tool
color 0B

echo ================================================
echo     AdCrypto User Creation Tool
echo ================================================
echo.

cd /d "C:\laragon\www\adcrypto\main-files\adcrypto-web\adcrypto-web-v1.4.0"

if "%1"=="" (
    echo Usage: create_user.bat [admin^|user] [firstname] [lastname] [username] [email] [password]
    echo.
    echo Examples:
    echo   create_user.bat admin John Doe johndoe johndoe@example.com mypassword
    echo   create_user.bat user Jane Smith janesmith janedoe@example.com userpass
    echo.
    echo Press any key to close this window...
    pause >nul
    exit /b
)

echo Creating new user...
echo.
php create_user.php %1 %2 %3 %4 %5 %6

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ================================================
    echo User created successfully!
    echo ================================================
) else (
    echo.
    echo ================================================
    echo User creation failed!
    echo ================================================
)

echo.
echo Press any key to close this window...
pause >nul