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
InstallPkg cmake
InstallPkg libflac-dev
InstallPkg libogg-dev
InstallPkg libvorbis-dev
InstallPkg libopenal-dev
InstallPkg libjpeg62-turbo-dev
InstallPkg libfreetype6-dev
InstallPkg libudev-dev
InstallPkg libavutil-dev
InstallPkg libavcodec-dev
InstallPkg libavformat-dev
InstallPkg libavfilter-dev
InstallPkg libswscale-dev
InstallPkg libavresample-dev
InstallPkg libfontconfig1-dev

cd ~/develop
git clone --depth 1 https://github.com/mickelson/sfml-pi sfml-pi
mkdir sfml-pi/build
cd sfml-pi/build
cmake .. -DSFML_RPI=1 -DEGL_INCLUDE_DIR=/opt/vc/include -DEGL_LIBRARY=/opt/vc/lib/libEGL.so -DGLES_INCLUDE_DIR=/opt/vc/include -DGLES_LIBRARY=/opt/vc/lib/libGLESv1_CM.so
sudo make install
sudo ldconfig

cd ~/develop
git clone --depth 1 https://github.com/mickelson/attract attract
cd attract
make -j3 USE_GLES=1 
sudo make install
