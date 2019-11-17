#!/usr/bin/env bash

alias l='ls --color=auto'
alias ll='ls -la --color=auto'
alias ..='cd ..'
alias xit='exit'
alias grep='grep --color=auto'
alias md='mkdir -pv'
alias c='clear'
alias rmswap='rm /tmp/*.sw[o-z]'
alias vi='vim'
alias vi.='vim . `find . -type f | grep -vE "(\.git|\.vs|node_modules)/"`'
alias cenv='rundll32 sysdm.cpl,EditEnvironmentVariables &'
alias start='cmd.exe /c start'

alias ga='git add -A'
alias gacd='ga; clear; gdc'
alias gap='git add -p'
alias gaw='git diff -w --no-color | git apply --cached --ignore-whitespace'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gch='git checkout'
alias gcm='git checkout master'
alias gcp='git checkout -'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch origin'
alias gg='git log --decorate --oneline --graph'
alias gh='git h'
alias ghs='gh --simplify-by-decoration'
alias gni='git diff -G "Compile Include" *.csproj'
alias gp='git push'
alias gr='git rebase origin/master'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase -i'
alias grmu=$'git status -s | grep -i \'^??\' | sed \'s/ /\\ /g\' | awk \'{system("rm "$2)}\''
alias gs='git status -s'
alias gsn='git show --name-status'
alias gv='vi `git rev-parse --show-toplevel` -c "silent Gitv"'
alias gx='git reset . ; git checkout .'

alias gaf='git add $(git status -s | cut -c4- | fzf -m)'
alias gcf='git checkout $(git status -s | cut -c4- | fzf -m)'
alias gdf='git diff $(git status -s | cut -c4- | fzf -m)'
alias grf='git reset $(git status -s | cut -c4- | fzf -m)'

alias branch='git rev-parse --abbrev-ref HEAD'
alias rmmerged='git branch --merged | grep -vE "(^\*|master|dev)" | xargs git branch -d'
alias whatadded='git log --follow --diff-filter=A --find-renames=40% --'
alias docker='docker.exe'
alias dotnet='dotnet.exe'
alias ren='vim -c Ren'
alias ii='start explorer'

ps1() {
    disableProxy='Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 0'
    start powershell -NoProfile -c "$disableProxy; $@ ; pause" ;
}

prerelease() {
    ps1 'sudo ./build.ps1 -Target Create-PreRelease-Packages -Configuration Debug'
}

chooseimages() {
   find . -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' | sed 's/:.*$//' | fim -
}

convertcovers() {
    echo "Select images to convert (y/n/q)"
    chooseimages | xargs -i sh -c $'convert "{}" -resize 500x500 "./$(dirname \'{}\')/cover.jpg"'
}

delimgs() {
    echo "Select images to delete (y/n/q)"
    chooseimages | xargs -i rm "{}"
}

alias imgs='convertcovers && delimgs'
