#!/usr/bin/env sh

sudo apt update && sudo apt upgrade -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y
sudo apt update && sudo apt install dbus-x11 terminator -y
ln -fs /mnt/c/Users/jonathan.campbell/Downloads/ ~/
ln -fs /mnt/c/Users/jonathan.campbell/Documents/ ~/
ln -fs /mnt/c/Users/jonathan.campbell/.ssh/ ~/

. ./setup-backups.sh
