#----------AUTHOR------------
	# Jacob Salmela
	# 23 December 2013

#----------RESOURCES---------
	# http://apple.stackexchange.com/questions/38771/change-network-location-from-terminal

#---------DESCRIPTION--------
	# Changes network locations based on SSID connected to
	# Useful if one location needs a proxy or advanced settings that you don't want to mess with
	
#-----------USAGE------------
	# To run: 
	#
	#		0. Paste the entire script into a geeklet 	 
	#		1. Choose a refresh time that makes sense
	
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
	
	# Current Network Location (for comparisons)
	currentNetLoc=$(networksetup -getcurrentlocation)
	
	# For the following variables, enter the exact network location name desired for each network name
	# Run the command networksetup -listlocations to see the available options
	# I have just three basic ones, but you can add more
	defaultLocation="Automatic"	#<---change the words in quotes (this is your default connection)
	homeLocation="Home"	#<---change the words in quotes
	workLocation="Work"			#<---change the words in quotes
	publicLocation="Public"		#<---change the words in quotes
	
#----------FUNCTIONS---------
#############################################
switchLocationDependingOnNetworkConnectedTo()
#############################################
	{
	# Change the network location depending on what network you are connected to
	case $currentNetwork in
		"Home-Network") networksetup -switchtolocation $homeLocation &> /dev/null;;
		"Work-Network") networksetup -switchtolocation $workLocation &> /dev/null;;
		"Public-Network") networksetup -switchtolocation $publicLocation &> /dev/null;;
		*) networksetup -switchtolocation $defaultLocation &> /dev/null;;
	esac
	
	# Return 0 if all is well\
	}
#---------------------------------#
#---------------------------------#
#-------------SCRIPT--------------#
#---------------------------------#
#---------------------------------#
switchLocationDependingOnNetworkConnectedTo
