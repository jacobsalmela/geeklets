#!/bin/bash
appUpdates=$(pgrep installd)
swUpdates=$(pgrep softwareupdated)

if [ -n "$appUpdates" ];then
	echo "Apps are being updated..."
else
	:
fi

if [ -n "$swUpdates" ];then
	echo "Software Update is running..."
else
	:
fi

