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

curl -fLo ~/.dir_colors https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark

echo "### Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

platform=$(uname -s)
if [[ $platform = CYGWIN* ]] || [[ $platform = MINGW* ]] ; then
    ln -fs ~/.dotfiles/home/.vimrc ~/_vimrc
    echo "### Linking Powershell profile ###"
    mkdir -p ~/Documents/WindowsPowerShell
    ln -sf ~/.dotfiles/home/Microsoft.PowerShell_profile.ps1 ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
    ln -sf ~/.dotfiles/home/ConEmu.xml ~/AppData/Roaming/ConEmu.xml
    mkdir -p ~/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/
    ln -sf ~/.dotfiles/home/windows-terminal-settings.json ~/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
    exit 0
fi

sudo ln -fs /mnt/c /

echo "### Installing xclip ###"
sudo apt update && sudo apt install xclip -y

echo "### Installing ripgrep ###"
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
sudo dpkg -i ripgrep_0.10.0_amd64.deb
rm ripgrep_0.10.0_amd64.deb

echo "### Installing zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "### Installing ctags"
sudo apt install ctags -y

if ! command -v bat > /dev/null ; then
    echo "### Installing bat"
    wget https://github.com/sharkdp/bat/releases/download/v0.15.4/bat-v0.15.4-x86_64-unknown-linux-gnu.tar.gz
    tar -xzf bat-v0.15.4-x86_64-unknown-linux-gnu.tar.gz
    mv bat-v0.15.4-x86_64-unknown-linux-gnu ~/bin
    ln ~/bin/bat-v0.15.4-x86_64-unknown-linux-gnu/bat ~/bin
    rm bat-v0.15.4-x86_64-unknown-linux-gnu.tar.gz
fi

