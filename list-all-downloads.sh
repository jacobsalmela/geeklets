#----------AUTHOR------------
# Jacob Salmela
# 12 December 2013

#----------RESOURCES---------
# http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
# http://superuser.com/questions/33914/why-doesnt-echo-support-e-escape-when-using-the-e-argument-in-macosx
# http://osxdaily.com/2012/07/12/list-download-history-mac-os-x/

#---------DESCRIPTION--------
# Shows a list of all downloaded files
# I found that it doesn't really catch everything if using a non-apple browser
# But it is still useful nonetheless

#----------VARIABLES---------
# Colors
end="\x1b[0m"
bold="\x1b[001m"
underscore="\x1b[004m"
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"

#-----------SCRIPT-----------

# Use sqlite3 to query the database of QuarantineEvents
# Select the URL string from the table LSQuarantine event
sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'
