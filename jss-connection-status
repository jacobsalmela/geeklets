#----------AUTHOR------------
	# Jacob Salmela
	# 3 December 2013

#----------RESOURCES---------
	# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
	# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx

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
##########################
checkJssConnection()
##########################
	{
	# Check the connection to the JSS only once (never retry) and send any messages into a black hole (we don't need to see them)
	jamf checkJSSConnection -retry 0 &>/dev/null
	
	# Thankfully, JAMF engineers were smart and documented that if the command above is successful, it returns a zero
	# This allows us to use the if statement below
	
	# If the last command completed successfully
	if [ $? = 0 ];then
		
		# Then create a variable that runs the command again, but 
		jssConnection=$(jamf checkJSSConnection -retry 0 | grep "available")
		
		# Echo the status in green text
		echo "\t✅ Status\t\t\t\t\t${green}$jssConnection${end}"
	
	# Otherwise, do the same thing as above, but in red text (to indicate a problem)
	else
	
		jssConnection=$(jamf checkJSSConnection -retry 0 | grep "Could not connect")
		echo "\t🔴 Status\t\t\t\t${red}$jssConnection${end}"
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
# Title of the information in bold	
echo "${bold}JSS${end}"
checkJssConnection
