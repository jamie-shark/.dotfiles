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

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
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

dirsizes() {
    dir=${1:-.}
    depth=${2:-1}
    perl_splitSizeAndPath='print "@F[0]\t@F[1..$#F]"'
    sed_escapePath="s,\\([][() ']\\),\\\\\1,g"
    awk_rightPadSize='{printf "%-8s%s\n", $1, $2}'

    du -hx "-d$depth" "$dir/" \
    | sort -h \
    | perl -lane  $perl_splitSizeAndPath \
    | sed         $sed_escapePath \
    | awk -F '\t' $awk_rightPadSize
}

alias deldir=$'dirsizes | fzf -m --preview \'echo {} | cut -c9- | xargs ls -la\' | cut -c9- | xargs -rp rm -rd'

gcb() {
  result=$(git branch -a --color=always \
      | grep -v '/HEAD\s' \
      | sort \
      | fzf --height 50% \
            --border \
            --ansi \
            --tac \
            --preview-window right:70% \
            --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES \
      | sed 's/^..//' \
      | cut -d' ' -f1)

  if [[ $result != "" ]]; then
    if [[ $result == remotes/* ]]; then
      git checkout --track $(echo $result | sed 's#remotes/##')
    else
      git checkout "$result"
    fi
  fi
}

gitselect() {
    preview=$1
    git -c color.status=always status --short \
        | fzf --height 50% \
              --border \
              --ansi \
              --multi \
              --ansi \
              --nth 2..,.. \
              --preview "(git $preview --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500" \
        | cut -c4- \
        | sed 's/.* -> //'
}

gaf() { git add $(gitselect "diff") ;}
gcf() { git checkout $(gitselect "diff") ;}
gdf() { git diff $(gitselect "diff") ;}
grf() { git reset $(gitselect "diff --cached") ;}
