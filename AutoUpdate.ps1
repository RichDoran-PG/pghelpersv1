# Install PSWindowsUpdate module
Install-Module -Name PSWindowsUpdate -Force -AllowClobber

# Install all Windows updates
Get-WindowsUpdate -AcceptAll -Install

# Upgrade all applications using winget (removing AllowClobber)
winget upgrade --all --force

# Run System File Checker
sfc /scannow

# Restart the computer
#Restart-Computer -Force
