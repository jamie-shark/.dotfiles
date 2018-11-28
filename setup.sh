#!/usr/bin/env sh
echo "Setting git configs . . ."
git config --global color.ui auto
git config --global core.autocrlf true
git config --global core.safecrlf false
git config --global core.editor vim
git config --global push.default simple
git config --global alias.h "log --graph --oneline --all --pretty=format:\"%C(yellow)%h%Creset %C(magenta)(%cr)%Creset %C(blue)%cn%Creset %s %C(auto)%d%Creset\""
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global merge.tool diffconflicts
git config --global mergetool.diffconflicts.cmd 'diffconflicts vim $BASE $LOCAL $REMOTE $MERGED'
git config --global mergetool.diffconflicts.trustExitCode true
git config --global mergetool.keepBackup false
git config --global pager.log 'diff-highlight | less'
git config --global pager.show 'diff-highlight | less'
git config --global pager.diff 'diff-highlight | less'
git config --global interactive.diffFilter diff-highlight

echo "Linking dotfiles . . ."
ln ./home/.vimrc ~/.vimrc -f
ln ./home/.bashrc ~/.bashrc -f
ln ./home/.inputrc ~/.inputrc -f
ln ./home/.minttyrc ~/.minttyrc -f

echo "Sourcing bashrc . . ."
source ~/.bashrc

echo "Installing Vundle . . ."
mkdir -p ~/.vim/bundle
git clone -q https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim > /dev/null 2>&1

echo "Installing Posh Git . . ."
git clone -q https://github.com/lyze/posh-git-sh.git ~/.dotfiles/posh-git-sh > /dev/null 2>&1

echo "Installing diffconflicts . . ."
curl https://raw.githubusercontent.com/whiteinge/dotfiles/master/bin/diffconflicts -o ~/bin/diffconflicts > /dev/null 2>&1 && chmod +x ~/bin/diffconflicts

echo "Installing diff-highlight . . ."
curl https://raw.githubusercontent.com/git/git/fd99e2bda0ca6a361ef03c04d6d7fdc7a9c40b78/contrib/diff-highlight/diff-highlight -o ~/bin/diff-highlight > /dev/null 2>&1 && chmod +x ~/bin/diff-highlight

platform=$(uname -s)
if [[ $platform = CYGWIN* ]] || [[ $platform = MINGW* ]] ; then
    echo "Linking Powershell profile . . ."
    mkdir -p ~/Documents/WindowsPowerShell
    ln ./home/Microsoft.PowerShell_profile.ps1 ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 -f
fi
