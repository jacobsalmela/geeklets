#----------AUTHOR------------
# Jacob Salmela
# 8 August 2014
volumeName=$(diskutil info / | awk '/Volume Name/ {print substr ($0, index ($0,$3))}')

if [ "$volumeName" != "Macintosh HD" ];then 
	# If the volume is not Macintosh HD, rename it
	diskutil renameVolume "$volumeName" "Macintosh HD"
	volumeName=$(diskutil info / | awk '/Volume Name/ {print substr ($0, index ($0,$3))}')
	exit 0
else
	exit 1
fi
