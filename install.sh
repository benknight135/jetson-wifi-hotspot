#!/bin/bash

# exit on command failure
set -e

# get path to this script
SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPT_PATH

# set option defaults
ssid=${ssid:-JETSON_HOTSPOT}
pass=${pass:-nvidia}

# read options
while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
        # echo $1 $2 // Optional to see the parameter:value result
   fi

  shift
done

# install dependencies
sudo apt install -y libgtk-3-dev build-essential gcc g++ pkg-config make hostapd libqrencode-dev libpng-dev

# clone linux-wifi-hotspot repo
git clone https://github.com/lakinduakash/linux-wifi-hotspot

# build & install linux-wifi-hotspot
cd linux-wifi-hotspot
make
sudo make install

cd $SCRIPT_PATH

# disable xserver access control
xhost +

# run on startup
systemctl enable create_ap

# create wifi hotspot
# (required to run at least once before restart to set config)
sudo create_ap wlan0 eth0 $ssid $pass --freq-band 2.4
