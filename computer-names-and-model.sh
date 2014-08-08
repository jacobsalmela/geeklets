#----------AUTHOR------------
# Jacob Salmela
# 3 December 2013

#----------RESOURCES---------
# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx
# http://blog.coriolis.ch/2011/08/01/get-your-apple-device-model-name-in-a-readable-format/

#----------VARIABLES---------
# Colors
end="\x1b[0m"	
bold="\x1b[001m"
underscore="\x1b[004m"	
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"

lastCharsInSerialNum=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-)

# Use curl to query Apple's servers while inserting the variable that contains the last characters in the Serial Number into the URL
# Pipe it into awk and use <configCode> as the new delimiter, printing the second field
# Pipe it into awk again but use </configCode> as the new delimiter, this time, printing the first field
# This leaves you with just the computer friendly name
# Thanks to n0brainer for the idea:
# https://bitbucket.org/jacob_salmela/geeklets/issue/2/computer-hardware-model-friendly-name
friendlyName=$(curl -s http://support-sp.apple.com/sp/product?cc="$lastCharsInSerialNum" | awk -F'<configCode>' '{print $2}' | awk -F'</configCode>' '{print $1}')

#----------SCRIPT------------
echo "${bold}COMPUTER NAME AND MODEL${end}"
# Print all four computer names
echo "\tHardware Model:\t\t`sysctl -n hw.model`"
echo "\tFriendly name:\t\t$friendlyName"
echo "\tComputer Name:\t\t`scutil --get ComputerName`"
echo "\tHostname:\t\t\t`scutil --get HostName`"
echo "\tLocal Hostname:\t\t`scutil --get LocalHostName`"
echo "\tNetBIOS name:\t\t`defaults read /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName`"