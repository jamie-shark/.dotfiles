# .dotfiles
___
### Windows dependencies
* MinGW-w64 64 bit GNU tool set: https://sourceforge.net/projects/mingw/files/Installer/mingw-get-setup.exe/download
* MSYS2 terminal emulator: https://www.msys2.org/
* git-sdk-64 https://github.com/git-for-windows/build-extra/releases/latest
#### Alternatively
* Enable linux subsystem windows feature
* In powershell
```
choco install wcxsrv -y
```
* Install bash on Ubuntu for Windows through the app store
* Launch bash.exe and setup root user, then:
```
sudo apt update && sudo apt install git
git clone https://github.com/jon-campbell/.dotfiles.git
cd .dotfiles
sh ./wsl-setup.sh
```
* Lauch straight into terminator from windows using `terminator.lnk`, pin this to start or quicklaunch

### Script
linkfiles.sh will replace existing dotfiles in the home directory with symlinks to these configuration files.

### Configuration files

* vimrc
* bashrc
* inputrc
* minttyrc
* tmux.conf

* Powershell profile
___

