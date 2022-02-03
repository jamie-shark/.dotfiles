#! /usr/bin/env pwsh

function Invoke-OnStatusSelection {
    [CmdletBinding()]
    param ([string] $Action, [string] $Preview)

    $paths = @(
        git -c color.status=always status --short `
            | fzf --height 50% `
                --min-height 20 `
                --border `
                --ansi `
                --multi `
                --ansi `
                --nth 2..,.. `
                --preview "(git $Preview --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500" `
            | ForEach-Object { $_.substring(3).replace(".* -> ", "") }
    )
    if ($paths) {
        Invoke-Expression "$Action $(@($paths))"
    }
}

function Trace-DirectoryChange {
    if ($args[0] -eq '-') {
        $oldDirectory = $OLDPWD
    } else {
        $oldDirectory = $args[0]
    }

    $temporaryDirectory = Get-Location;

    if ($oldDirectory) {
        Set-Location $oldDirectory;
    }

    Set-Variable -Name OLDPWD -Value $temporaryDirectory -Scope global;
}

function Get-l           { Get-ChildItem $args }
function Get-ll          { Get-ChildItem $args }
function Get-c           { Clear-Host $args }
function Get-prerelease  { .\build.ps1 -Target Create-PreRelease-Packages $args }
function Get-gh          { git h $args }
function Get-gg          { git log --decorate --oneline --graph $args }
function Get-gd          { git diff $args }
function Get-gdc         { git diff --cached $args }
function Get-gs          { git status -s $args }
function Get-gf          { git fetch origin $args }
function Get-gr          { git rebase origin/master $args }
function Get-gri         { git rebase -i $args }
function Get-ga          { git add -A $args }
function Get-gap         { git add -p $args }
function Get-gacd        { ga; Clear-Host; gdc }
function Get-gca         { git commit --amend $args }
function Get-gcan        { git commit --amend --no-edit $args }
function Get-gco         { git commit -m $args }
function Get-gni         { git diff -G "Compile Include" *.csproj $args }
function Get-gsn         { git show --name-status $args }
function Get-gcm         { git checkout - $args }
function Get-gp          { git push $args }
function Get-gc          { git commit -m $args }
function Get-vi          { vim $args }
function Get-cenv        { rundll32 sysdm.cpl, EditEnvironmentVariables }
function Get-gaf         { Invoke-OnStatusSelection -Action "git add"            -Preview diff }
function Get-gcf         { Invoke-OnStatusSelection -Action "git checkout"       -Preview diff }
function Get-gdf         { Invoke-OnStatusSelection -Action "git diff"           -Preview diff }
function Get-gdcf        { Invoke-OnStatusSelection -Action "git diff --cached"  -Preview "diff --cached" }
function Get-grf         { Invoke-OnStatusSelection -Action "git reset"          -Preview "diff --cached" }
function Get-reload      {
    $directory = Get-Location
    . $PROFILE
    Set-Location $directory
}

function Set-Aliases {

    function Set-DynamicAlias {
        [CmdletBinding()]
        param (
            [Parameter(Mandatory=$true,Position=0)] [string] $Alias,
            [Parameter(Mandatory=$true,Position=1)] [string] $Command
        )

        New-Item `
            -Path function:\ `
            -Name "global:$Alias" `
            -Value "$Command `$args" `
            -Force `
                | Out-Null
    }

    function Set-FunctionAlias {
        param (
            [string] $name,
            [string] $value
        )

        if (Test-Path alias:$name) {
            Remove-Item alias:$name -Force
        }

        Set-Alias $name $value
    }

    ###########

    Set-Alias python "C:\Python38\python.exe"

    Set-FunctionAlias cd         Trace-DirectoryChange
    Set-FunctionAlias l          Get-l
    Set-FunctionAlias ll         Get-ll
    Set-FunctionAlias c          Get-c
    Set-FunctionAlias prerelease Get-prerelease
    Set-FunctionAlias gh         Get-gh
    Set-FunctionAlias gg         Get-gg
    Set-FunctionAlias gd         Get-gd
    Set-FunctionAlias gdc        Get-gdc
    Set-FunctionAlias gs         Get-gs
    Set-FunctionAlias gf         Get-gf
    Set-FunctionAlias gr         Get-gr
    Set-FunctionAlias gri        Get-gri
    Set-FunctionAlias ga         Get-ga
    Set-FunctionAlias gap        Get-gap
    Set-FunctionAlias gacd       Get-gacd
    Set-FunctionAlias gca        Get-gca
    Set-FunctionAlias gcan       Get-gcan
    Set-FunctionAlias gco        Get-gco
    Set-FunctionAlias gni        Get-gni
    Set-FunctionAlias gsn        Get-gsn
    Set-FunctionAlias gcm        Get-gcm
    Set-FunctionAlias gp         Get-gp
    Set-FunctionAlias gc         Get-gc
    Set-FunctionAlias vi         Get-vi
    Set-FunctionAlias cenv       Get-cenv
    Set-FunctionAlias gaf        Get-gaf
    Set-FunctionAlias gcf        Get-gcf
    Set-FunctionAlias gdf        Get-gdf
    Set-FunctionAlias gdcf       Get-gdcf
    Set-FunctionAlias grf        Get-grf
    Set-FunctionAlias reload     Get-reload

}

function Import-ChocolateyProfile {
    $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
    if (Test-Path($ChocolateyProfile)) {
        Import-Module "$ChocolateyProfile"
    }
}

function Start-WslServices {
    if (-not (Get-Process -Name vcxsrv -ErrorAction Ignore)) {
        Write-Host "Starting X server"
        &"C:\Program Files\VcXsrv\xlaunch.exe" -run "$HOME\.dotfiles\config.xlaunch"
    }

    if (-not (Get-Process -Name pulseaudio -ErrorAction Ignore)) {
        Write-Host "Starting pulseaudio server"
        &"C:\pulseaudio-1.1\bin\pulseaudio.exe" --use-pid-file=false -D
    }
}

#############

$env:Path += ";$HOME\bin"
$env:Path += ";C:\Program Files\Git\bin\"
$env:Path += ";C:\Program Files\Git\usr\bin\"

Import-Module posh-git
Import-Module PSReadLine
Set-Aliases
Import-ChocolateyProfile
Start-WslServices

#############

function Get-Parameters {
    param (
        [string] $command,
        [string[]] $outputFormat
    )

    (Get-Command $command).ParameterSets `
        | Select-Object -Expand Parameters `
        | Format-Table -a $outputFormat
}
