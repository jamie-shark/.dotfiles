((Get-Host).UI.RawUI).BackgroundColor = "Black"
Clear-Host
Set-Location C:\Code

$env:Path += ";$home\bin"
Set-Alias vim "C:\Program Files\Git\usr\bin\vim.exe"

function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Write-Separator {
    Write-Host " " -NoNewline -ForegroundColor DarkGray
}

function Write-Username {
    Write-Host "$env:USERNAME@" -NoNewline -ForegroundColor Yellow
    Write-Host "$env:COMPUTERNAME" -NoNewline -ForegroundColor Magenta
}

function Write-Location {
    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($curPath.ToLower().StartsWith($Home.ToLower())) {
        $curPath = "~" + $curPath.SubString($Home.Length)
    }
    Write-Host $curPath -NoNewline -ForegroundColor Cyan
}

function Get-Prompt {
    if (Test-Administrator) {
        return '#'
    }
    else {
        return '$'
    }
}

function Write-DateTime {
    Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor Magenta
}

function prompt {
    $origLastExitCode = $LastExitCode

    Write-Username
    Write-Separator
    Write-Location
    Write-VcsStatus
    Write-Separator
    Write-DateTime

    $LastExitCode = $origLastExitCode
    "`n$(Get-Prompt * ($nestedPromptLevel + 1)) "
}

Import-Module posh-git

function alias($name, $value) {
    if (Test-Path alias:$name) { del alias:$name -Force }
    Set-Alias $name $value
}

function Get-Parameters ([string] $command, [string[]]$outputFormat) {
    (Get-Command $command).ParameterSets | Select -Expand Parameters | ft -a $outputFormat
}

function get-l { ls $args }
function get-ll { ls $args }
function get-c { clear $args }
function get-prerelease { .\build.ps1 -Target Create-PreRelease-Packages $args }
function get-gh { git h $args }
function get-gg { git log --decorate --oneline --graph $args }
function get-gd { git diff $args }
function get-gdc { git diff --cached $args }
function get-gs { git status -s $args }
function get-gf { git fetch origin $args }
function get-gr { git rebase origin/master $args }
function get-gri { git rebase -i $args }
function get-ga { git add -A $args }
function get-gap { git add -p $args }
function get-gca { git commit --amend $args }
function get-gcan { git commit --amend --no-edit $args }
function get-gni { git diff -G "Compile Include" *.csproj $args }
function get-gsn { git show --name-status $args }
function get-gcm { git checkout - $args }
function get-gp { git push $args }
function get-gc { git commit -m $args }
function get-vi { vim $args }
function get-reload {
    $pwd = Get-Location
    . ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
    Set-Location $pwd
}

alias l get-l
alias ll get-ll
alias c get-c
alias prerelease get-prerelease
alias gh get-gh
alias gg get-gg
alias gd get-gd
alias gdc get-gdc
alias gs get-gs
alias gf get-gf
alias gr get-gr
alias gri get-gri
alias ga get-ga
alias gap get-gap
alias gca get-gca
alias gcan get-gcan
alias gni get-gni
alias gsn get-gsn
alias gcm get-gcm
alias gp get-gp
alias gc get-gc
alias vi get-vi
alias reload get-reload

function cddash {
    if ($args[0] -eq '-') {
        $pwd = $OLDPWD;
    } else {
        $pwd = $args[0];
    }
    $tmp = pwd;

    if ($pwd) {
        Set-Location $pwd;
    }
    Set-Variable -Name OLDPWD -Value $tmp -Scope global;
}

Set-Alias -Name cd -value cddash -Option AllScope
