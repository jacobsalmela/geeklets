# Detect remote sessions
# Colors
end="\x1b[0m"
bold="\x1b[001m"
underscore="\x1b[004m"
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"

echo "${bold}REMOTE CONNECTIONS${end}"
userConnected=$(cat /var/log/system.log | grep -i "screensharingd" | grep -i "Authentication: SUCCEEDED" | tail -n1 | awk '{print $11}')
originIP=$(cat /var/log/system.log | grep -i "screensharingd" | grep -i "Authentication: SUCCEEDED" | tail -n1 | awk '{print $15}')
timeConnected=$(cat /var/log/system.log | grep -i "screensharingd" | grep -i "Authentication: SUCCEEDED" | tail -n1 | awk '{print $3}')

port5900detected=$(netstat -n | grep 5900)
if [[ -z "$port5900detected" ]];then
	echo "\t✅ Nominal"
else
	echo "\t🔴 ${red}Remote session detected!${end}"
	who
	logEntries=$(cat /var/log/system.log | grep -i screensharingd | tail -n 3 | awk '{print $1, $2, $3, $4, $11, $15}')
	echo "${red}TAIL LOG ENTRIES${end}"
	echo "$logEntries"
	
fi