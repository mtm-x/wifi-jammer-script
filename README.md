# WiFi Jammer Script
A simple Bash script to jam the specified AP and disconnects every client connected to that AP. If you wanna try manually rather then script head to my another repo [wifi-jammer](https://github.com/mtm-x/wifi-jammer).
This bash script will basically send deauth packets to the target AP

# Working
### Deauthentication Attack
A deauth attack sends forged deauthentication packets from your machine to a client connected to the network you are trying to jam. These packets include fake "sender" addresses that make them appear to the client as if they were sent from the access point themselves. Upon receipt of such packets, most clients disconnect from the network and immediately reconnect.




# Installation
1.Install [Aircrack-ng](https://github.com/aircrack-ng/aircrack-ng)
  ```
  sudo apt install aircrack-ng
  ```
2. Clone this repo

  ```
  git clone https://github.com/mtm-x/wifi-jammer-script
  ```
3. change directory to the cloned repo

  ```
  cd wifi-jammer-script
   ```
4.Now set executable permission for wifijammer.sh

  ```
  chmod +x wifijammer.sh  
  ```
5. Now execute with root permission

```
  sudo ./wifijammer.sh
```
6. To restore previous interface configuration (to put your wifi card back to managed mode )

   ```
   iwconfig
   ```
   Note down your current wifi interface name because when you put your wifi card in monitor mode the interface name will change . In my case my interface name in monitor mode is `wlan0mon` so im using that

 
   ```
   sudo airmon-ng stop wlan0mon
   ```
 
# Note 
1. While using the script use small y for yes and n for no
2. This script will automatically put your wifi interface in monitor mode . So dont do that manually
3. Educational purpose only
