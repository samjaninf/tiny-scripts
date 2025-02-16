@echo off
setlocal enabledelayedexpansion

:: Ask for directory path if not provided as an argument
if "%~1"=="" (
    set /p "directory=Enter the directory path: "
) else (
    set "directory=%~1"
)

set "directory=%directory:\=/%"  

set "script_path=C:\path\to\your\script\rename_script.py"  :: Replace with the actual script path

if not exist "%script_path%" (
    echo Error: The file %script_path% does not exist. Check the path.
    pause
    exit /b
)

python "%script_path%" "%directory%"
pause