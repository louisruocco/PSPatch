# Windows Patching

function Windows-Patching {
    $logpath = 'C:\PSPatch\Windows Logs'
    $date = Get-Date -Format 'yyyyMMdd'

    $(
    if(!($logpath)){
        Write-Output 'Creating path to store Windows Logs'
        New-Item -ItemType Directory -Path $logpath
    }

    $ModuleName = 'PSWindowsUpdate'
    if(!(Get-Module -ListAvailable $ModuleName)){
        Write-Output "PSWindows Update not found. Installing Module now..."
        Write-Output "Setting InstallationPolicy to Trusted TEMPORARILY"
        Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
        Install-Module $ModuleName -Scope CurrentUser
        Write-Output "Setting InstallationPolicy back to untrusted"
        Set-PSRepository -Name 'PSGallery' -InstallationPolicy untrusted
        Write-Output "PSWindowsUpdate module installed successfully!"
    }

    Write-Output 'Installing the following Windows Updates...'
    Get-WindowsUpdate
    try {
        Install-WindowsUpdate -AcceptAll
        Write-Output 'Installed Windows Updates Successfully'
    } catch {
        Throw $Error
    }

    ) >"$logpath\Windows_Patching_Log_$date.txt"

}

Windows-Patching