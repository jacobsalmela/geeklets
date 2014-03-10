#----------AUTHOR------------
	# Jacob Salmela
	# 3 December 2013
	# https://github.com/jakesalmela/

#----------RESOURCES---------
	# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
	# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx

#---------DESCRIPTION--------
	# Shows all of the system configuration profiles that are installed
	# Great for quickly referencing that the computer has all the correct ones

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
	
	# This variable stores just the number of how many are installed
	# If zero, this shows up as "no"
	howManyProfiles=$(profiles -C | awk '/installed/ {print $3}')

#----------FUNCTIONS---------
##########################
displayInstalledProfiles()
	{
	# If the number of profiles is "no profiles installed," then
	if [ $howManyProfiles != "no" ];then
		# List the amount profiles that are "installed"
		profilesStatus=$(profiles -C | awk /installed/)
		# Echo this variable; it should read: "There are x system configuration profiles installed"
		echo "\t✅ $profilesStatus"
		# Display the installed system profiles verbosely |
		# awk out just the profile names and print just the name and any remaining fields (to accommodate for whitepsace)
		# finally, sort the results alphabetically (for readability)
		profiles -Cvv | awk '/attribute\:\ name/ {print "\t\t➡ " substr ($0, index ($0,$4))}' | sort
	#otherwise
	else
		# Just run the command to display the amount of installed profiles
		# If none, it will just read, "There are no system configuration profiles installed."
		profiles -C | awk '/installed/'
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
echo "${bold}PROFILES${end}"

displayInstalledProfiles
