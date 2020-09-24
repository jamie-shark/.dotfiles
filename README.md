# .dotfiles
___
## Setup
* Enable linux subsystem windows feature
* In powershell (use install-powershell-utils.cmd if needed):
```
choco install vcxsrc -y
```
* Install bash on Ubuntu for Windows through the app store
* Launch bash.exe and setup root user, then:
```
sudo apt update && sudo apt install git xclip -y
ln -s /mnt/c/Users/jonathan.campbell/.dotfiles/ ~/
cp -r /mnt/c/Users/jonathan.campbell/.ssh ~/
sudo ln -fs /mnt/c /
cd .dotfiles
./wsl-setup.sh
./setup.sh
```
* Lauch straight into terminator from windows using `terminator.lnk`, pin this to start or quicklaunch
---
### Scripts
#### wsl-setup.sh
* Updates the ubuntu system
* Installs the terminal emulator and multiplexer 'terminator'
* install-pulseaudio.sh installs the windows and linux parts required for audio to work. Will need the pulseaudio-1.1 folder copying to the C drive once run.

#### setup.sh
* Sets global git configs
* Replaces existing dotfiles in the home directory with symlinks to these configuration files.
* Installs some diff tools used by the git configs
* Insalls VimPlug and runs InstallPlugins()
* Installs the GoMono font
* If run from cygwin or mingw it will link '_vimrc', powershell profile, and ConEmu config.

#### terminator.ps1 / terminator.lnk
* Powershell script will start the VcxSrv X window server if it is not running
* Launches into the WSL starting terminator using the X window server
* lnk file calls this script in a silent way and has an icon for use as shortcut
---
### Legacy items
* minttyrc - config for the git bash terminal emulator
* nord-theme - colorscheme safe for mintty
