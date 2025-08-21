# Suspend BitLocker
Suspend-BitLocker -MountPoint "C:" -RebootCount 1

# Set execution policy to Bypass
Set-ExecutionPolicy Bypass -Scope LocalMachine -Force

# Create upgrade folder
$folderPath = "C:\WindowsUpgrade"
$installerPath = "$folderPath\Windows11InstallationAssistant.exe"
$downloadUrl = "https://go.microsoft.com/fwlink/?linkid=2171764"

if (!(Test-Path -Path $folderPath)) {
    New-Item -Path $folderPath -ItemType Directory | Out-Null
}

# Download installer
Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath

# Run installer silently
Start-Process -FilePath $installerPath -ArgumentList "/auto upgrade /quiet /noreboot /Compat IgnoreWarning" -Wait -NoNewWindow

# Create registry key to track reboot count
$regPath = "HKLM:\SOFTWARE\WindowsUpgrade"
if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}
Set-ItemProperty -Path $regPath -Name "RebootCount" -Value 0
Set-ItemProperty -Path $regPath -Name "UpgradeDate" -Value (Get-Date).ToString("yyyy-MM-dd")

# Create cleanup script
$cleanupScript = @"
\$regPath = 'HKLM:\SOFTWARE\WindowsUpgrade'
\$count = (Get-ItemProperty -Path \$regPath -Name 'RebootCount').RebootCount
\$count++
Set-ItemProperty -Path \$regPath -Name 'RebootCount' -Value \$count

\$upgradeDate = [datetime]::ParseExact((Get-ItemProperty -Path \$regPath -Name 'UpgradeDate').UpgradeDate, 'yyyy-MM-dd', \$null)
\$daysSinceUpgrade = (Get-Date) - \$upgradeDate

\$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
\$usedPercent = [math]::Round((\$disk.Size - \$disk.FreeSpace) / \$disk.Size * 100, 2)

if ((\$count -ge 5 -or \$daysSinceUpgrade.Days -ge 10) -and \$usedPercent -ge 95) {
    Write-Output "Cleaning up Windows.old due to high disk usage and upgrade age..."
    Remove-Item -Path "C:\Windows.old" -Recurse -Force -ErrorAction SilentlyContinue
}

if (\$count -ge 4) {
    Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
    Unregister-ScheduledTask -TaskName 'PostUpgradeCleanup' -Confirm:\$false
}
"@

$cleanupScriptPath = "$folderPath\PostUpgradeCleanup.ps1"
$cleanupScript | Out-File -FilePath $cleanupScriptPath -Encoding UTF8

# Register scheduled task
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$cleanupScriptPath`""
$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName "PostUpgradeCleanup" -Action $action -Trigger $trigger -RunLevel Highest -Force

# Optional: remove installer after launch
Remove-Item -Path $folderPath -Recurse -Force