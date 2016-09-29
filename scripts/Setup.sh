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
if [ ! -d sfml-pi ]; then
	git clone --depth 1 https://github.com/mickelson/sfml-pi sfml-pi
	mkdir sfml-pi/build
	cd sfml-pi/build
	cmake .. -DSFML_RPI=1 -DEGL_INCLUDE_DIR=/opt/vc/include -DEGL_LIBRARY=/opt/vc/lib/libEGL.so -DGLES_INCLUDE_DIR=/opt/vc/include -DGLES_LIBRARY=/opt/vc/lib/libGLESv1_CM.so
	sudo make install
	sudo ldconfig
fi

cd ~/develop
if [ ! -d attract ]; then 
	git clone --depth 1 https://github.com/mickelson/attract attract
	cd attract
	make -j3 USE_GLES=1 
	sudo make install
fi

#Setup SSH keys
if [ ! -f $HOME/.ssh/id_rsa.pub ]; then
	mkdir -p $HOME/.ssh
	ssh-keygen -t rsa -b 4096 -N "" -f $HOME/.ssh/id_rsa 
	scp $HOME/.ssh/id_rsa.pub fatavatar@thelucks.org:~/tmp.pub
	echo "cat ~/tmp.pub >>  ~/.ssh/authorized_keys" | ssh fatavatar@thelucks.org /bin/bash
fi

#Perform the initial sync of data
. Refresh\ Game\ List.sh
