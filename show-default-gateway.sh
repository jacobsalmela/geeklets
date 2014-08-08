#----------AUTHOR------------
# Jacob Salmela
# 12 December 2013

#----------RESOURCES---------
# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx
# http://osxdaily.com/2012/03/23/get-router-ip-address-command-line/
# http://www.staff.science.uu.nl/~oostr102/docs/nawk/nawk_49.html
# http://www.thegeekstuff.com/2011/10/grep-or-and-not-operators/

#---------DESCRIPTION--------
# Shows the wireless and wired default gateways (router of the network currently connected to)
# The wireless and wired adapters are automatically detected
# This should work for most systems, but if you have multiple NICS or a different setup, it might have trouble

#----------VARIABLES---------
# Colors
end="\x1b[0m"
bold="\x1b[001m"
underscore="\x1b[004m"
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"
	
wifiOrAirport=$(/usr/sbin/networksetup -listallnetworkservices | grep -Ei '(Wi-Fi|AirPort)')
wirelessDevice=$(/usr/sbin/networksetup -listallhardwareports | awk "/$wifiOrAirport/,/Device/" | awk 'NR==2' | cut -d " " -f 2)
wiredDevice=$(networksetup -listallhardwareports | grep -A 1 "Port: Ethernet" | sed -n 's/Device/&/p' | awk '{print $2}')

#----------FUNCTIONS---------
function listWirelessGateway()
##############################
	{
	# Use netstat to list the network connections with routing tables (-r) and using numbers (-n) instead of names |
	# awk out a line that contains both "default" and the wireless adapter identifier (declared as a variable above)
	# and print out only the IP address (the second field)
	# Store this in a variable to be echoed back later
	wirelessGateway=$(netstat -rn | grep default | grep $wirelessDevice | awk '{print $2}')
	
	echo "Default gateway for $wirelessDevice (wireless)\t\t$wirelessGateway"
	
	}
	
function listWiredGateway()
###########################
	{
	wiredGateway=$(netstat -rn | grep default | grep $wiredDevice | awk '{print $2}')
	
	echo "Default gateway for $wiredDevice (wired)\t\t\t$wiredGateway"
	}


#----------SCRIPT------------
listWirelessGateway
listWiredGateway