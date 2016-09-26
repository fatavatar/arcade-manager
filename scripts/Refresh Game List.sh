#!/bin/bash


# Grab the latest emulator stuff
rsync -e "/usr/bin/ssh" -av fatavatar@thelucks.org:arcade.thelucks.org/roms $HOME/RetroPie/

(cd ~/arcade-manager; git pull)

EMU_FOLDER=("nes" "mame-libretro")

for emu in "$(EMU_FODLER[$@])" 
do
	for rom in $(ls $HOME/RetroPie/roms/$emu)
	do
		echo $rom
	done
done

EMULATORS=("Nintendo NES" "MAME (Libretro)")

attract -b "${EMULATORS[@]}" -o multi

attract -s "${EMULATORS[@]}"


