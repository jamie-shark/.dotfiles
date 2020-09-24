$url = "https://aka.ms/wslubuntu2004"
Invoke-WebRequest -Uri $url -OutFile Ubuntu.appx -UseBasicParsing
Add-AppxPackage .\Ubuntu.appx
Remove-Item .\Ubuntu.appx
