#!/usr/bin/env sh

echo "### Setting git configs ###"
git config --global color.ui auto
git config --global core.autocrlf false
git config --global core.safecrlf false
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
git config --global pager.log 'diff-highlight | less'
git config --global pager.show 'diff-highlight | less'
git config --global pager.diff 'diff-highlight | less'
git config --global interactive.diffFilter diff-highlight

echo "### Linking dotfiles ###"
ln ./home/.vimrc ~/.vimrc -fs
ln ./home/.bashrc ~/.bashrc -fs
ln ./home/.inputrc ~/.inputrc -fs
ln ./home/.minttyrc ~/.minttyrc -fs

echo "### Installing VimPlug ###"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "### Installing Posh Git ###"
git clone https://github.com/lyze/posh-git-sh.git ~/.dotfiles/posh-git-sh

echo "### Installing diffconflicts ###"
curl https://raw.githubusercontent.com/whiteinge/dotfiles/master/bin/diffconflicts -o ~/bin/diffconflicts

echo "### Installing diff-highlight ###"
curl https://raw.githubusercontent.com/git/git/fd99e2bda0ca6a361ef03c04d6d7fdc7a9c40b78/contrib/diff-highlight/diff-highlight -o ~/bin/diff-highlight

echo "### Installing fonts ###"
mkdir -p ~/.fonts
cp GoMono-NF.ttf ~/.fonts/

platform=$(uname -s)
if [[ $platform = CYGWIN* ]] || [[ $platform = MINGW* ]] ; then
    ln ./home/.vimrc ~/_vimrc -fs
    echo "### Linking Powershell profile ###"
    mkdir -p ~/Documents/WindowsPowerShell
    ln ./home/Microsoft.PowerShell_profile.ps1 ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 -fs
    ln ./home/ConEmu.xml ~/AppData/Roaming/ConEmu.xml -fs
fi

echo "### Installing Vim plugins ###"
vim -c 'call InstallPlugins()' -c 'qa!'
