@echo off
title AdCrypto User Information Retrieval
color 0A

echo ================================================
echo     AdCrypto User Information Retrieval Tool
echo ================================================
echo.
echo Retrieving user credentials from the database...
echo Please wait...
echo.

cd /d "C:\laragon\www\adcrypto\main-files\adcrypto-web\adcrypto-web-v1.4.0"
php get_users.php

echo.
echo ================================================
echo Process completed.
echo.
echo Press any key to close this window...
pause >nul