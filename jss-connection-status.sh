#----------AUTHOR------------
# Jacob Salmela
# 3 December 2013

#----------RESOURCES---------
# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx

#----------VARIABLES---------
# JSS connection status
# Colors
end="\x1b[0m"	
bold="\x1b[001m"
underscore="\x1b[004m"	
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"

#-----------SCRIPT-----------
echo "${bold}JSS${end}"
# Check the connection to the JSS only once (never retry) and send any messages into a black hole (we don't need to see them)
jamf checkJSSConnection -retry 0 &>/dev/null
jamfVersion=$(jamf -version | cut -d'=' -f2)
	
# If the last command completed successfully
if [ $? = 0 ];then
	# Then create a variable that runs the command again, but 
	jssConnection=$(jamf checkJSSConnection -retry 0 | grep "available")
	jamfVersion=$(jamf -version | cut -d'=' -f2)
	echo "\t✅ Status\t\t\t\t${green}$jssConnection${end}\t$jamfVersion"

else
	jssConnection=$(jamf checkJSSConnection -retry 0 | grep "Could not connect")
	echo "\t🔴 Status\t\t\t\t${red}$jssConnection${end}"
fi
