# PowerShell script to get SHA-1 fingerprint for Google Sign-In

Write-Host "Getting SHA-1 fingerprint for Google Sign-In..." -ForegroundColor Green
Write-Host ""

# Method 1: Using Gradle (Recommended)
Write-Host "Method 1: Using Gradle signingReport..." -ForegroundColor Yellow
cd android
.\gradlew signingReport
cd ..

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Method 2: Using keytool directly
Write-Host "Method 2: Using keytool directly..." -ForegroundColor Yellow

$debugKeystore = "$env:USERPROFILE\.android\debug.keystore"

if (Test-Path $debugKeystore) {
    Write-Host "Found debug keystore at: $debugKeystore" -ForegroundColor Green
    keytool -list -v -keystore $debugKeystore -alias androiddebugkey -storepass android -keypass android
} else {
    Write-Host "Debug keystore not found at: $debugKeystore" -ForegroundColor Red
    Write-Host "Please run the app at least once to generate the debug keystore." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Copy the SHA-1 fingerprint (the line starting with 'SHA1:')" -ForegroundColor Green
Write-Host "and add it to Firebase Console -> Project Settings -> Your apps -> Android app" -ForegroundColor Green
Write-Host ""
Write-Host "After adding SHA-1, download the new google-services.json and replace the existing one." -ForegroundColor Yellow
