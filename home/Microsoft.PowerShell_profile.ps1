$env:Path += ";$home\bin"
$env:Path += ";C:\Program Files\Git\bin\"
$env:Path += ";C:\Program Files\Git\usr\bin\"

Set-Alias python "C:\Python38\python.exe"

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

function prompt-old {
    $origLastExitCode = $LastExitCode

    Write-Username
    Write-Separator
    Write-Location
    Write-VcsStatus

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
function get-gacd { ga; cls; gdc }
function get-gca { git commit --amend $args }
function get-gcan { git commit --amend --no-edit $args }
function get-gco { git commit -m $args }
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
function get-cenv { rundll32 sysdm.cpl, EditEnvironmentVariables }

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
alias gacd get-gacd
alias gca get-gca
alias gcan get-gcan
alias gco get-gco
alias gni get-gni
alias gsn get-gsn
alias gcm get-gcm
alias gp get-gp
alias gc get-gc
alias vi get-vi
alias reload get-reload
alias cenv get-cenv

function Invoke-OnStatusSelection {
    param([ScriptBlock]$action)
    Invoke-Command $action $(git status -s | % { $_.substring(3) } | fzf -m)
}
function get-gaf { Invoke-OnStatusSelection { git add } }
function get-gcf { Invoke-OnStatusSelection { git checkout } }
function get-gdf { Invoke-OnStatusSelection { git diff } }
function get-grf { Invoke-OnStatusSelection { git reset } }

alias gaf get-gaf
alias gcf get-gcf
alias gdf get-gdf
alias grf get-grf

function cddash {
    if ($args[0] -eq '-') {
        $pwd = $OLDPWD;
    }
    else {
        $pwd = $args[0];
    }
    $tmp = pwd;

    if ($pwd) {
        Set-Location $pwd;
    }
    Set-Variable -Name OLDPWD -Value $tmp -Scope global;
}

Set-Alias -Name cd -value cddash -Option AllScope

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

if (-not (Get-Process -Name vcxsrv -ErrorAction Ignore))
{
    &"C:\Program Files\VcXsrv\vcxsrv.exe" :0 -ac -terminate -lesspointer -multiwindow -clipboard -wgl -dpi auto
}

