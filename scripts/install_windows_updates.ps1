Write-Host "installing nuget"
Get-PackageProvider nuget -Force

Write-Host "install windows updates module"
Install-Module PSWindowsUpdate -Force
Import-Module PSWindowsUpdate

Write-Host "register to use MicrosoftUpdate service"
Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d -Confirm:$false

Write-Host "install updates"
Get-WUInstall -MicrosoftUpdate -AcceptAll -IgnoreReboot -Verbose