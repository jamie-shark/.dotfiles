#!/usr/bin/env sh
echo "Linking dotfiles . . ."
ln ./home/.vimrc ~/.vimrc -f
ln ./home/.bashrc ~/.bashrc -f
ln ./home/.inputrc ~/.inputrc -f
ln ./home/.minttyrc ~/.minttyrc -f

echo "Installing Vundle . . ."
mkdir -p ~/.vim/bundle
git clone -q https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Installing Post Git . . ."
git clone -q https://github.com/lyze/posh-git-sh.git ~/.dotfiles/posh-git-sh

echo "Installing diffconflicts . . ."
curl --url https://raw.githubusercontent.com/whiteinge/dotfiles/master/bin/diffconflicts --output ~/bin/diffconflicts --create-dirs

platform=$(uname -s)
if [[ $platform = CYGWIN* ]] || [[ $platform = MINGW* ]] ; then
    echo "Linking Powershell profile . . ."
    mkdir ~/Documents/WindowsPowerShell
    ln ./home/Microsoft.PowerShell_profile.ps1 ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 -f
fi
