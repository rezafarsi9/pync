@echo off
setlocal

:: Set your GitHub repo URL here
set REPO_URL=https://github.com/rezafarsi9/pync.git

:: Check if Git is installed
where git >nul 2>nul
if errorlevel 1 (
    echo Git is not installed or not in PATH.
    pause
    exit /b
)

:: Initialize git if not already
if not exist ".git" (
    echo Initializing Git repository...
    git init
)

:: Rename branch to main
git branch -M main

:: Add remote origin (ignore error if it already exists)
git remote add origin %REPO_URL% 2>nul
git remote set-url origin %REPO_URL%

:: Stage all changes
git add .

:: Commit (only if there are changes)
git diff --cached --quiet
if %errorlevel%==1 (
    git commit -m "Auto commit from deploy script"
) else (
    echo No changes to commit.
)

:: Push to main branch
git push -u origin main

echo.
echo Done!
pause
