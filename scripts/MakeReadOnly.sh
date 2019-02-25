#!/bin/bash

cd ~
echo Installing all dependencies
apt-get -y install git rsync gawk busybox bindfs

echo Disabling swap
dphys-swapfile swapoff
dphys-swapfile uninstall
update-rc.d dphys-swapfile disable
systemctl disable dphys-swapfile

echo Cloning repository
git clone https://github.com/josepsanzcamp/root-ro.git

echo Doing the setup
rsync -va root-ro/etc/initramfs-tools/* /etc/initramfs-tools/
mkinitramfs -o /boot/initrd.gz
echo initramfs initrd.gz >> /boot/config.txt

echo Restarting RPI
reboot
