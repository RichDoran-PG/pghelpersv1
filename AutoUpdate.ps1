get-windowsupdate -acceptall -install;
winget upgrade --all;
sfc /scannow;
restart -r -t 00