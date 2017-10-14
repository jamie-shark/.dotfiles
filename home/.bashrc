# path
export PATH="$PATH:$HOME/bin"

# alias
alias l='ls --color=auto'
alias ll='ls -la --color=auto'
alias md='mkdir'

# git alias
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
alias gcan='git commit --amend --no-edit'

# homesick
alias hs=homeshick
alias homesick=homeshick
alias vimrc='vim ~/.homesick/repos/dotfiles-castle/home/.vimrc'
alias bashrc='vim ~/.homesick/repos/dotfiles-castle/home/.bashrc'
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

