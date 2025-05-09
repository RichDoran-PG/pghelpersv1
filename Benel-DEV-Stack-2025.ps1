$installers = @(
    @{
        Name = "Visual Studio"; URL = "https://aka.ms/vs/17/release/vs_community.exe"; Args = "--quiet --wait --norestart"
    },
    @{
        Name = "Visual Studio Code"; URL = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"; Args = "/VERYSILENT /NORESTART"
    },
    @{
        Name = "Postman"; URL = "https://www.postman.com/downloads/postman-win64.zip"; IsZip = $true
    },
    @{
        Name = "SoapUI"; URL = "https://www.soapui.org/downloads/latest-release/"; Args = "/S"
    },
    @{
        Name = "dotPeek"; URL = "https://download.jetbrains.com/decompiler/dotPeek.exe"; Args = "/S"
    },
    @{
        Name = "WinRAR"; URL = "https://www.win-rar.com/fileadmin/winrar-versions/winrar-x64-621.exe"; Args = "/S"
    },
    @{
        Name = "WinMerge"; URL = "https://github.com/WinMerge/winmerge/releases/latest/download/WinMerge-Setup.exe"; Args = "/S"
    },
    @{
        Name = "Google Chrome"; URL = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"; Args = "/silent /install"
    },
    @{
        Name = "Adobe Reader"; URL = "https://ardownload2.adobe.com/pub/adobe/reader/win/AcrobatDC/2301220055/AcroRdrDC2301220055_en_US.exe"; Args = "/sAll /rs"
    },
    @{
        Name = "SQL Server Express"; URL = "https://go.microsoft.com/fwlink/?linkid=866658"; Args = "/Q /ACTION=INSTALL /FEATURES=SQLEngine /INSTANCENAME=SQLEXPRESS /SQLSYSADMINACCOUNTS=BUILTIN\Administrators"
    },
    @{
        Name = "SSMS"; URL = "https://aka.ms/ssmsfullsetup"; Args = "/quiet /norestart"
    },
    @{
        Name = "SQL Server Report Builder"; URL = "https://download.microsoft.com/download/5/a/e/5ae107b1-b166-4b85-b994-7a7c5ff4d135/ReportBuilder.msi"; IsMSI = $true
    }
)

foreach ($app in $installers) {
    $installerPath = "$env:TEMP\$($app.Name.Replace(' ', '')).exe"

    Write-Host "Downloading $($app.Name)..."
    Invoke-WebRequest -Uri $app.URL -OutFile $installerPath

    if ($app.IsZip) {
        $extractPath = "$env:ProgramFiles\$($app.Name)"
        Expand-Archive -Path $installerPath -DestinationPath $extractPath -Force
        Remove-Item -Path $installerPath -Force
    } elseif ($app.IsMSI) {
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $installerPath /quiet /norestart" -NoNewWindow -Wait
    } else {
        Start-Process -FilePath $installerPath -ArgumentList $app.Args -NoNewWindow -Wait
    }

    Remove-Item -Path $installerPath -Force
    Write-Host "$($app.Name) installation completed!"
}