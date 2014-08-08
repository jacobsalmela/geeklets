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

#-----------USAGE------------
	# To run:
	# 
	#		0. Paste the entire script into a geeklet 	 
	#		1. Choose a refresh time
	#		2. Adjust the tab spaces to make it look nice
	#			--try using a fixed-width font for best results

#----------VARIABLES---------
	# These variables are to give the text color, which makes the scripts more useful
	# At a glance, you can tell if the system is in good shape (green), has a minor problem (yellow), or needs immediate attention (red)
	# The end variable is required to show where the coloring should end
	# An example would be if you only wanted one word to be color, that word would need to end with the $end variable
	# See more colors and options here:
	# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
	#
	# If the colors are not working, try changing any echo commands to printf. 
	# If you make this change, you will also need to add a \n to the end of the commands so it goes to a newline
	# If you want to use echo, make sure the #!/bin/bash is not the first line and then echos will print the colors just fine
	end="\x1b[0m"
	
	bold="\x1b[001m"
	underscore="\x1b[004m"
	blink="\x1b[005m"
	
	red="\x1b[031m"
	green="\x1b[032m"
	yellow="\x1b[033m"
	blue="\x1b[034m"
	magenta="\x1b[035m"
	cyan="\x1b[036m"
	white="\x1b[037m"
	
	#Determine if the interface is called Wi-Fi or Airport
	wifiOrAirport=$(/usr/sbin/networksetup -listallnetworkservices | grep -Ei '(Wi-Fi|AirPort)')

	#Determine what the wireless device interface number is
	wirelessDevice=$(/usr/sbin/networksetup -listallhardwareports | awk "/$wifiOrAirport/,/Device/" | awk 'NR==2' | cut -d " " -f 2)
	
	#Determine what the wired device interface number is
	wiredDevice=$(networksetup -listallhardwareports | grep -A 1 "Port: Ethernet" | sed -n 's/Device/&/p' | awk '{print $2}')

#----------FUNCTIONS---------
####################
function listWirelessGateway()
	{
	# Use netstat to list the network connections with routing tables (-r) and using numbers (-n) instead of names |
	# awk out a line that contains both "default" and the wireless adapter identifier (declared as a variable above)
	# and print out only the IP address (the second field)
	# Store this in a variable to be echoed back later
	wirelessGateway=$(netstat -rn | grep default | grep $wirelessDevice | awk '{print $2}')
	
	# Echo default gateway
	echo "Default gateway for $wirelessDevice (wireless)\t\t$wirelessGateway"
	
	# Return 0 if all is well
	return 0
	}
	
#################
function listWiredGateway()
	{
	# Use netstat to list the network connections with routing tables (-r) and using numbers (-n) instead of names |
	# awk out a line that contains both "default" and the wireless adapter identifier (declared as a variable above)
	# and print out only the IP address (the second field)
	# Store this in a variable to be echoed back later
	wiredGateway=$(netstat -rn | grep default | grep $wiredDevice | awk '{print $2}')
	
	# Echo default gateway
	echo "Default gateway for $wiredDevice (wired)\t\t\t$wiredGateway"
	
	# Return 0 if all is well
	return 0
	}


#--------------------------------
#--------------------------------
#----------script starts---------
#--------------------------------
#--------------------------------
# Title of the information in bold	
listWirelessGateway
listWiredGateway
