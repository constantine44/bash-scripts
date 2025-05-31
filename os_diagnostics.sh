#!/bin/bash
#Basic system diagnostics in one script.The most important information.


# Color for output
WHITE="\e[0m"
GREEN="\e[32m"


#Greeting
figure(){
echo -e "$GREEN\
	*************************
	-------------------------
	|	   OS		|
	|      Diagnostics	|
	|			|
	-------------------------
	*************************
"
}


#User information
user_info(){
echo -e "$GREEN ---- User Info ---- $WHITE"
echo "Date: $(date)"
echo "User name: $(whoami)"
echo "Host name: $(hostname)"
echo "Distribution and release date: $(lsb_release -dr | awk -F'\t' '{print $2}')"
echo "Kernel: $(uname -a)"
echo "OS works since: $(uptime -s)"
echo "Total operating time of the OS: $(uptime -p)"
echo ""
}


#Checking the connection with DNS
ping_dns(){
ping -c 2 8.8.8.8 > /dev/null 2>&1
if [ $? -eq 0 ]; then
        echo "There is access to the network!"
else
        echo "There is no access to the network!"
fi
}


#Checking the TCP/IP stack
ping_localhost(){
ping -c 2 localhost > /dev/null 2>&1
if [ $? -eq 0 ]; then
        echo "Network stack in localhost is ok!"
else
        echo "Network stack in localhost has problems!"
fi
}


#Network scanning
net_scan(){
echo -e "$GREEN ---- Network Status ---- $WHITE"
echo "Interface and IP: $(ip -4 -o addr show scope global | awk '{print $2, $4}')"
echo "SSH status: $(systemctl status ssh | head -3)"
echo "----"
echo "Network access: $(ping -c 2 8.8.8.8 | tail -3)"
ping_dns
echo "----"
echo "Network stack in localhost: $(ping -c 2 localhost | tail -3)"
ping_localhost
echo ""
}


#Hardware information
hardware_info(){
echo -e "$GREEN ---- Hardware Information ---- $WHITE"
echo -e "CPU's Info: \n $(lscpu | head -6)"
echo "----"
echo -e "RAM and SWAP: \n$(free -hm)"
echo "----"
echo -e "Mass memory: \n$(df -h)"
echo "----"
echo -e "Volumetric processes: \n$(ps -aux --sort=-%mem | head -4)"
echo ""
}


#Information about the current user's directories
dir_user_info(){
echo -e "$GREEN ---- User's directories information ---- $WHITE"
echo "User name: $(whoami)"
echo "User's main directory: $(ls -l /home | grep -v "total")"
echo "----"
echo "The number of directories in the user's home directory: $(ls | wc -l)"
echo "----"
echo "Statistics of the user's home directory: $(stat ~)"
echo ""
}


#Calling all script functions
figure
user_info
net_scan
hardware_info
dir_user_info


