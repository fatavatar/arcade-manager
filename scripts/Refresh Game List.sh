#!/bin/bash

isVertical() {
	return `grep -q $1 /mnt/arcade-manager/roms/vgames.txt`
}

(cd /mnt/arcade-manager; git pull)

# Install config files
# For now we assume vertical mode.
sudo cp /mnt/arcade-manager/config/all/retroarch.cfg.v /mnt/retropie/configs/all/retroarch.cfg
sudo cp /mnt/arcade-manager/config/mame-libretro/retroarch.cfg.v /mnt/retropie/configs/mame-libretro/retroarch.cfg
sudo cp /mnt/arcade-manager/config/nes/retroarch.cfg.v /mnt/retropie/configs/nes/retroarch.cfg
sudo cp /mnt	/arcade-manager/config/atari2600/retroarch.cfg.v /mnt/retropie/configs/atari2600/retroarch.cfg

# Default configs for new games
cp /mnt/arcade-manager/config/mame-libretro/horizontal.cfg.v /mnt/RetroPie/roms/mame-libretro/horizontal.cfg
cp /mnt/arcade-manager/config/mame-libretro/vertical.cfg.v /mnt/RetroPie/roms/mame-libretro/vertical.cfg

# Helper Scripts
for script in ES-Start autostart AM-Start
do
	sudo cp /mnt/arcade-manager/scripts/${script}.sh /mnt/retropie/configs/all
done
cp "/mnt/arcade-manager/scripts/Switch To Attract Mode.sh" /mnt/RetroPie/retropiemenu/

# Install per game config files
shopt -s nullglob

for rom in /mnt/retropie/roms/mame-libretro/*.zip; do
	echo Configuring $(basename $rom)
	if [ -f /mnt/arcade-manager/config/mame-libretro/$(basename $rom).cfg ]; then
		cp /mnt/arcade-manager/config/mame-libretro/$(basename $rom).cfg /mnt/retropie/roms/mame-libretro/
	else if isVertical $(basename $rom); then
		ln -sf /mnt/arcade-manager/config/mame-libretro/vertical.cfg ${rom}.cfg
	else
		ln -sf /mnt/arcade-manager/config/mame-libretro/horizontal.cfg ${rom}.cfg
	fi
done

#Copy in all overlays
sudo mkdir -p /mnt/retropie/emulators/retroarch/overlays/arcade-bezel-overlays
sudo cp -r /mnt/arcade-manager/overlays/* /mnt/retropie/emulators/retroarch/overlays/arcade-bezel-overlays/
sudo mkdir -p /mnt/retropie/emulators/retroarch/shader/arcade-bezel-shader
sudo cp -r /mnt/arcade-manager/shader/* /mnt/retropie/emulators/retroarch/shader/arcade-bezel-shader/


# Refresh rom listing
EMULATORS=(`ls  /mnt/roms`)
attract -c /mnt/attract -b "${EMULATORS[@]}" -o multi
attract -c /mnt/attract -s "${EMULATORS[@]}"




