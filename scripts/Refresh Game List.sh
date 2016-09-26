#!/bin/bash


# Grab the latest emulator stuff
rsync -e "/usr/bin/ssh" -av fatavatar@thelucks.org:arcade.thelucks.org/roms $HOME/RetroPie/

(cd ~/arcade-manager; git pull)

bash ~/arcade-manager/scripts/update-configs.sh

EMULATORS=("Nintendo NES" "MAME (Libretro)")

attract -b "${EMULATORS[@]}" -o multi

attract -s "${EMULATORS[@]}"


