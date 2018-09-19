source ~/.dotfiles/posh-git-sh/git-prompt.sh
export PROMPT_COMMAND='__posh_git_ps1 "\\[\[\e[0;32m\]\u@\h \[\e[0;33m\]\w" " \[\e[1;34m\]\n\$\[\e[0m\] ";'$PROMPT_COMMAND

# path
export PATH="$PATH:$HOME/bin"

# alias
alias l='ls --color=auto'
alias ll='ls -la --color=auto'
alias grerp='grep --color=auto'
alias md='mkdir -pv'
alias ..='cd ..'
alias c='clear'
alias prerelease='powershell ./build.ps1 -Target Create-PreRelease-Packages -Debug'
alias rmswap='rm /tmp/*.sw[o-z]'

# git
git config --global color.ui auto
git config --global core.autocrlf true
git config --global core.safecrlf false
git config --global core.editor vim
git config --global push.default simple
git config --global alias.h "log --graph --oneline --all --pretty=format:\"%C(yellow)%h%Creset %C(magenta)(%cr)%Creset %C(blue)%cn%Creset %s %C(auto)%d%Creset\""
git config --global merge.tool diffconflicts
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global mergetool.diffconflicts.cmd diffconflicts vim $BASE $LOCAL $REMOTE $MERGED
git config --global mergetool.diffconflicts.trustExitCode true
git config --global mergetool.keepBackup false

alias gh='git h'
alias gg='git log --decorate --oneline --graph'
alias gd='git diff'
alias gdc='git diff --cached'
alias gs='git status -s'
alias gf='git fetch origin'
alias gr='git rebase origin/master'
alias gri='git rebase -i'
alias gp='git push'
alias ga='git add -A'
alias gap='git add -p'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcm='git checkout -'
alias gni='git diff -G "Compile Include" *.csproj'
alias grmu=$'git status -s | grep -i \'^??\' | sed \'s/ /\\ /g\' | awk \'{system("rm "$2)}\''
alias gsn=$'git show --name-status'
alias gacd=$'ga; clear; gdc'

# function
urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }
