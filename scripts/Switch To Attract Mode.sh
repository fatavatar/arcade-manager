#!/usr/bin/env bash
echo ""
echo "Switching default boot system to Attract Mode and rebooting"
echo ""
sleep 5
cp /opt/retropie/configs/all/AM-Start.sh /opt/retropie/configs/all/autostart.sh
sudo reboot
