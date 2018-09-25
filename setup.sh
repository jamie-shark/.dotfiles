#!/usr/bin/env sh
ln ./home/.vimrc ~/.vimrc -f
ln ./home/.bashrc ~/.bashrc -f
ln ./home/.inputrc ~/.inputrc -f
mkdir -p ~/.vim/bundle
git clone -q https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone -q https://github.com/lyze/posh-git-sh.git ~/.dotfiles/posh-git-sh
