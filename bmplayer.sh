#!/bin/sh
#bashPlayer (bmplayer) A simple Video player based on mplayer
#Written by levi0x0
#license: GPL3
#bashPlayer 21/01/2014 - 16:26:30
#tested on: ArchLinux, Debian

#version
version = 0.3

#movies folder (change this if you need)
movies="/home/$USER/Videos/"

#enable utf8 subtitles
#echo "utf8=true" >> ~/.mplayer/config

#zenity installed?
if which mplayer 2>/dev/null; then
	echo "[DEBUG] Found zenity"
else
	zenity --error --title="zenity not installed!" --text="Please install the 'zenity' package"
	exit;
fi
#mplayer installed?
if which mplayer 2>/dev/null; then
	echo "[DEBUG] Found mplayer"
else
	zenity --error --title="mplayer not installed!" --text="Please install the 'mplayer' package"
	exit;
fi
#startup dialog
zenity --forms --title="Bmplayer - $version" --text="\nSimple GUI for- Mplayer\n\tWritten by levi0x0\n\t\tVersion 1.0.3" --ok-label="Select video" --cancel-label="quit"

#choose video
video=`zenity --file-selection --title="Select video" --filename="$movies"`
if [ $? -ne 0 ]; then
	echo "[DEBUG] File not selected."
	exit
else
	echo "[DEBUG] Found Video"
fi
#ask for subtitles
zenity --question --title="Add subtitles"  --text="Add Subtitles?"  --ok-label="add" --cancel-label="play video"
if [ $? -ne 0 ]; then
	mplayer -fs "$video" # -fs for full screen
else
	subs=`zenity --file-selection --title="Select subtitles" --filename="$movies"`
	if [ $? -ne 0 ]; then
		echo "[DEBUG] Not Selected."
		exit
	else
		mplayer -fs "$video" -sub "$subs"
	fi
fi
#done share the c0de! by levi0x0
