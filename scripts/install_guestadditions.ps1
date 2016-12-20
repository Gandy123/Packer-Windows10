Write-Host "Install guest additions"
cd e:\cert
.\VBoxCertUtil add-trusted-publisher oracle-vbox.cer --root oracle-vbox.cer
e:\VBoxWindowsAdditions.exe /S /l
