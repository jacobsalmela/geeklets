#----------AUTHOR------------
	# Jacob Salmela
	# 12 December 2013

#----------RESOURCES---------
	# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
	# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx
	# http://osxdaily.com/2012/12/21/list-wi-fi-networks-mac-has-connected-to-before/

#---------DESCRIPTION--------


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
	

#----------FUNCTIONS---------
#############################################
listPreferredNetworksAndLastConnectionTimes()
	{
	# Use defaults to read the RememberedNetworks key from the airport plist |
	# awk out only the SSID and LastConnected entries |
	# Use sed to search for quotes and semi-colons and remove them
	defaults read /Library/Preferences/SystemConfiguration/com.apple.airport.preferences RememberedNetworks | awk '/SSID_STR|LastConnected/ {print $3, $4}' | sed 's/[";]//g'
	
	# Return 0 if all is well
	return 0
	}


#--------------------------------
#--------------------------------
#----------script starts---------
#--------------------------------
#--------------------------------
# Title of the information in bold	
listPreferredNetworksAndLastConnectionTimes
