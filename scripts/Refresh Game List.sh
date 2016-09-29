#!/bin/bash


# Grab the latest emulator stuff
rsync -e "/usr/bin/ssh" -av fatavatar@thelucks.org:arcade.thelucks.org/roms/ $HOME/RetroPie/roms

(cd ~/arcade-manager; git pull)

EMU_FOLDER=("nes" "mame-libretro")

# Install config files
# For now we assume vertical mode.
sudo cp ../config/all/retroarch.cfg.v /opt/retropie/configs/all/retroarch.cfg
sudo cp ../config/mame-libretro/retroarch.cfg.v /opt/retropie/configs/mame-libretro/retroarch.cfg
sudo cp ../config/nes/retroarch.cfg.v /opt/retropie/configs/nes/retroarch.cfg

# Default configs for new games
cp ../config/mame-libretro/horizontal.cfg.v $HOME/RetroPie/roms/mame-libretro/horizontal.cfg
cp ../config/mame-libretro/vertical.cfg.v $HOME/RetroPie/roms/mame-libretro/vertical.cfg

# Install per game config files
shopt -s nullglob

for rom in $HOME/RetroPie/roms/mame-libretro/*.zip
do
	echo Configuring $(basename $rom)
	if [ -f ../config/mame-libretro/$(basename $rom).cfg ]; then
		cp ../config/mame-libretro/$(basename $rom).cfg $HOME/RetroPie/roms/mame-libretro/
	else if isVertical $rom; then
		ln -sf vertical.cfg ${rom}.cfg
	else
		ln -sf horizontal.cfg ${rom}.cfg
	fi
fi

#Copy in all overlays
sudo mkdir -p /opt/retropie/emulators/retroarch/overlays/arcade-bezel-overlays
sudo cp -r ../overlays/* /opt/retropie/emulators/retroarch/overlays/arcade-bezel-overlays/
sudo mkdir -p /opt/retropie/emulators/retroarch/shader/arcade-bezel-shader
sudo cp -r ../shader/* /opt/retropie/emulators/retroarch/shader/arcade-bezel-shader/

	
done

# Refresh rom listing
EMULATORS=("Nintendo NES" "MAME (Libretro)")
attract -b "${EMULATORS[@]}" -o multi
attract -s "${EMULATORS[@]}"




