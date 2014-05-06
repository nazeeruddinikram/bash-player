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
version="0.2"

#banner
banner="Bash-OTube - Watch Online Videos $version"

#delay for the cache
#if your internet Connection is Slow Set to 10 or more 
#if your internet Connection fast set to 5! (Dont set to 1,2,3,4 etc..)
delay=6

#Video Format (Example: mp4, flv)
vf="mp4"

#Audio Format (Example: mp3, wav)
af=wav

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
			youtube-dl -f $vf -q $url \
			--audio-format $af \
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
