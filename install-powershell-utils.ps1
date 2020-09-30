Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
$env:PATHi += "$ALLUSERSPROFILE\chocolatey\bin"
choco install git microsoft-windows-terminal ripgrep fzf choco-cleaner -y
Install-Module posh-git
Invoke-Expression (New-Object net.webclient).DownloadString('https://get.scoop.sh')
scoop install psutils
