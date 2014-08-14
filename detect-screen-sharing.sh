# Detect remote sessions
# Colors
end="\x1b[0m"
bold="\x1b[001m"
underscore="\x1b[004m"
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"

port5900detected=$(netstat -n | grep 5900)
if [[ -z "$port5900detected" ]];then
    echo "\t✅ VNC"
else
    echo "\t🔴 ${red}VNC!${end}"
    afplay /Users/Shared/alert07.mp3
fi