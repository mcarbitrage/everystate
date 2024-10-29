# Save username and password using secure string
# Usage: .\storeCliXml.ps1 -username "username" -password "password"
# Note: This script will save the username and password in a file named "cred.xml" in the same directory
#       The password will be encrypted using the Windows Data Protection API
#       The password can only be decrypted by the same user on the same machine
#       The password will be stored in plain text in the file "cred.xml"
#       The password will be stored in secure string in the file "cred.xml" if the -secure flag is used
#       The password will be stored in plain text in the file "cred.xml" if the -plain flag is used
#       The password will be stored in secure string in the file "cred.xml" if the -secure flag is used

param(
    [string]$username,
    [string]$password,
    [switch]$secure,
    [switch]$plain
)

if ($secure -and $plain) {
    Write-Host "Please use only one of the -secure or -plain flags"
    exit
}

if ($secure) {
    $password = ConvertTo-SecureString $password -AsPlainText -Force
}

$cred = New-Object System.Management.Automation.PSCredential ($username, $password)
$cred | Export-Clixml -Path .\cred.xml

Write-Host "Username and password saved in cred.xml"




