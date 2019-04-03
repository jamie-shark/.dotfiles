&"$SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
$env:PATHi+="$ALLUSERSPROFILE\chocolatey\bin"
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
scoop install psutils
