Write-Host "Update execution policy\n"
Set-ExecutionPolicy Unrestricted -Scope CurrentUser

Write-Host "Supress network local prompt\n"
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force

Write-Host "Set network to private"
$ifaceinfo = Get-NetConnectionProfile
Set-NetConnectionProfile -InterfaceIndex $ifaceinfo.InterfaceIndex -NetworkCategory Private 

Write-Host "Set up WinRM and configure some things"
winrm quickconfig -q
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service '@{MaxConcurrentOperationsPerUser="1500"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="512"}'
winrm set winrm/config/winrs '@{MaxShellsPerUser="60"}'
winrm set winrm/config/winrs '@{MaxProcessesPerShell="60"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'


# Enable the WinRM Firewall rule, which will likely already be enabled due to the 'winrm quickconfig' command above
Enable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"

sc.exe config winrm start= auto
