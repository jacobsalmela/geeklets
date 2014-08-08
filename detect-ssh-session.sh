# Detect remote sessions
# Colors
end="\x1b[0m"
bold="\x1b[001m"
underscore="\x1b[004m"
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"

echo "${bold}REMOTE CONNECTIONS${end}"

port22detected=$(lsof -i | grep -i ssh)
if [[ -z "$port22detected" ]];then
	echo "\t✅ Nominal"
else
	echo "\t🔴 ${red}Remote session detected!${end}"
	sshSessions=$(lsof -i | grep -i ssh | awk '{print $3, $9, $10}')
	echo "$sshSessions"
	logEntries=$(cat /var/log/system.log | grep -i sshd | grep -i "Accepted keyboard-interactive/pam for" | tail -n 3 | awk '{print $1, $2, $3, $4, $9, $11}')
	echo "${red}TAIL LOG ENTRIES${end}"
	echo "$logEntries"
	
fi