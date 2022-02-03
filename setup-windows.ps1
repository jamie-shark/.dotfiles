#! /usr/bin/env pwsh

function Initialize-Configuration {
    param ()
    $directoriesToCreate = @(
        "Documents\WindowsPowerShell"
        "Documents\PowerShell"
        "AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
    )

    $hardLinksToCreate = @(
        @{
            Name = "_vimrc"
            Value = "home\.vimrc"
        }
        @{
            Name = "Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
            Value = "home\Microsoft.PowerShell_profile.ps1"
        }
        @{
            Name = "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
            Value = "home\Microsoft.PowerShell_profile.ps1"
        }
        @{
            Name = "Documents\PowerShell\Microsoft.VSCode_profile.ps1"
            Value = "home\Microsoft.PowerShell_profile.ps1"
        }
        @{
            Name = "AppData\Roaming\ConEmu.xml"
            Value = "home\ConEmu.xml"
        }
        @{
            Name = "AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
            Value = "home\windows-terminal-settings.json"
        }
    )

    $cwd = Get-Location
    Push-Location $HOME
    $directoriesToCreate | ForEach-Object { New-Item -ItemType Directory -Name $_ -Force }
    $hardLinksToCreate |  ForEach-Object { New-Item -ItemType HardLink -Name $_.Name -Value "$cwd\$($_.Value)" -Force }
    Pop-Location
}

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

Initialize-Prompt
Initialize-Configuration

Install-Choco
Install-Scoop

choco install -y `
    git `
    microsoft-windows-terminal `
    ripgrep `
    fzf `
    choco-cleaner `
    which `
    bat `
    powertoys `
    sysinternals `
    eartrumpet `
    vscode `
    carnac `
    ffmpeg `
    sharex `
    quicklook `
    ditto
scoop install psutils
