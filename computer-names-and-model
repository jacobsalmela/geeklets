#----------AUTHOR------------
	# Jacob Salmela
	# 3 December 2013

#----------RESOURCES---------
	# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
	# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx
	# http://blog.coriolis.ch/2011/08/01/get-your-apple-device-model-name-in-a-readable-format/
	# 

#---------DESCRIPTION--------
	# Displays the computers hardware model number
	# Also, displays many of the different computer names

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
	
	# If this variable does not work, change the number eight to a nine
	# It is set up to use the US locale by default
	# Some people said it worked using the last three digits others said it worked with the last
	lastCharsInSerialNum=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-)


#----------FUNCTIONS---------
###############################
getFriendlyModelNameFromApple()
	{
	# Use curl to query Apple's servers while inserting the variable that contains the last characters in the Serial Number into the URL
	# Pipe it into awk and use <configCode> as the new delimiter, printing the second field
	# Pipe it into awk again but use </configCode> as the new delimiter, this time, printing the first field
	# This leaves you with just the computer friendly name
	# Thanks to n0brainer for the idea:
	# https://bitbucket.org/jacob_salmela/geeklets/issue/2/computer-hardware-model-friendly-name
	curl -s http://support-sp.apple.com/sp/product?cc="$lastCharsInSerialNum" | awk -F'<configCode>' '{print $2}' | awk -F'</configCode>' '{print $1}'

	# Return 0 if all is well
	return 0
	}
	

######################
displayComputerNames()
	{
	# Print all four computer names
	echo "Friendly Name:\t\t`getFriendlyModelNameFromApple`"
	echo "Hardware Model:\t\t`sysctl -n hw.model`"
	echo "Computer Name:\t\t`scutil --get ComputerName`"
	echo "Hostname:\t\t`scutil --get HostName`"
	echo "Local Hostname:\t\t`scutil --get LocalHostName`"
	echo "NetBIOS name:\t\t`defaults read /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName`"
	
	# Return 0 if all is well
	return 0
	}
	
#--------------------------------
#--------------------------------
#----------script starts---------
#--------------------------------
#--------------------------------
displayComputerNames
getFriendlyModelNameFromApple
