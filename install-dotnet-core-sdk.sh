#!/usr/bin/env sh
version=$(lsb_release -rs)
wget -q https://packages.microsoft.com/config/ubuntu/${version}/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo add-apt-repository universe\
sudo apt install apt-transport-https\
sudo apt update\
sudo apt install dotnet-sdk-2.2
