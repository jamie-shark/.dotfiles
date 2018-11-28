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

echo "Installing diff-highlight . . ."
curl https://raw.githubusercontent.com/git/git/fd99e2bda0ca6a361ef03c04d6d7fdc7a9c40b78/contrib/diff-highlight/diff-highlight -o ~/bin/diff-highlight > /dev/null 2>&1 && chmod +x ~/bin/diff-highlight

platform=$(uname -s)
if [[ $platform = CYGWIN* ]] || [[ $platform = MINGW* ]] ; then
    echo "Linking Powershell profile . . ."
    mkdir ~/Documents/WindowsPowerShell
    ln ./home/Microsoft.PowerShell_profile.ps1 ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 -f
fi
