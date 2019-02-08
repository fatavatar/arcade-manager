#!/bin/bash

apt-get -y install busybox-syslogd
dpkg --purge rsyslog || true

sed -i 's/$/ fastboot noswap ro/' /boot/cmdline.txt
rm -rf /var/lib/dhcp/ /var/lib/dhcpcd5 /var/run /var/spool /var/lock /etc/resolv.conf
ln -s /tmp /var/lib/dhcp
ln -s /tmp /var/lib/dhcpcd5
ln -s /tmp /var/run
ln -s /tmp /var/spool
ln -s /tmp /var/lock
touch /tmp/dhcpcd.resolv.conf; ln -s /tmp/dhcpcd.resolv.conf /etc/resolv.conf

sed -i 's/=\/run/=\/var\/run/g' /etc/systemd/system/dhcpd5
rm /var/lib/systemd/random-seed
ln -s /tmp/random-seed /var/lib/systemd/random-seed

sed -i '/ExecStart=/ i ExecStartPre=\/bin\/echo "" >\/tmp\/random-seed' /lib/systemd/system/systemd-random-seed.service

systemctl daemon-reload
insserv -r bootlogs
insserv -r console-setup

mv /etc/fstab /etc/fstab.old
cp newfstab /etc/fstab
