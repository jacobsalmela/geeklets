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

#----------VARIABLES---------
# Colors
end="\x1b[0m"
bold="\x1b[001m"
underscore="\x1b[004m"
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"
	
#----------FUNCTIONS---------
checkForDisabledPrinters()
##########################
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
	}

checkForIdlePrinters()
######################
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
	}

#-----------SCRIPT--------------
echo "${bold}PRINTERS${end}\n"
checkForDisabledPrinters
checkForIdlePrinters
