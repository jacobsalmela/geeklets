#----------AUTHOR------------
# Jacob Salmela
# 12 December 2013

#----------RESOURCES---------
# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx
# http://osxdaily.com/2012/12/21/list-wi-fi-networks-mac-has-connected-to-before/

#----------VARIABLES---------
# Colors
end="\x1b[0m"	
bold="\x1b[001m"
underscore="\x1b[004m"	
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"

# Set the undesired network here
guestNetwork="Unwanted-SSID"
# Tested on 10.9 -- Previous versions use a different string than "SSIDString"
preferredNetworks=$(defaults read /Library/Preferences/SystemConfiguration/com.apple.airport.preferences RememberedNetworks | awk '/SSIDString/ {print $3, $4}' | sed 's/[";]//g')
guestExists=$(echo "$preferredNetworks" | grep "$guestNetwork")

#-----------SCRIPT-----------
echo "${bold}PREFERRED NETWORKS${end}"
if [ $guestExists = "$guestNetwork" ];then
	echo "\t🔴 ${red}$guestNetwork is in the preferred list${end}"
else
	echo "\t✅ ${green}No problems found${end}"
fi