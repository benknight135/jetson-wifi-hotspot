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

# create wifi hotspot
sudo create_ap wlan0 eth0 $ssid $pass --freq-band 2.4
