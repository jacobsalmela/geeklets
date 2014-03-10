#----------AUTHOR------------
	# Jacob Salmela
	# 3 December 2013

#----------RESOURCES---------
	# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
	# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx

#---------DESCRIPTION--------
	# Shows the current SSID that the computer is connected to
	# Shows the current IP for both wired and wireless interfaces
	#
	# This is most useful in an enterprise environment because you can set the desired wireless network
	# The desired network will show up in green text (meaning it is good)
	# If it connects to a different network (such as a guest network) the text will turn red
	#
	# In addition, if there is no ethernet cable plugged in, the text will turn red

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
	
	# Uses the airport command line utility to get the current SSID
	# Use airport to list the information |
	# awk using the field separator of SSID: and print the second field
	currentNetwork=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | awk -F: '/ SSID: / {print $2}' | sed -e 's/SSID: //' | sed -e 's/ //')
	
	# Set your desired network name here.  This is the network that will show in green text
	# If the current network does not match this, it will show as red text
	desiredNetwork="Hopkins-Net"
	
	# Determine if the interface is called Wi-Fi or Airport
	# grep using case insensitivity and extended regex for the words Wi-Fi or Airport
	wifiOrAirport=$(/usr/sbin/networksetup -listallnetworkservices | grep -Ei '(Wi-Fi|AirPort)')

	# Determine what the wireless device interface number is
	# awk out Wi-Fi or Airport name and the word Device |
	# awk only two lines |
	# cut using whitespace as the delimiter, printing the second field
	wirelessDevice=$(/usr/sbin/networksetup -listallhardwareports | awk "/$wifiOrAirport/,/Device/" | awk 'NR==2' | cut -d " " -f 2)
	
	# Determine what the wired device interface number is
	# grep one line following a match to the word Port: Ethernet |
	# sed silently, search for Device | 
	# awk the second field only
	wiredDevice=$(networksetup -listallhardwareports | grep -A 1 "Port: Ethernet" | sed -n 's/Device/&/p' | awk '{print $2}')


#----------FUNCTIONS---------
#################################
getWirelesstNetworkAndDisplayIp()
	{
	# If the current network does not equal the desired network, then
	if [ "$currentNetwork" != "$desiredNetwork" ];then
		# echo the current networks SSID in red text
		echo "\t❗ Network SSID\t\t\t${red}$currentNetwork${end}\n"
		# Also echo the curent IP in red text
		echo "\t❗ Wireless IP\t\t\t${red}$wirelessDevice${end}\n"
	
	# Otherwise, if the current network does match the desired network, then
	else
		# echo the current network in green text
        echo "\t✅ Network SSID\t\t\t${green}$currentNetwork${end}\n"
        # Also echo the current IP in green text
		echo "\t✅ Wireless IP\t\t\t${green}$wirelessDevice${end}\n"
		
	# Close the if statement
	fi
	
	# Return 0 if all is well
	return 0
	}

###################
displayEthernetIp()
	{
	# If the Ethernet adapter is not equal to a null value (no IP address), then
	if [ "$en0" != "" ];then
		# 
        echo "\t✅ Ethernet IP\t\t\t${green}$wiredDevice${end}	"
    # Otherwise
	else
		# echo that the ethernet port is inactive (in red text)
        echo "\t🔴 Ethernet IP\t\t\t${red}INACTIVE${end}"
        
    # Close the if statement
	fi

	# Return 0 if all is well
	return 0
	}
	
#--------------------------------
#--------------------------------
#----------script starts---------
#--------------------------------
#--------------------------------
echo "${bold}NETWORK${end}\n"
getWirelesstNetworkAndDisplayIp
displayEthernetIp
