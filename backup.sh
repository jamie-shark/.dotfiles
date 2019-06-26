#!/usr/bin/env sh
# This script makes a backup of the home directories and list of installed packages every day

cd /root
dpkg --get-selections | grep -v deinstall >> /root/packages.txt
tar cjf /tmp/WSLbackup.tar.gz /root/ /home/
cp -f /tmp/WSLbackup.tar.gz /mnt/c/backups/WSLbackup.tar.gz
rm /tmp/WSLbackup.tar.gz

touch /var/log/backup_success
