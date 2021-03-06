#!/bin/bash
# bash-otube.sh
#
# This file is part of the bash-player script 
#
# Watch videos from Online Websites!
# Supported sites:
# http://rg3.github.io/youtube-dl/supportedsites.html
# Author: levi (levi0x0) "http://github.com/levi0x0/bash-player"
# Version: 0.1
# Date: 05-05-2014
#NOTE: Bash-OTube is in alpha stage Please Report Bugs.

#version
version="0.3"

#banner
banner="Bash-OTube - Watch Online Videos $version"

#delay for the cache
#if your internet Connection is Slow Set to 10 or more 
#if your internet Connection fast set to 5! (Dont set to 1,2,3,4 etc..)
delay=8

#Download Limit Rate (Example: 50K, 100K, 4.4M)
dl="100M"

#Delete Videos after Playing
#0 - for no
#1 - for yes
delap=1


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

#if mplayer installed
if mpv &> /dev/null ;then
	PLAYER="mpv" 
	echo "$debug Found mpv"
else
	if mplayer &> /dev/null ;then
		PLAYER="mplayer" 
		if youtube-dl --version &> /dev/null;then
			echo "$debug Found youtube-dl"
		else
			zenity --error \
			--title="YouTube-dl Not Found" \
			--text="You-Tube-dl not found"
			exit
		fi
	else
		zenity --error \
			--title="mplayer/mpv not found" \
			--text="mplayer/mpv package not installed"
		exit
	fi
fi

#set player without checks
#PLAYER="mplayer"

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
			#First bash-otube will try to open stream (Maybe the file is .mp4,flv etc..)
			ret=`$PLAYER -title "Bash-Otube $version" -quiet $url | grep -c "Starting playback"`
			if [ $ret -eq 1 ];then
				echo "$debug Success."
				exit
			fi
			#if the file is a URL Stream (like YouTub etc..)
			youtube-dl -q $url \
			-o $OTubeVideo &
			echo "$debug Waiting for youtube-dl to start.. [5s]"
			#DO NOT DELETE THE DELAY LINE!
			sleep $delay | zenity --progress \
			--title="Downloading Video Info.." \
			--auto-close \
			--pulsate \
			--no-cancel \
			--text "Downloading Video Info.." &
			sleep $delay
			VideoTitle=`youtube-dl --get-title $url`
			$PLAYER -title "${VideoTitle}" "${OTubeVideo}.part"
			echo "$debug Removing Played Video.."
			killall -9 youtube-dl
			if [[ $delap -ne 0 ]];then
				rm -r "${OTubeVideo}.part"
				rm -r "${OTubeVideo}"
			else
				mv "${OTubeVIdeo}.part" "${OTubeVideo}.${vf}"
			fi
		else
			mpv -title "${VideoTitle}" "$url"
		fi
	fi
}

if [ -z $1 ];then
	echo "$debug Bash-OTube-Started.."
	bash_otube
elif [[ $1 == "--version" ]] || [[ $1 == "-v" ]];then
	echo "-Bash-OTube $version"
	exit
fi
