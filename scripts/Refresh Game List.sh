#!/bin/bash


# Grab the latest emulator stuff
rsync -e "/usr/bin/ssh" -av fatavatar@thelucks.org:arcade.thelucks.org/roms $HOME/RetroPie/
rsync -e "/usr/bin/ssh" -av fatavatar@thelucks.org:arcade.thelucks.org/layouts $HOME/.attract/

(cd ~/arcade-manager; git pull)

EMU_FOLDER=("nes" "mame-libretro")

shopt -s nullglob

for rom in $HOME/RetroPie/roms/mame-libretro/*.zip
do
	echo $rom
done

EMULATORS=("Nintendo NES" "MAME (Libretro)")

attract -b "${EMULATORS[@]}" -o multi

attract -s "${EMULATORS[@]}"


