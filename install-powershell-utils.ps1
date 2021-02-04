Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
$env:PATHi += "$ALLUSERSPROFILE\chocolatey\bin"
choco install git microsoft-windows-terminal ripgrep fzf choco-cleaner which bat -y
Install-Module posh-git
Install-Module oh-my-posh -Scope CurrentUser
Install-Module PSReadLine -AllowPrerelease -Force
Invoke-Expression (New-Object net.webclient).DownloadString('https://get.scoop.sh')
scoop install psutils
