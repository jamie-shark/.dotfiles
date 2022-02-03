#!/usr/bin/env bash

echo "### Setting git configs ###"
git config --global color.ui always
git config --global core.autocrlf input
git config --global core.safecrlf warn
git config --global core.editor vim
git config --global core.preloadindex true
git config --global core.fscache true
git config --global gc.auto 256
git config --global push.default simple
git config --global alias.h "log --graph --oneline --all --pretty=format:\"%C(yellow)%h%Creset %C(magenta)(%cr)%Creset %C(blue)%cn%Creset %s %C(auto)%d%Creset\""
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global merge.tool diffconflicts
git config --global mergetool.diffconflicts.cmd 'diffconflicts vim $BASE $LOCAL $REMOTE $MERGED'
git config --global mergetool.diffconflicts.trustExitCode true
git config --global mergetool.keepBackup false
git config --global pager.log 'diff-highlight | less -XF'
git config --global pager.show 'diff-highlight | less -XF'
git config --global pager.diff 'diff-highlight | less -XF'
git config --global pager.branch 'less -XF'
git config --global pager.tag 'less -XF'
git config --global interactive.diffFilter diff-highlight
git config --global core.excludesfile ~/.gitignore_global

echo "### Linking dotfiles ###"
ln -fs ~/.dotfiles/home/.vimrc ~/.vimrc
ln -fs ~/.dotfiles/home/.bashrc ~/.bashrc
ln -fs ~/.dotfiles/home/.zshrc ~/.zshrc
ln -fs ~/.dotfiles/home/.inputrc ~/.inputrc
ln -fs ~/.dotfiles/home/.minttyrc ~/.minttyrc
ln -fs ~/.dotfiles/home/.hyper.js ~/.hyper.js
mkdir -p ~/.config/terminator
ln -fs ~/.dotfiles/home/terminator ~/.config/terminator/config
ln -fs ~/.dotfiles/home/.ctags ~/
ln -fs ~/.dotfiles/home/.gitignore_global ~/
ln -fs ~/.dotfiles/home/.gitk ~/
ln -fs ~/.dotfiles/home/.fimrc ~/
mkdir -p ~/.config/bat && ln -sf ~/.dotfiles/home/bat.config ~/.config/bat/config

echo "### Installing VimPlug ###"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "### Installing diffconflicts ###"
curl -fLo ~/bin/diffconflicts --create-dirs https://raw.githubusercontent.com/whiteinge/dotfiles/master/bin/diffconflicts && chmod +x ~/bin/diffconflicts

echo "### Installing diff-highlight ###"
curl -fLo ~/bin/diff-highlight --create-dirs https://raw.githubusercontent.com/git/git/fd99e2bda0ca6a361ef03c04d6d7fdc7a9c40b78/contrib/diff-highlight/diff-highlight && chmod +x ~/bin/diff-highlight

echo "### Installing fonts ###"
mkdir -p ~/.fonts
cp fonts/* ~/.fonts/

echo "### Installing Vim plugins ###"
vim -c 'call InstallPlugins()' -c 'qa!'

curl -fLo ~/.dir_colors https://raw.githubusercontent.com/arcticicestudio/nord-dircolors/develop/src/dir_colors

echo "### Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

platform=$(uname -s)
if [[ $platform = CYGWIN* ]] || [[ $platform = MINGW* ]] ; then
    exit 0
fi

sudo ln -fs /mnt/c /

sudo apt update && sudo apt install -y xclip ripgrep ctags bat

echo "### Installing zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

