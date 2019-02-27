export DISPLAY=:0.0
export TERM=xterm-256color
export PATH="$HOME/bin:$PATH"
export TEMP=/tmp

# alias
alias l='ls --color=auto'
alias ll='ls -la --color=auto'
alias grep='grep --color=auto'
alias md='mkdir -pv'
alias ..='cd ..'
alias c='clear'
alias prerelease='powershell ./build.ps1 -Target Create-PreRelease-Packages -Configuration Debug'
alias rmswap='rm /tmp/*.sw[o-z]'
alias ps1='winpty powershell -c'
alias vi='vim'
alias vi.='vim . `find . -type f | grep -vE "(\.git|\.vs|node_modules)/"`'
alias cenv='rundll32 sysdm.cpl,EditEnvironmentVariables &'
alias start='cmd.exe /c start'

alias ga='git add -A'
alias gaw='git diff -w --no-color | git apply --cached --ignore-whitespace'
alias gacd=$'ga; clear; gdc'
alias gap='git add -p'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcm='git checkout -'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch origin'
alias gg='git log --decorate --oneline --graph'
alias gh='git h'
alias gni='git diff -G "Compile Include" *.csproj'
alias gp='git push'
alias gr='git rebase origin/master'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase -i'
alias grmu=$'git status -s | grep -i \'^??\' | sed \'s/ /\\ /g\' | awk \'{system("rm "$2)}\''
alias gs='git status -s'
alias gsn=$'git show --name-status'
alias gv='vi `git rev-parse --show-toplevel` -c "silent Gitv"'
alias gx='git reset . ; git checkout .'
alias branch='git rev-parse --abbrev-ref HEAD'
alias rmmerged='git branch --merged | grep -vE "(^\*|master|dev)" | xargs git branch -d'
alias whatadded='git log --follow --diff-filter=A --find-renames=40% --'

# posh git prompt
#source ~/.dotfiles/posh-git-sh/git-prompt.sh
#export PROMPT_COMMAND='__posh_git_ps1 "\\[\[\e[0;32m\]\u@\h \[\e[0;33m\]\w" " \[\e[1;34m\]\n\$\[\e[0m\] ";'$PROMPT_COMMAND

# function
urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }
