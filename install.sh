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

# create wifi hotspot
sudo create_ap wlan0 eth0 '$ssid' '$pass' --freq-band 2.4 --no-virt -w 2

# copy files to known directory for use in crontab
sudo mkdir /usr/local/bin/jetson_hotspot
sudo cp hotspot.config /usr/local/bin/jetson_hotspot/hotspot.config
sudo cp startup_hotspot.py /usr/local/bin/jetson_hotspot/startup_hotspot.py
# copy crontab config to crontab directory to auto start hotspot on boot
sudo cp jetson_hotspot_crontab /etc/cron.d/jetson_hotspot_crontab