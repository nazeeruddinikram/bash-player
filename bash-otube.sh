#!/bin/bash
# bash-otube.sh
#
# This file is part of the bash-player script 
#
# Play videos from Online Website!
# Supported sites:
# http://rg3.github.io/youtube-dl/supportedsites.html
# Author: levi (levi0x0) "http://github.com/levi0x0/bash-player"
# Version: 0.1
# Date: 05-05-2014
#NOTE: Bash-OTube is in alpha stage Please Report Bugs.

#version
version=0.1

#banner
banner="Bash-OTube - Play Online Videos $version"

#status variables
debug="[DEBUG]"
error="[ERROR]"
exit="[EXIT]"

#Random Video Name
VideoName=`cat /dev/urandom | tr -dc 0-9 | head -c5`

#OtubeVideo
OTubeVideo="/tmp/${VideoName}"

#if zenity installed
if zenity --version &> /dev/null ;then 
	echo "$debug Found zenity"
else
	echo "$error Zenity package not installed"
	exit
fi

if youtube-dl --version &> /dev/null;then
	echo "$debug Found youtube-dl"
else
	zenity --error \
	--title="YouTubeDL Not Found" \
	--text="You-Tube Dl not found"
	exit
fi

#if mplayer installed
if mplayer &> /dev/null ;then
	PLAYER="mplayer" 
	echo "$debug Found mplayer"
else
	if mpv &> /dev/null ;then
	PLAYER="mpv" 
	echo "$debug Found mpv"
	else
		zenity --error \
			--title="mplayer/mpv not found" \
			--text="mplayer/mpv package not installed"
		exit
	fi
fi

#dialog
bash_otube() {
	url=`zenity --entry \
	--title="Bash-OTube $version" \
	--text="Video URL:" \
	--ok-label="Play Video!" \
	--cancel-label="Quit"` 
	if [ $? -ne 0 ];then
		echo "$debug Bye Bye!"
		exit
	else
		if [[ $PLAYER == "mplayer" ]];then
			youtube-dl -q $url -o $OTubeVideo & 
			echo "$debug Waiting for youtube-dl to start.. [5s]"
			#DO NOT DELETE THE DELAY LINE!
			sleep 6 | zenity --progress \
			--title="Downloading Video Info.." \
			--auto-close \
			--pulsate \
			--no-cancel \
			--text "Downloading Video Info.." &
			sleep 6
			$PLAYER "${OTubeVideo}.part"
			echo "$debug Removing Played Video.."
			killall -9 youtube-dl
			rm -r "${OTubeVideo}.part"
		else
			mpv $url
		fi
	fi
}
p

if [ -z $1 ];then
	echo "$debug Bash-OTube-Started.."
	bash_otube
elif [[ $1 == "--version" ]] || [[ $1 == "-v" ]];then
	echo "-Bash-OTube $version"
	exit
fi
