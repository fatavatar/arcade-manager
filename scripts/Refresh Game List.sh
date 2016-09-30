#!/bin/bash

isVertical() {
	exit 0
}

# Grab the latest emulator stuff
rsync -e "/usr/bin/ssh" -av fatavatar@thelucks.org:arcade.thelucks.org/roms/ $HOME/RetroPie/roms

(cd ~/arcade-manager; git pull)

EMU_FOLDER=("nes" "mame-libretro")

# Install config files
# For now we assume vertical mode.
sudo cp $HOME/arcade-manager/config/all/retroarch.cfg.v /opt/retropie/configs/all/retroarch.cfg
sudo cp $HOME/arcade-manager/config/mame-libretro/retroarch.cfg.v /opt/retropie/configs/mame-libretro/retroarch.cfg
sudo cp $HOME/arcade-manager/config/nes/retroarch.cfg.v /opt/retropie/configs/nes/retroarch.cfg

# Default configs for new games
cp $HOME/arcade-manager/config/mame-libretro/horizontal.cfg.v $HOME/RetroPie/roms/mame-libretro/horizontal.cfg
cp $HOME/arcade-manager/config/mame-libretro/vertical.cfg.v $HOME/RetroPie/roms/mame-libretro/vertical.cfg

# Helper Scripts
for script in ES-Start autostart AM-Start
do
	sudo cp $HOME/arcade-manager/scripts/${script}.sh /opt/retropie/configs/all
done
cp "$HOME/arcade-manager/scripts/Switch To Attract Mode.sh" $HOME/RetroPie/retropiemenu/

# Install per game config files
shopt -s nullglob

for rom in $HOME/RetroPie/roms/mame-libretro/*.zip
do
	echo Configuring $(basename $rom)
	if [ -f $HOME/arcade-manager/config/mame-libretro/$(basename $rom).cfg ]; then
		cp ../config/mame-libretro/$(basename $rom).cfg $HOME/RetroPie/roms/mame-libretro/
	else if isVertical $rom; then
		ln -sf vertical.cfg ${rom}.cfg
	else
		ln -sf horizontal.cfg ${rom}.cfg
	fi
fi

#Copy in all overlays
sudo mkdir -p /opt/retropie/emulators/retroarch/overlays/arcade-bezel-overlays
sudo cp -r $HOME/arcade-manager/overlays/* /opt/retropie/emulators/retroarch/overlays/arcade-bezel-overlays/
sudo mkdir -p /opt/retropie/emulators/retroarch/shader/arcade-bezel-shader
sudo cp -r $HOME/arcade-manager/shader/* /opt/retropie/emulators/retroarch/shader/arcade-bezel-shader/

	
done

# Refresh rom listing
EMULATORS=("Nintendo NES" "MAME (Libretro)")
attract -b "${EMULATORS[@]}" -o multi
attract -s "${EMULATORS[@]}"

cp "$HOME/arcade-manager/scripts/Refresh Game List.sh" "$HOME/.attract/Attract Mode Setup/"



