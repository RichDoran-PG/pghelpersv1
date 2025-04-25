# List Printers installed before scipt is run
Get-Printer
# Add Port/Printer Name and IP Address
Add-PrinterPort -Name "RTCPB7030" -PrinterHostAddress "10.0.1.250"
# Assign Driver to Named Printer
Add-Printer -Name "RTCPB7030" -DriverName "Xerox VersaLink B7030 PCL6" -PortName "RTCPB7030"
# List Printers installed after script run, you should see the New Printer listed
Get-Printer
