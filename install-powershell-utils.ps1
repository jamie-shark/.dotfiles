#! /usr/bin/env pwsh

function Install-Choco {
  param ()
  Invoke-Expression (New-Object Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')
  $env:PATH += ";$ALLUSERSPROFILE\chocolatey\bin"
}

function Install-Scoop {
  param ()
  Invoke-Expression (New-Object Net.WebClient).DownloadString('https://get.scoop.sh')
}

function Initialize-Prompt {
  param ()
  Install-Module posh-git
  Install-Module PSReadLine -AllowPrerelease -Force
}

###############

Install-Choco
Install-Scoop

choco install -y `
              git `
              microsoft-windows-terminal `
              ripgrep `
              fzf `
              choco-cleaner `
              which `
              bat
scoop install psutils

Initialize-Prompt
