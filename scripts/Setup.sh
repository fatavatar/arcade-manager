#!/bin/bash

cd ~
git clone  https://github.com/fatavatar/arcade-manager.git
cd arcade-manager/scripts

(./MakeAM.sh)
(./SetupUSB.sh)

cd ~/
mv arcade-manager /mnt/arcade-manager

echo "Starting up Attract Mode in 10 seconds - Please set your language and exit."

sleep 10
attract -c /mnt/attract/

echo "Starting up Emulation Station in 10 seconds - Please setup your controllers"
emulationstation

cd /mnt/arcade-manager/scripts
"./Backup Config.sh"

# mkdir -p "/mnt/attract/Attract Mode Setup"
# cp "Backup Config.sh" "/mnt/attract/Attract Mode Setup/"
# cp "Enable 2nd Player Screen.sh" "/mnt/attract/Attract Mode Setup/"
# attract -c /mnt/attract -b "Attract Mode Setup" -o "Attract Mode Setup"


