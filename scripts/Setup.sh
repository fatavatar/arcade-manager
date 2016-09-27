#!/bin/bash

cd ~
mkdir -p develop

sudo apt-get update
sudo apt-get -y install cmake
sudo apt-get -y install libflac-dev
sudo apt-get -y install libogg-dev
sudo apt-get -y install libvorbis-dev
sudo apt-get -y install libopenal-dev
#sudo apt-get -y install libjpeg8-dev
sudo apt-get -y install libfreetype6-dev
sudo apt-get -y install libudev-dev
sudo apt-get -y install libavutil-dev
sudo apt-get -y install libavcodec-dev
sudo apt-get -y install libavformat-dev
sudo apt-get -y install libavfilter-dev
sudo apt-get -y install libswscale-dev
sudo apt-get -y install libavresample-dev
sudo apt-get -y install libfontconfig1-dev
sudo apt-get -y install vim

cd develop
git clone --depth 1 https://github.com/mickelson/sfml-pi sfml-pi
mkdir smfl-pi/build
cd sfml-pi/build
cmake .. -DSFML_RPI=1 -DEGL_INCLUDE_DIR=/opt/vc/include -DEGL_LIBRARY=/opt/vc/lib/libEGL.so -DGLES_INCLUDE_DIR=/opt/vc/include -DGLES_LIBRARY=/opt/vc/lib/libGLESv1_CM.so
sudo make install
sudo ldconfig

cd ~/develop
git clone --depth 1 https://github.com/mickelson/attract attract
cd attract
make
sudo make install
