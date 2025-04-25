# Define the print server name and printer name
$printServer = "\\ADSSERVER2"  # Replace with the name of your print server
$printerName = "RTCPB7030"         # Replace with the name of the shared printer on the server

# Add the printer from the local print server
Add-Printer -ConnectionName "$printServer\$printerName"