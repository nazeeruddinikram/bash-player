#!/bin/bash
# mplayer_config.sh
#
# This file is part of the bash-player script 
#
# Create mplayer custom config for you!
# Author: levi (levi0x0) "http://github.com/levi0x0/bash-player"
# Version: 0.1
# Date: 13-04-2014

version=0.1

banner="Bash-player - Mplayer-config $version"

mplayer_config_path="/home/$USER/.mplayer/config"
mplayer_dir="/home/$USER/.mplayer/"

datet=`date +%d/%m/%Y-%H:%M:%S`

usage() {
	echo $banner
	echo -e "\nUsage: $0 --config"
	echo -e "\n\t-v, --version"
	echo -e "\t-c, -config - start."
	echo -e "\nThat's it! (:"
	exit
}

basic() {
	echo -e "\t\e[01;32m..::Mplayer-Basic Config::..\e[00m"
	#video driver
	echo "[!] Setting default video driver.. to xv/x11"
	echo -e "#default video driver\nvo=xv,x11" >> $mplayer_config_path
	#fixed-vo
	echo -e "fixed-vo=1" >> $mplayer_config_path
	#full screen
	echo -n "start mplayer on Full screen? (yes/no):"
	read fs_answer
	if [[ $fs_answer == "yes" ]];then
		echo -e "#full screen\nfs=yes" >> $mplayer_config_path
	else
		echo -e "#full screen\nfs=no" >> $mplayer_config_path
	fi
	#end
	#farmedrop
	echo -n "Drop frames to preserve audio/video sync? (yes/no):"
	read dp_answer
	if [[ $dp_answer == "yes" ]];then
		echo -e "#dropframes\nframedrop=yes" >> $mplayer_config_path
	else
		echo -e "#dropframes\nframedrop=no" >> $mplayer_config_path
	fi
	#end
	#db
	echo -n "Double buffering? (yes/no):"
	read db_answer
	if [[ $db_answer == "yes" ]];then
		echo -e "#db\ndouble=yes" >> $mplayer_config_path
	else
		echo -e "#db\ndouble=no" >> $mplayer_config_path
	fi
	#end
	#on top?
	echo -n "Keep the player window on top of all other windows? (yes/no):"
	read ot_answer
	if [[ $ot_answer == "yes" ]];then
		echo -e "#on top\nontop=yes" >> $mplayer_config_path
	else
		echo -e "#on tp[\nontop=no" >> $mplayer_config_path
	fi
	#end
}	
backup_config_file() {
	echo -e "\e[01;31m[!] Backing $mplayer_config_path to config.bak\e[00m"
	cp $mplayer_config_path $mplayer_dir/config.bak
    rm -r $mplayer_config_path
	echo -e "#Created by bash-player - mplayer_config.sh script " >> $mplayer_config_path
	echo -e "#http://github.com/levi0x0/bash-player" >> $mplayer_config_path
	echo -e "#Created: $datet\n" >> $mplayer_config_path
}

subtitle_config() {
	echo -e "\t\e[01;32m..::Mplayer-Subtitles Config::..\e[00m"
	echo -n "subfont-text-scale (Example: 2):"
	read  subfont_text_scale
	echo -e "#font scale\nsubfont-text-scale=$subfont_text_scale" >> $mplayer_config_path
	echo -e "Subtitles encoding:"
    echo -e "\e[01;31m[!] The full list by language is here:\e[00m"
    echo "https://github.com/levi0x0/bash-player/wiki/Subtitles"
    echo -n "Enter (Example: windows-1252):"
	read subcp
    echo -e "#subtitle encoding\nsubcp=$subcp" >> $mplayer_config_path
}



if [ -z $1 ];then
	usage
	exit
elif [[ $1 == "-c" ]] || [[ $1 == "--config" ]];then
	backup_config_file
	basic
	subtitle_config
	echo -e "\n[!] OK! all done Enjoy!"
	echo -e "[!] Bash-player will backup Your Original config file only Once!\n"
else
	usage
	exit
fi
