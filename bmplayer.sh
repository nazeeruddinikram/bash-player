#!/bin/bash
#  bmplayer.sh
#  
#  Copyright 2014 levi (levi0x0) (https://github.com/levi0x0/bash-player)
#  
#  bash-player is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
#  
#  bash-player is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  
#
#	Author: levi aka levi0x0 (http://github.com/levi0x0/)
#	Date: 11-04-2014
# 	Description:
#
#		"Bash-player script is A simple GUI (Graphical User Interface) for mplayer
#		Written in Shell Under Linux. "

#script version
version="0.6-2"

#videos folder
folder="/home/$USER/Videos"

#banner
banner="Bash-player $version - Copyright 2014 (C) levi0x0 (https://github.com/levi0x0)"

#date="22-01-2014"
#date="08-04-2014"
#date="11-04-2014"
date="13-04-2014"

#mplayer options (Ex FULL SCREEN: -fs)
mplayerpa=""

#status variables
debug="[DEBUG]"
error="[ERROR]"
exit="[EXIT]"

#show subtitles Dialog Default Show Dialog
#1 for show 
#0 for hide
subtitlesDialog=1

#exit in the end 
#0 for no 
#1 for yes
exitend=1

#enable mplayer utf8 support (for subtitles)
#echo utf8=true >> ~/.mplayer/config

#check if zenity installed
if zenity --version &> /dev/null ;then 
	echo "$debug Found zenity"
else
	echo "$error Zenity package not installed"
fi
#check if mplayer installed
if mplayer &> /dev/null ;then 
	echo "$debug Found mplayer"
else
	zenity --error --title="mplayer not found" --text="mplayer package not installed"
	exit
fi

#help function
help() {
zenity  --list \
	--title="Mplayer - Shortcut" \
	--ok-label="Return" \
	--cancel-label="exit" \
	--width=100 \
	--height=400 \
	--text "Help Options for Mplayer Type this with Your Keyboard in Mplayer" \
	--column "Help" \
	--column "Key" \
	"Full Screen" f \
	"Volume Up" 0 \
	"Volume Down" 9 \
	"Quit/Stop" "Esc" \
	"Pause" "Space" \
	"v" "Toggle subtitle visibility." \
	"F" "Toggle displaying forced subtitles ."\
	"T" "Toggle stay-on-top (also see -ontop)." \
	"z and x" "Adjust subtitle delay by +/- 0.1 seconds." \
	"r and t" "Move subtitles up/down." \
	"left and right" "Seek backward/forward 10 seconds." \
	"up and down" "Seek forward/backward 1 minute."
}

#bash-player function
bashplayer() {
	zenity  --question \
	--width=100 \
	--height=150 \
	--title="Bash-player - $version" \
	--ok-label="Select video" \
	--cancel-label="Help"
	#test 1
	if [ $?  -ne 0 ]; then 
		help #print help dialog
		if [ $? -ne 0 ]; then
			exit
		else
			bashplayer
		fi
	else
		#select video
		video=`zenity --file-selection --title="select video" --filename=$folder`
		if [ $? -ne 0 ]; then
			echo "$debug no File selected."
			exit
		elif [ $subtitlesDialog -eq 1 ]; then
            zenity --question --title="add subtitles"  --text="Subtitles? (You can disable this Dialog)"  --ok-label="Yes, add" --cancel-label="No, play video"
			if [ $? -ne 0 ]; then
				mplayer -title "Bash-player $version" $mplayerpa "$video"
				if [ $exitend -eq 0 ];then
					bashplayer
				else
					exit
				fi
			#else select subtitles
			else
				subtitles=`zenity --file-selection --title="select subtitles" --filename=$folder`
				#run mplayer 
				mplayer -title "Bash-player $version" $mplayerpa "$video" -sub  "$subtitles"
				if [ $exitend -eq 0 ]; then
					bashplayer
				else
					exit
				fi
			fi
		#not showing subtitle dialog do:
		else
			mplayer -title "Bash-player $version" $mplayerpa "$video"
            if [ $exitend -eq 0 ];then
                bashplayer
            else
                exit
            fi
		fi
	fi
}
 
if [ -z $1 ];then
	echo "$debug Bash-player Started..."
	bashplayer

#version
elif [[ $1 == "--version" ]]; then
	echo "Bash-player - $version"
	exit
else
	video="$1"
	mplayer -title "Bash-player $version" $mplayerpa "$video"
    if [ $exitend -eq 0 ];then
        bashplayer
    else
        exit
    fi
fi
