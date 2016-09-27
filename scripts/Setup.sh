#!/bin/bash

cd ~
mkdir -p develop

InstallPkg() {
	if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
		sudo apt-get -y install $1;
	fi
}

#sudo apt-get update
InstallPkg build-essential 
InstallPkg pkg-config 
InstallPkg git 
InstallPkg libfontconfig1-dev 
InstallPkg libopenal-dev 
InstallPkg libsfml-dev 
InstallPkg libavutil-dev 
InstallPkg libavcodec-dev 
InstallPkg libavformat-dev 
InstallPkg libavfilter-dev 
InstallPkg libswscale-dev 
InstallPkg libavresample-dev 
InstallPkg libjpeg-dev 
InstallPkg libglu1-mesa-dev 

cd ~/develop
git clone --depth 1 https://github.com/mickelson/attract attract
cd attract
make -j 3
sudo make install
