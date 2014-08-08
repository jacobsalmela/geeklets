#----------AUTHOR------------
# Jacob Salmela
# 3 December 2013

#----------RESOURCES---------
# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx
# http://osxdaily.com/2010/07/17/why-mac-wakes-from-sleep/

#---------DESCRIPTION--------
# Prints the last restart date and time
# Prints the last shutdown date and time
# Useful when providing tech support

#----------VARIABLES---------
# Colors
end="\x1b[0m"	
bold="\x1b[001m"
underscore="\x1b[004m"	
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"
#----------FUNCTIONS---------
displayLastRebootAndShutdown()
##############################
	{
	# Echo the word last, then run the last command to get a list of events
	# Use grep to search for reboot or shutdown | 
	# Show only the last entry using tail |
	# awk out the third field and everything after it (the date and time)
	# Store this in a variable to be echoed back later
	lastReboot=$(last | grep reboot | head -n 1 | awk '{print substr ($0, index ($0, $3))}')
	lastShutdown=$(last | grep shutdown | head -n 1 | awk '{print substr ($0, index ($0, $3))}')
	
	echo "Last reboot\t\t$lastReboot\t\t$sleepTime"
	echo "Last shutdown\t\t$lastShutdown\t\t$sleepTime"
		
	}
	
displayLastSleepAndWakeTimes()
##############################
	{
	# Uses sysctl to print the sleeptime |
	# awk out only the ninth column of text and everything that precedes it
	# Store all of this in a variable for echoing back later
	sleepTime=$(sysctl -n kern.sleeptime | awk '{print $9, $10, $11, $12}' | cut -d':' -f1 -f2)
	
	# Uses sysctl to print the waketime |
	# awk out only the ninth column of text and everything that precedes it
	# Store all of this in a variable for echoing back later
	wakeTime=$(sysctl -n kern.waketime | awk '{print $9, $10, $11, $12}' | cut -d':' -f1 -f2)
	
	echo "Last sleeptime\t\t$sleepTime"
	echo "Last waketime\t\t$sleepTime"
		
	}

displayWakeReason()
###################
	{
	# Display the system log |
	# grep "Wake reason" (using case insensitivity) |
	# tail only the last entry | 
	# grep but print only the word (-o) 
	# One of these codes will relate to a certain type of wake event
	# Store this information in a variable, which will be evaluated in the case statement
	wakeReason=$(syslog | grep -i "Wake reason" | tail -n1 | grep -o "OHC\|EHC\|USB\|LID\|PWRB\|RTC")
	
	# Evaluate the variable wakeReason, which contains a single entry for a type of wake event 
	case $wakeReason in
		# If it equals "OHC," echo the type of wake event
		OHC) echo "Wake Reason:\t\tOpen Host Controller--USB or Firewire";;
		# If it equals "EHC," echo the type of wake event
		EHC) echo "Wake Reason:\t\tEnhanced Host Controller--USB, wireless, or Bluetooh)";;
		# etc.
		USB) echo "Wake Reason:\t\tUniversal Serial Bus--USB device)";;
		# etc.
		LID) echo "Wake Reason:\t\tLid--Opening of the lid)";;
		PWRB) echo "Wake Reason:\t\tPower button--Power button)";;
		RTC) echo "Wake Reason:\t\tReal Time Clock--a scheduled event: Energy Saver, launchd, user apps, backup software)";;\
		*) echo "Wake Reason:\t\tI don't know what woke me up"	
	# Close the case statement with "case" in reverse
	esac

	}

#--------------------------------
#----------BEGIN SCRIPT----------
#--------------------------------
displayLastRebootAndShutdown
displayLastSleepAndWakeTimes
displayWakeReason
