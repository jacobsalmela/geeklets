#----------AUTHOR------------
	# Jacob Salmela
	# 3 December 2013

#----------RESOURCES---------
	# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
	# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx

#---------DESCRIPTION--------
	# When used as a geeklet, it shows the current status of all printers
	# If paused, they show up in red
	# If idle, they show up in green
	# 
	# If the special characters (red and green status icons) do not appear, you may need to adjust the file encoding to UTF8
 	# You can also drag and drop other emoji from the OS X Character Viewer, but the ones I have here work well
 	
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
checkForDisabledPrinters()
	{
	# Print status of all printers and search for the word disabled, printing only that word
	lpstat -p | grep -o "disabled" > /dev/null
	
		# If the last command completed successfully (a return status of 0, meaning it found disabled printers), then
		if [ $? = 0 ];then
	
			# for each disabled printer in the command to find disabled printers
			for disabled in "$(lpstat -p | grep "disabled")"
			
			# do this: echo each disabled printers name and status in red text (because it is disabled)
			do
			    # If the special character (red dot) above does not appear, you may need to adjust the file encoding to UTF8
		        # You can also drag and drop other emoji from the OS X Character Viewer, but the red dot matches and works well
		        # The "\t" character are tabs for better spacing and readability
		        echo "$disabled" | awk '{print "\t\t🔴 " $2, "\t\t\t""'${red}'"$3"'${end}'"}'\n
	
		    # Once all disabled printers have been echoed, be done
			done
	
			# Close the if statement
			fi
	
	# Return 0 if everything went OK
	return 0
	}

######################
checkForIdlePrinters()
	{
	# Print status of all printers and search for the word idle
	lpstat -p | grep -o "idle" > /dev/null
	
		# If the last command completed successfully (a return status of 0, meaning it found idle printers), then
		if [ $? = 0 ];then
			
			# for each idle printer in the command to find idle printers
			for idle in "$(lpstat -p | grep "idle")"
			
			# do this: echo each idle printers name and status in green text (because it is working)
			do
	    	    echo "$idle" | awk '{print "\t\t✅ " $2, "\t\t\t""'${green}'"$4"'${end}'"}'\n
	    	    
	   	 	# Once all disabled printers have been echoed, be done
			done
			
		# Close the if statement
		fi
	
	# Return 0 if everything went OK
	return 0
	}

#--------------------------------
#--------------------------------
#----------script starts---------
#--------------------------------
#--------------------------------

# Title of the information in bold
echo "${bold}PRINTERS${end}\n"

checkForDisabledPrinters
checkForIdlePrinters
