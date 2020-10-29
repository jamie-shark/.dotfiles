#!/usr/bin/env bash

#set -x
#trap read debug

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
alias rg='rg -j1'
alias fzfi='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}" | fzf'

alias ga='git add -A'
alias gacd='ga; clear; gdc'
alias gap='git add -p'
alias gaw='git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gch='git checkout'
alias gcm='git checkout master'
alias gcp='git checkout -'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch origin --prune'
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
alias gst='git status --short --branch'
alias gv='vi `git rev-parse --show-toplevel` -c "silent Gitv"'
alias gx='git reset . ; git checkout .'

alias branch='git rev-parse --abbrev-ref HEAD'
alias rmmerged='git branch --no-color --merged | grep -vE "(^\*|master|dev)" | xargs git branch -d'
alias whatadded='git log --follow --diff-filter=A --find-renames=40% --'
alias docker='docker.exe'
alias dotnet='dotnet.exe'
alias yarn='yarnpkg'
alias ren='vim -c Ren'
alias ii='start explorer'
alias bank='echo sort code: 309323 acc no:  01312164'
alias todo='ag --color-line-number "1;36" --color-path "1;36" --ignore-case --print-long-lines --silent "(?:< *)?(?:#|//|/\*+|<!--|--) *(TODO|FIXME|FIX|BUG|UGLY|HACK|NOTE|IDEA|REVIEW|DEBUG|OPTIMIZE)(?:\([^(]+\))?:?(?!\w)(?: *-->| *\*/|(?= *(?:[^:]//|/\*+|<!--|@|--))|((?: +[^\n@]*?)(?= *(?:[^:]//|/\*+|<!--|@|--))|(?: +[^@\n]+)?))"'

ps1() {
    while getopts ":c:e" opt; do
        case $opt in
            c)  close=true ;;
            e)  elevate=true ;;
            \?) ;;
        esac
    done
    shift $(($OPTIND - 1))

    disableProxy='Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 0'
    here=$(pwd | cut -c3-)
    psCommand="$disableProxy ; cd $here ; $@"
    if ! [ "$close" = "true" ] ; then
        psCommand="$psCommand ; pause"
    fi
    if [ "$elevate" = "true" ] ; then
        psCommand="sudo $psCommand"
    fi
    start powershell -c $psCommand
}

prerelease() {
    ps1 'sudo ./build.ps1 -Target Create-PreRelease-Packages -Configuration Debug'
}

fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null \
      | fzf --height 50% \
            --border \
            --ansi \
            --tac \
            --preview-window right:50% \
            +m \
            --preview "ls -la {}") &&
    cd "$dir"
}

choose-images() {
   find . -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' | sed 's/:.*$//' | fim -
}

convert-covers() {
    echo "Select images to convert (y/n/q)"
    choose-images | xargs -i sh -c $'convert "{}" -resize 500x500 "./$(dirname \'{}\')/cover.jpg"'
}

delete-images() {
    echo "Select images to delete (y/n/q)"
    choose-images | xargs -i rm "{}"
}

function chop-images() {
    echo "Select images to chop (y/n/q)"
    choose-images | xargs -i sh -c $'convert "{}" -scale x500 -gravity East -crop 500x500+2+0 "./$(dirname \'{}\')/cover.jpg"'
}

alias scale='convert-covers && delete-images'
alias chop='chop-images && delete-images'

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
gdcf() { git diff --cached $(gitselect "diff --cached") ;}
grf() { git reset $(gitselect "diff --cached") ;}
rmf() { rm $(gitselect "diff") ;}

alias gi="curl -LSso .gitignore http://gitignore.io/api/vim,jetbrains,dotnetcore,visualstudio,visualstudiocode"

alias copydiff="gdf --color=never | xclip"

ineach() {
    cmd=${1:-pwd}
    dir=${2:-.}
    for d in "$dir/*/"
    do
        cd "$d"
        $($cmd)
        cd -
    done
}
