Import-Module ExchangeOnlineManagement

# List of admin accounts
$Admins = @(
    "pgadmin@ijis.org",
    "pgadmin@dandvautobody.com",
    "pgadmin@metropolitanshuttle.com",
    "pgadmin@benelsolutions.com"
)

# Picker UI
$Admin = $Admins | Out-GridView -Title "Select Admin Account" -PassThru

# Validate selection
if (-not $Admin) {
    Write-Host "No admin selected. Exiting..." -ForegroundColor Yellow
    exit
}

# Variables

# Build name with timestamp
$Name = $Name = "Remove Phishing Message $(([System.TimeZoneInfo]::ConvertTime((Get-Date), [System.TimeZoneInfo]::FindSystemTimeZoneById('Eastern Standard Time'))).ToString('MM-dd-yy HH:mm'))"

# Email account to seek
$Email = Read-Host "State Email Address"

# Connections
Connect-IPPSSession -UserPrincipalName $Admin -EnableSearchOnlySession
Connect-ExchangeOnline -UserPrincipalName $Admin

Write-Host "Connected as $Admin" -ForegroundColor Green

$Search=New-ComplianceSearch -Name "$Name" -ExchangeLocation All -ContentMatchQuery '(From:$email)'; Start-ComplianceSearch -Identity $Search.Identity;

Start-Sleep -Seconds 300

New-ComplianceSearchAction -SearchName "$Name" -Purge -PurgeType SoftDelete