Get-ChildItem -Path . -Filter *.tar | ForEach-Object { docker load -i $_.FullName }
pause
