# path
export PATH="$PATH:$HOME/bin"

# alias
alias l='ls --color=auto'
alias ll='ls -la --color=auto'
alias md='mkdir'

# git
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
git config --global color.ui auto
git config --global alias.h "log --graph --oneline --all --pretty=format:\"%C(yellow)%h%Creset %C(magenta)(%cr)%Creset %C(blue)%cn%Creset %s %C(auto)%d%Creset\""
git config --global core.autocrlf true
git config --global core.safecrlf false
git config --global push.default simple
alias gh='git h'

