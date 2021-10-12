#!/bin/bash

# exit on command failure
set -e

# get path to this script
SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPT_PATH

# install dependencies
sudo apt install -y libgtk-3-dev build-essential gcc g++ pkg-config make hostapd

# clone wifi hotspot program
git clone https://github.com/lakinduakash/linux-wifi-hotspot

# build & install wifi hotspot program
cd linux-wifi-hotspot
make
sudo make install

cd $SCRIPT_PATH

# disable xserver access control
xhost +

# run on startup
systemctl enable create_ap
