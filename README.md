# Jetson Wifi Hotspot
Setup Jetson as a Wifi Hotspot. Useful for connecting to jetson with ssh and vnc without needing a internet connection.

Inspired by tutorial by couka from [here](https://couka.de/2020/10/26/jetson-nano-as-access-point/)

## Install
Install using the provided script:
```
./install.sh
```

## Disable
To turn off the auto run service run the following command:
```
systemctl disable create_ap
```
Then restart the machine.
