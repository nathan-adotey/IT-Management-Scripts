# [-] Converts a C# program (.cs) to PowerShell
# [-] Authored by Nathan Adotey, Linux Systems Administrator II, 2026

# Prompt the user to enter a .cs file they would like to convert into a PowerShell script
do{
    Clear-Host
    [string]$inputPath = Read-Host "Enter the path of the .cs file you would like to convert to a PowerShell script"
} while ([string]::IsNullOrEmpty($inputPath))

# Prompt the user to enter a valid destination path
do{
    Clear-Host
    [string]$outputPath = Read-Host "Enter a valid destination path"
} while ([string]::IsNullOrEmpty($outputPath))

Clear-Host

# Perform the script conversion
try{
    Convert-Form -Path $inputPath -Destination $outputPath -Encoding ascii -force
} catch {
    Write-Host "Could not perform C# conversion..." -ForegroundColor Red
    Start-Sleep -Seconds 2
    Exit
}

# Pauses shell execution before termination
$null = Read-Host "`nConversion complete! Press [Enter] to close the session"
