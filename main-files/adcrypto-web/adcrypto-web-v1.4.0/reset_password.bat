@echo off
title AdCrypto Password Reset Tool
color 0E

echo ================================================
echo     AdCrypto Password Reset Tool
echo ================================================
echo.

cd /d "C:\laragon\www\adcrypto\main-files\adcrypto-web\adcrypto-web-v1.4.0"

if "%1"=="" (
    echo Usage: reset_password.bat [admin^|user] [id] [new_password]
    echo.
    echo Examples:
    echo   reset_password.bat admin 1 newpassword123
    echo   reset_password.bat user 1 mynewpass
    echo.
    echo First, run get_users.bat to see the list of users and their IDs
    echo.
    echo Press any key to close this window...
    pause >nul
    exit /b
)

echo Resetting password...
echo.
php reset_password.php %1 %2 %3

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ================================================
    echo Password reset successful!
    echo ================================================
) else (
    echo.
    echo ================================================
    echo Password reset failed!
    echo ================================================
)

echo.
echo Press any key to close this window...
pause >nul