#!/usr/bin/env sh

sudo apt install wget unzip -y

wget http://bosmans.ch/pulseaudio/pulseaudio-1.1.zip
unzip pulseaudio-1.1 -d pulseaudio-1.1
patch -p0 -i pulseaudio-windows-patch.diff
mv pulseaudio-1.1 /mnt/c/
rm pulseaudio-1.1.zip

sudo apt update
sudo apt install build-essential \
                 pkg-config \
                 intltool \
                 libtool \
                 libsndfile1-dev \
                 libjson-c-dev -y

wget https://www.freedesktop.org/software/pulseaudio/releases/pulseaudio-12.2.tar.xz

tar xf pulseaudio-12.2.tar.xz
cd pulseaudio-12.2
patch -p0 -i ../pulseaudio-patch.diff

CFLAGS="$CFLAGS -g -O0" ./configure     \
    --prefix=/usr/local                 \
    --sysconfdir=/etc                   \
    --localstatedir=/var                \
    --disable-bluez4                    \
    --disable-bluez5                    \
    --disable-rpath                     \
    --disable-asyncns                   \
    --disable-udev                      \
    --disable-systemd-daemon            \
    --without-caps                      \
    --enable-force-preopen
make -j 8
sudo apt purge pulseaudio
sudo make install

cd ..
rm -rdf pulseaudio-12.2*

