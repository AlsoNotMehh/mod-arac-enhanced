@echo off
setlocal
echo ===================================================
echo   ARAC Enhanced Client Patch and DBC Builder
echo ===================================================
node "%~dp0build_dbc.js" %*
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo An error occurred while generating the patch files.
    pause
    exit /b %ERRORLEVEL%
)
echo.
pause
