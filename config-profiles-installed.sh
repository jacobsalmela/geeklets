#----------AUTHOR------------
# Jacob Salmela
# 3 December 2013

#----------RESOURCES---------
# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx

# Colors
end="\x1b[0m"	
bold="\x1b[001m"
underscore="\x1b[004m"	
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"
	
# This variable stores just the number of how many are installed
# If zero, this shows up as "no"
howManyProfiles=$(profiles -C | awk '/installed/ {print $3}')

echo "${bold}PROFILES${end}"

if [ $howManyProfiles != "no" ];then
	# List the amount profiles that are "installed"
	profilesStatus=$(profiles -C | awk /installed/)
	echo "\t✅ $profilesStatus"
	
	# Sorted list of installed profiles
	profiles -Cvv | awk '/attribute\:\ name/ {print "\t\t➡ " substr ($0, index ($0,$4))}' | sort
else
	# If none, it will just read, "There are no system configuration profiles installed."
	profiles -C | awk '/installed/'

fi
