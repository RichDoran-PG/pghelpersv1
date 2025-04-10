# Check if the application exists
$appPath = "C:\Program Files\Common Files\Microsoft Shared\ClickToRun\OfficeClickToRun.exe"
# Check if the application exists
if (Test-Path -Path $appPath) {
Write-Output "Application is installed. Starting removal process..."
 
   # RemoveO365HomePremRetail - en-us
    Start-Process -FilePath $appPath -ArgumentList "scenario=install scenariosubtype=ARP sourcetype=None productstoremove=O365HomePremRetail.16_en-us_x-none culture=en-us version.16=16.0" -Wait
    
   # RemoveO365HomePremRetail - fr-fr
    Start-Process -FilePath $appPath -ArgumentList  "scenario=install scenariosubtype=ARP sourcetype=None productstoremove=O365HomePremRetail.16_fr-fr_x-none culture=fr-fr version.16=16.0" displaylevel=False forceappshutdown=True" -NoNewWindow -Wait -PassThru
   
   # RemoveO365HomePremRetail - es-es
   Start-Process -FilePath $appPath -ArgumentList "scenario=install scenariosubtype=ARP sourcetype=None productstoremove=O365HomePremRetail.16_es-es_x-none culture=es-es version.16=16.0" displaylevel=False forceappshutdown=True" -NoNewWindow -Wait -PassThru
   
   # RemoveO365HomePremRetail - pt-br
   Start-Process -FilePath $appPath -ArgumentList "scenario=install scenariosubtype=ARP sourcetype=None productstoremove=O365HomePremRetail.16_pt-br_x-none culture=pt-br version.16=16.0" displaylevel=False forceappshutdown=True" -NoNewWindow -Wait -PassThru
   
   # OneNoteFreeRetail - en-us
   Start-Process -FilePath $appPath -ArgumentList "scenario=install scenariosubtype=ARP sourcetype=None productstoremove=OneNoteFreeRetail.16_en-us_x-none culture=en-us version.16=16.0" displaylevel=False forceappshutdown=True" -NoNewWindow -Wait -PassThru
    
    # OneNoteFreeRetail - es-es
    Start-Process -FilePath $appPath -ArgumentList "scenario=install scenariosubtype=ARP sourcetype=None productstoremove=OneNoteFreeRetail.16_es-es_x-none culture=es-es version.16=16.0" displaylevel=False forceappshutdown=True" -NoNewWindow -Wait -PassThru

    # OneNoteFreeRetail - fr-fr
    Start-Process -FilePath $appPath -ArgumentList "scenario=install scenariosubtype=ARP sourcetype=None productstoremove=OneNoteFreeRetail.16_fr-fr_x-none culture=fr-fr version.16=16.0" displaylevel=False forceappshutdown=True" -NoNewWindow -Wait -PassThru

# Check the exit code to determine success or failure
    if ($process.ExitCode -eq 0) {
        Write-Output "Application successfully removed."
    } else {
        Write-Output "Application removal failed. Exit code: $($process.ExitCode)"
    }
} else {
    Write-Output "Application is not installed."
}