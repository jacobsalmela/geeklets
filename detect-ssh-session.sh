# Detect ssh sessions
# Colors
end="\x1b[0m"
bold="\x1b[001m"
underscore="\x1b[004m"
red="\x1b[031m"
green="\x1b[032m"
yellow="\x1b[033m"

port22detected=$(netstat -p tcp | grep ssh)
if [[ -z "$port22detected" ]];then
    echo "\t✅ SSH"
else
    echo "\t🔴 ${red}SSH!${end}"
fi