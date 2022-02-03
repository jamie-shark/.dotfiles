#!/usr/bin/env sh

sudo apt update && sudo apt upgrade -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y
sudo apt update && sudo apt install dbus-x11 terminator -y
ln -fs /mnt/c/Users/Jamie/Downloads/ ~/
ln -fs /mnt/c/Users/Jamie/Documents/ ~/
ln -fs /mnt/c/Users/Jamie/.ssh/ ~/

. ./setup-backups.sh
