# WiFi Jammer Script
A simple Bash script to jam the specified AP and disconnects every client connected to that AP. If you wanna try manually rather then script head to my another repo [wifi-jammer](https://github.com/mtm-x/wifi-jammer).
This bash script will basically send deauth packets to the target AP

# Working
### Deauthentication Attack
A deauth attack sends forged deauthentication packets from your machine to a client connected to the network you are trying to jam. These packets include fake "sender" addresses that make them appear to the client as if they were sent from the access point themselves. Upon receipt of such packets, most clients disconnect from the network and immediately reconnect.




# Installation

1. Clone this repo

  ```
  git clone https://github.com/mtm-x/wifi-jammer-script
  ```
2. change directory to the cloned repo

  ```
  cd wifi-jammer-script
   ```
3.Now set executable permission for wifijammer.sh

  ```
  chmod +x wifijammer.sh  
  ```
4. Now execute with root permission

```
  sudo ./wifijammer.sh
```

 

Educational purpose only
