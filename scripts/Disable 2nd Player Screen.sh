cp "$HOME/arcade-manager/scripts/Enable 2nd Player Screen" "$HOME/.attract/Attract Mode Setup/"
rm -rf "$HOME/.attract/Attract Mode Setup/Disable 2nd Player Screen"
attract -b "Attract Mode Setup" -o "Attract Mode Setup"

sudo cp $HOME/arcade-manager/config/nes/retroarch.cfg.v /opt/retropie/configs/nes/retroarch.cfg
sudo cp $HOME/arcade-manager/config/nes/retroarch.cfg.v /opt/retropie/configs/atari2600/retroarch.cfg

