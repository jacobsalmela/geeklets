#!/bin/bash
#----------AUTHOR------------
# Jacob Salmela
# 11 March 2014

#---------DESCRIPTION--------
# You Mac speaks to you when an Ethernet cable is plugged in or out

#----------VARIABLES---------
ethernetDevice=$(/usr/sbin/networksetup -listallhardwareports | awk "/Hardware Port: Ethernet/,/Device/" | awk 'NR==2' | cut -d " " -f 2)
interfaceStatus=$(ifconfig $ethernetDevice | grep 'active' | awk '{print $2}')
interfaceDown=$(ifconfig $ethernetDevice | grep 'inactive' | awk '{print $2}')

#------------USAGE-----------
# Set this to run every 0 seconds in GeekTool
# When you plug in or unplug an Ethernet cable, the computer will verbally tell you
# Works great for quickly testing network ports without having to open Network Preferences and watch the jellies

#-------BEGIN SCRIPT-----------
if [ "$interfaceStatus" = "active" ]; then
	say -v "Samantha" "Your hardline is $interfaceStatus" &> /dev/null
else
	say -v "Samantha" "Your hardline is $interfaceDown" &> /dev/null
fi
