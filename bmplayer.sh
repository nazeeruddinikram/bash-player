#!/bin/bash
#  bmplayer.sh
#  
#  Copyright 2014 levi (https://github.com/levi0x0/bash-player)
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

#version
version=0.5

#videos folder
folder="/home/$USER/Videos"


#date="22-01-2014"
date="08-04-2014"

#mplayer options (Ex FULL SCREEN: -fs)
mplayerpa=""

#status var
debug="[DEBUG]"
error="[ERROR]"
exit="[EXIT]"

#exit in the and 0 for yes 1 for no
exitend=1

#enable mplayer utf8 support (for subtitles)
#echo utf8=true >> ~/.mplayer/config

#check if zenity installed
if which zenity 2> /dev/null ;then 
	echo "$debug Found zenity"
else
	echo "$error Zenity package not installed"
fi
#check if mplayer installed
if  which mplayer 2> /dev/null ;then 
	echo "$debug Found mplayer"
else
	zenity --error --title="mplayer not found" --text="mplayer package not installed"
	exit
fi

	
dialog() {
	zenity  --question \
	--title="Bmplayer - $version" \
	--ok-label="Select video" \
	--cancel-label="exit"
	#test 1
	if [ $?  -ne 0 ]; then 
		echo "$exit Canceld..."
		exit #exit
	else
		#select video
		video=`zenity --file-selection --title="Select video" --filename=$folder`
		if [ $? -ne 0 ]; then
			echo "$debug no File selected."
			exit #exit
		else
			zenity --question --title="add subtitles"  --text="Want to add Subtitles?"  --ok-label="Yes, add" --cancel-label="No, play video"
			if [ $? -ne 0 ]; then
				mplayer $mplayerpa "$video"
				if [ $exitend -eq 0 ];then
					dialog
				else
					exit
				fi
			#else select subtitles
			else
				subtitles=`zenity --file-selection --title="Select subtitles" --filename=$folder`
				#run mplayer 
				mplayer $mplayerpa "$video" -sub  "$subtitles"
				if [ $exitend -eq 0 ]; then
					dialog
				else
					exit
				fi
			fi
		fi
	fi
}

#check for command line args 
if [ -z $1 ];then
	echo "$debug No CLA"
	dialog
else
	video="$1"
	mplayer $mplayerpa "$video"
fi
