Install-module pswindowsupdate -force -AllowClobber;
get-windowsupdate -acceptall -install;
winget upgrade --all -force -AllowClobber;
sfc /scannow;
Restart-Computer
