#!/usr/bin/env sh

mkdir /mnt/c/backups
sudo cp ./backup.sh /root/
sudo cp ./backup-job /etc/cron.daily/
echo 'systemctl start cron' | sudo tee -a /root/.bashrc
