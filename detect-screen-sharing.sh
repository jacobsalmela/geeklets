# Detect remote sessions
# Colors
end="\x1b[0m"
bold="\x1b[001m"
underscore="\x1b[004m"
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"

port5900detected=$(netstat -n | grep 5900)

# The variable above works on any system, but as a side effect, detects both incoming and outgoing ssh sessions
# If you want to detect only incoming ones, you need to add your IP into the command
# If you feel comfortable with scripting, uncomment the necessary variables below

#wifiOrAirport=$(/usr/sbin/networksetup -listallnetworkservices | grep -Ei '(Wi-Fi|AirPort)')
#wirelessDevice=$(/usr/sbin/networksetup -listallhardwareports | awk "/$wifiOrAirport/,/Device/" | awk 'NR==2' | cut -d " " -f 2)
#wirelessIP=$(ipconfig getifaddr $wirelessDevice)
#wiredDevice=$(networksetup -listallhardwareports | grep -A 1 "Port: Ethernet" | sed -n 's/Device/&/p' | awk '{print $2}')
#wiredIP=$(ipconfig getifaddr $wiredDevice) 2>/dev/null
#port5900detected=$(netstat -n | grep "$wirelessIP.5900")
#port5900detected=$(netstat -n | grep "$wiredIP.5900")

if [[ -z "$port5900detected" ]];then
    echo "\t✅ VNC"
else
    echo "\t🔴 ${red}VNC!${end}"
    afplay /Users/Shared/alert07.mp3
fi