# Google Analytics geeklet
# Author: Jacob Salmela 
# http://jacobsalmela.com
# 2014-08-15
# Inspired by http://www.visualab.org/index.php/using-google-rest-api-for-analytics
# This script is meant to run as a geeklet once you have OAuth 2.0 set up (and you filled in the variables below)
# By default, it will display today's visits but the metric can be changed
# Set this geeklet to refresh every 3500 seconds or so (the token is valid for 1 hour, so this gives a little bit of a buffer
# The biggest caveat is that if the token expires, you have to go through the process of requesting another one and pasting the values back in
# That said, this geeklet would work best on a computer that never shuts down`

#---------VARIABLES-------
# Colors
# These could be used for as a visual indicator if you want x amount of visitors to be green (good) and y amount to be red (not enough visitors)
end="\x1b[0m"
bold="\x1b[001m"
underscore="\x1b[004m"
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"

# These should be all filled in after OAuth is set up
# Instructions to do so are here: 
# 			http://jacobsalmela.com/oauth-2-0-google-analytics-desktop-using-geektool-bash-curl/ 

# API credentials
clientID=""
clientSecret=""
redirectURI=""

# OAuth tokens and codes
# Get an authorization code
# https://accounts.google.com/o/oauth2/auth?scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fanalytics&redirect_uri=$redirectURI&response_type=code&client_id=$clientID
authorizationCode=""

# Once you have these two tokens, the script can run automatically. 
accessToken=""
refreshToken=""

# Google Analytics ID and desired metric
# Just the number, do not prefix with ga:
# profileID="12345678"
#		NOT 
# profileID="ga:12345678"
profileID=""
desiredMetric="visits"

# Stores todays date so numbers always reflect today
today=$(date "+%Y-%m-%d")

#----------SCRIPT----------
echo "${bold}GOOGLE ANALYTICS${end}"
printf "\tVisits today:\t"
curl -s "https://www.googleapis.com/analytics/v3/data/ga?ids=ga:$profileID&metrics=ga:$desiredMetric&start-date=$today&end-date=$today&access_token=$accessToken" | tr , '\n' | grep "totalsForAllResults" | cut -d'"' -f6

# Refresh OAuth token
curl -s -d "client_id=$clientID&client_secret=$clientSecret&refresh_token=$refreshToken&grant_type=refresh_token" https://accounts.google.com/o/oauth2/token >/dev/null
 