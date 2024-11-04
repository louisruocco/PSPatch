# Windows Patching

# Check if PSWindowsUpdate is installed
function Get-WindowsUpdates {
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
}

Get-WindowsUpdates