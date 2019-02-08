cp "$HOME/arcade-manager/scripts/Disable 2nd Player Screen.sh" "$HOME/.attract/Attract Mode Setup/"
rm -rf "$HOME/.attract/Attract Mode Setup/Enable 2nd Player Screen.sh"
attract -b "Attract Mode Setup" -o "Attract Mode Setup"

sudo cp $HOME/arcade-manager/config/nes/retroarch.cfg.two /opt/retropie/configs/nes/retroarch.cfg
sudo cp $HOME/arcade-manager/config/atari2600/retroarch.cfg.two /opt/retropie/configs/atari2600/retroarch.cfg

