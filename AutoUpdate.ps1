Install-module pswindowsupdate -force -AllowClobber;
get-windowsupdate -acceptall -install;
winget upgrade --all;
sfc /scannow;
Restart-Computer
