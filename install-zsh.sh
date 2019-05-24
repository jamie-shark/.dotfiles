#!/usr/bin/env sh

sudo apt update && sudo apt install curl zsh
curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash
chsh -s $(which zsh)
