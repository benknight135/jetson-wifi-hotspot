import subprocess
import os
import time

# read ssid and password from config file
script_path = os.path.dirname(os.path.abspath(__file__))
config_file = os.path.join(script_path, "hotspot.config")

# read ssid and password from config file
with open(config_file) as f:
    ssid = f.readline().rstrip()
    pswd = f.readline().rstrip()

while True:
    time.sleep(1)
    result = subprocess.run(['lsusb'], stdout=subprocess.PIPE)
    print(result.stdout)

    if ("Realtek RTL8188CUS" in str(result.stdout)):
        time.sleep(3)
        os.system("sudo create_ap wlan0 eth0 '"+ssid+"' '"+pswd+"' --freq-band 2.4")

        break
