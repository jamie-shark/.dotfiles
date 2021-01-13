Push-Location $HOME

@(
    "Documents\WindowsPowerShell"
    "Documents\PowerShell"
    "AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
) | ForEach-Object { New-Item -ItemType Directory -Name $_ -Force }

@(
    @{
        Name = "_vimrc"
        Value = ".dotfiles\home\.vimrc"
    }
    @{
        Name = "Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
        Value = ".dotfiles\home\Microsoft.PowerShell_profile.ps1"
    }
    @{
        Name = "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
        Value = ".dotfiles\home\Microsoft.PowerShell_profile.ps1"
    }
    @{
        Name = "AppData\Roaming\ConEmu.xml"
        Value = ".dotfiles\home\ConEmu.xml"
    }
    @{
        Name = "AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
        Value = ".dotfiles\home\windows-terminal-settings.json"
    }
) |  ForEach-Object { New-Item -ItemType HardLink -Name $_.Name -Value $_.Value -Force }

Pop-Location

choco install -y `
    powertoys `
    sysinternals `
    eartrumpet `
    vscode `
    carnac `
    ffmpeg `
    sharex `
    quicklook `
    ditto