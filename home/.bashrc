export DISPLAY=:0.0
export TERM=xterm-256color
export PATH="$HOME/bin:$PATH"
export TEMP=/tmp

eval `dircolors ~/.dir_colors`

. ~/.dotfiles/alias.sh

. ~/.dotfiles/posh-git-sh/git-prompt.sh
export PROMPT_COMMAND='__posh_git_ps1 "\\[\[\e[0;32m\]\u@\h \[\e[0;33m\]\w" " \[\e[1;34m\]\n\$\[\e[0m\] ";'$PROMPT_COMMAND

urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# if [ -t 1 ]; then
#   cd ~
#   exec zsh
# fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PATH="/home/jon/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/jon/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/jon/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/jon/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/jon/perl5"; export PERL_MM_OPT;
