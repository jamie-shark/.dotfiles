export DISPLAY=:0.0
export TERM=xterm-256color
export PATH="$HOME/bin:$PATH"
export TEMP=/tmp

eval `dircolors ~/.dir_colors`

. ~/.dotfiles/alias.sh

. ~/.dotfiles/posh-git-sh/git-prompt.sh
export PROMPT_COMMAND='__posh_git_ps1 "\\[\[\e[0;32m\]\u@\h \[\e[0;33m\]\w" " \[\e[1;34m\]\n\$\[\e[0m\] ";'$PROMPT_COMMAND

urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }
