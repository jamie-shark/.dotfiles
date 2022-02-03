#! /bin/sh

set +ex

sudo apt update
sudo apt install -y \
    libncurses5-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libcairo2-dev \
    python-dev \
    python3-dev \
    git \
    libx11-dev \
    libxt-dev \
    checkinstall
sudo apt remove vim vim-runtime gvim
cd /usr
sudo git clone https://github.com/vim/vim.git
cd vim
sudo ./configure \
    --prefix=/usr/local \
    --with-features=huge \
    --with-x \
    --enable-multibyte \
    --enable-pythoninterp=yes \
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ \
    --enable-python3interp=yes \
    --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/ \
    --enable-gui=gtk2 \
    --enable-cscope
sudo make -j$(nproc) VIMRUNTIMEDIR=/usr/local/share/vim/vim81
sudo checkinstall
vim --version
