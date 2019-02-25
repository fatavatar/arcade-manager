#!/bin/bash
# Run as sudo!
cp init.d/S25waitforusb.sh /etc/init.d/waitforusb
ln -s /etc/init.d/waitforusb /etc/rcS.d/S25waitforusb

# Add USB to fstab
sed -i '/^\/dev\/sda1/d' /etc/fstab
echo '/dev/sda1\t/mnt\tvfat\tnoatime,users,rw,uid=pi,gid=pi\t0\t0' >> /etc/fstab

mount /dev/sda1
if [ ! -d /mnt/retropie/configs ]; then
  mkdir -p /mnt/retropie
  cp -r /opt/retropie/configs /mnt/retropie
fi
rm -rf /opt/retropie/configs
mkdir -p /mnt/retropie/configs/all/retroarch-joypads
ln -s /mnt/retropie/configs /opt/retropie/configs

cd /mnt/retropie/

git init
git config --global user.email pi@raspberry
git config --global user.name pi
git add configs
git commit -m "Initial config settings"

mkdir -p /mnt/attract/