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
#		"Bash-player is A simple GUI (Graphical User Interface) for mplayer
#		Written in Shell Under Linux. "
#
# The script need 2 pakcages to run:
#
#	1. mplayer
#	2. zenity
#
# ###### How to install Mplayer ######
#
# * on Ubuntu/Debian/LinuxMint:
# 
# sudo apt-get install mplayer
#
# * on Fedora:
#
# sudo yum install mplayer
#
# * on Arch Linux:
#
# sudo pacman -S mplayer
#
# ###### How to install Zenity ######
#
# * on Ubuntu/Debian/LinuxMint:
# 
# sudo apt-get install zenity
#
# * on Fedora:
#
# sudo yum install zenity
#
# * on Arch Linux:
#
# sudo pacman -S zenity
#
# That's it!
########################

#script version
version=0.6

#videos folder
folder="/home/$USER/Videos"

#banner
banner="Bash-player $version - Copyright 2014 (C) levi0x0 (https://github.com/levi0x0)"

#date="22-01-2014"
#date="08-04-2014"
date="11-04-2014"

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

#exit in the and 
#0 for yes 
#1 for no
exitend=0

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
		video=`zenity --file-selection --title="Select video" --filename=$folder`
		if [ $? -ne 0 ]; then
			echo "$debug no File selected."
			exit #exit
		elif [ $subtitlesDialog -eq 1 ]; then
			zenity --question --title="add subtitles"  --text="Want to add Subtitles?"  --ok-label="Yes, add" --cancel-label="No, play video"
			if [ $? -ne 0 ]; then
				mplayer -title "Bash-player $version" $mplayerpa "$video"
				if [ $exitend -eq 0 ];then
					bashplayer
				else
					exit
				fi
			#else select subtitles
			else
				subtitles=`zenity --file-selection --title="Select subtitles" --filename=$folder`
				#run mplayer 
				mplayer -title "Bash-player $version" $mplayerpa "$video" -sub  "$subtitles"
				if [ $exitend -eq 0 ]; then
					bashplayer
				else
					exit
				fi
			fi
		#not showing subtitle dialog
		else
			mplayer -title "Bash-player $version" $mplayerpa "$video"
		fi
	fi
}

#check for command line args 
if [ -z $1 ];then
	echo "$debug No args.."
	bashplayer

#version
elif [[ $1 == "--version" ]]; then
	echo "Bash-player - $version"
	exit
else
	video="$1"
	mplayer -title "Bash-player $version" $mplayerpa "$video"
fi
