#----------AUTHOR------------
# Jacob Salmela
# 3 December 2013

#----------RESOURCES---------
# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx

# Colors
end="\x1b[0m"	
bold="\x1b[001m"
underscore="\x1b[004m"	
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"

# Uses the airport command line utility to get the current SSID
currentNetwork=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | awk -F: '/ SSID: / {print $2}' | sed -e 's/SSID: //' | sed -e 's/ //')
	
# If the current network does not match this, it will show as red text
desiredNetwork="Desired-SSID-Here"

wifiOrAirport=$(/usr/sbin/networksetup -listallnetworkservices | grep -Ei '(Wi-Fi|AirPort)')
wirelessDevice=$(/usr/sbin/networksetup -listallhardwareports | awk "/$wifiOrAirport/,/Device/" | awk 'NR==2' | cut -d " " -f 2)
wirelessIP=$(ipconfig getifaddr $wirelessDevice)
wiredDevice=$(networksetup -listallhardwareports | grep -A 1 "Port: Ethernet" | sed -n 's/Device/&/p' | awk '{print $2}')
wiredIP=$(ipconfig getifaddr $wiredDevice)

#----------FUNCTIONS---------
getWirelesstNetworkAndDisplayIp()
#################################
	{
	# If the current network does not equal the desired network, then
	if [ "$currentNetwork" != "$desiredNetwork" ];then
		echo "\t❗ Network SSID\t\t${red}$currentNetwork${end}"
		echo "\t❗ Wireless IP\t\t\t${red}$wirelessIP${end}"
	else
        echo "\t✅ Network SSID\t\t${green}$currentNetwork${end}"
		echo "\t✅ Wireless IP\t\t\t${green}$wirelessIP${end}"
	fi
	}


displayEthernetIp()
###################
	{
	# If the Ethernet adapter is not equal to a null value (no IP address), then
	if [ -z "$en0" ];then
        echo "\t✅ Ethernet IP\t\t\t${green}$wiredIP${end}"
	else
        echo "\t🔴 Ethernet IP\t\t\t${red}INACTIVE${end}"
	fi

	}
	
#--------------------------------
#----------BEGIN SCRIPT----------
#--------------------------------
echo "${bold}NETWORK${end}"
getWirelesstNetworkAndDisplayIp
displayEthernetIp
