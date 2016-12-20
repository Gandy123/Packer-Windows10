iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

Write-Host "--- Enable global confirmations for choco install ---"
choco feature enable -n allowGlobalConfirmation

Write-Host "--- Allow empty checksums for chocolatey ---"
choco feature enable -n allowEmptyChecksums

