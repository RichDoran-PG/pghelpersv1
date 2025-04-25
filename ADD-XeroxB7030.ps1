# Define the print server and printer name
$printServer = "\\ADSSERVER2"  # Replace with the actual name or IP of your print server
$printerName = "RTCPB7030"         # Replace with the shared printer's name

# Use rundll32 to install the printer
$command = "rundll32 printui.dll,PrintUIEntry /in /n $printServer\$printerName"
Invoke-Expression $command
