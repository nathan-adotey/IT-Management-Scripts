# [-] Sample template for joining a Windows 10/11 client to an Active Directory domain
# [-] Simple flow control and error handling metrics are used to prevent accidental system misconfigurations and runtime errors
# [-] Prerequisites:
#     a. Successful network connectivity with the domain controller
#     b. A DNS query must be able to resolve the domain controller's hostname
#     c. The system's/network's firewall must allow kerberos traffic (port 88 by default)
# [-] Changes the system hostname after reboot
# [-] Authored by Nathan Adotey, Linux Systems Administrator II, Jan 2026

# --- Functions ---

# Cache the user's input
function Get-UserInput {
    param ([string]$prompt, [int]$characterThreshold)
    do {
        # Resets the shell
        Clear-Host
        # Prompt the user for input
        [string]$userInput = Read-Host $prompt
    } while ($userInput.Length -lt $characterThreshold) # Restart the prompt if the user failed to enter five or more characters
    # Return the string if the user's input has exceeded a threshold of five
    return $userInput
}

# Cache user input as an encrypted string
function Get-SecureUserInput {
    param ([string]$prompt, [int]$characterThreshold)
    do {
        # Resets the shell
        Clear-Host
        # Prompt the user for input
        [string]$userInput = Read-Host $prompt -AsSecureString
    } while ($userInput.Length -lt $characterThreshold) # Restart the prompt if the user failed to enter five or more characters
    # Return the string if the user's input has exceeded a threshold of five
    return $userInput
}

# Simple yes/no prompt
function Confirm-UserSelection {
    param ([string]$prompt)
    # Prompt the user for input
    [string]$userInput = Read-Host $prompt
    # Return TRUE if the user's input matches any variant of 'Yes'
    if (($userInput -match '^yes$') -or ($userInput -match '^y$') -or ($userInput -eq '1')){ 
        return $true 
    }
    # Return false
    else { 
        return $false 
    }
}

# --- Variable Declarations and/or Definitions

[string]$hostname = hostname
[string]$newHostname = ""
[string]$domain = ""
[string]$username = ""
$password = ""

# --- Start ---

# Prompt the user to enter a new hostname
$newHostname = Get-UserInput("Enter a new system hostname (Current hostname: $hostname)") -characterThreshold 2
$domain = Get-UserInput -prompt "Enter a new joinable domain" -characterThreshold 2
$username = Get-UserInput("Enter a valid domain user") -characterThreshold 2
$password = Get-SecureUserInput -prompt "Enter a password for $username" -characterThreshold 2
$domainCredential = New-Object System.Management.Automation.PSCredential ($username, $password)

# Prompt the user to accept or deny system configuration changes
Clear-Host

Write-Host "New hostname       :   $newHostname"
Write-Host "Domain             :   $domain"
Write-Host "Authenicated User  :   $username`n"

Write-Host "Do you want to continue with these parameters?" -ForegroundColor Yellow
[bool]$bConfirmUserSelection = Confirm-UserSelection -prompt "[Yes/Y/1] Confirm   [Any Key] Exit"

# Attempt domain join & hostname changes
if ($true -eq $bConfirmUserSelection){
    Clear-Host
    Write-Host "Modifying system configuration changes..."
    Start-Sleep -Seconds 1
    # Validate user credentials
    if ($null -eq (Get-Credential -Credential $domainCredential -ErrorAction SilentlyContinue)){
        try {
            $password = Get-SecureUserInput -prompt "Could not authenicate as $username. Enter a password for Administrator" -characterThreshold 2
            $username = "Administrator"
            $domainCredential = New-Object System.Management.Automation.PSCredential ($username, $password)
            Get-Credential -Credential $adminCredential -ErrorAction Suspend
            Clear-Host
        }
        catch {
            Clear-Host
            Write-Host "Could not authenicate a user for $domain...Exiting..." -ForegroundColor Red
            Start-Sleep -Seconds 2
            Exit
        }
    }
    # Perform system changes (domain join, change system hostname)
    Rename-Computer -NewName $newHostname
    Add-Computer -DomainName $domain -Credential $domainCredential

    # Prompt the user to reboot the local machine
    Clear-Host
    Write-Host "Welcome to $domain" -ForegroundColor Green
    Write-Host "Perform system reboot?"
    [bool]$bRestartMachine = Confirm-UserSelection -prompt "[Yes/Y/1] Reboot computer   [Any Key] Exit"
    if ($bRestartMachine){
        Restart-Computer
    }
    else {
        Exit
    }
}
