$env:Path += ";$home\bin"
Set-Alias vim "C:\Program Files\Git\usr\bin\vim.exe"

Import-Module posh-git

function alias($name, $value) {
    if (Test-Path alias:$name) { del alias:$name -Force }
    Set-Alias $name $value
}

function Get-Parameters ([string] $command, [string[]]$outputFormat) {
    (Get-Command $command).ParameterSets | Select -Expand Parameters | ft -a $outputFormat
}

function get-l { ls }
function get-ll { ls -la }
function get-c { clear }
function get-prerelease { .\build.ps1 -Target Create-PreRelease-Packages }
function get-gh { git h }
function get-gg { git log --decorate --oneline --graph }
function get-gd { git diff }
function get-gdc { git diff --cached }
function get-gs { git status -s }
function get-gf { git fetch origin }
function get-gr { git rebase origin/master }
function get-gri { git rebase -i }
function get-ga { git add -A }
function get-gap { git add -p }
function get-gca { git commit --amend }
function get-gcan { git commit --amend --no-edit }
function get-gni { git diff -G "Compile Include" *.csproj }
function get-gsn { git show --name-status }
function get-gcm { git checkout - }
function get-gp { git push }
function get-gc { git commit -m }

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
