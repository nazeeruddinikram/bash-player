#!/bin/bash
# mplayer_config.sh
#
# This file is part of the bash-player script 
#
# Create mplayer custom config for you!
# Author: levi (levi0x0) "http://github.com/levi0x0/bash-player"
# Version: 0.3
# Date: 24-04-2014

version=0.3

banner="Bash-player - Mplayer/Mpv-config $version"

mplayer_dir="/home/$USER/.mplayer/"
mpv_dir="/home/$USER/.mpv/"


#mpv support
if [ -d $mplayer_dir ];then
	dir=$mplayer_dir
	config_path="/home/$USER/.mplayer/config"
elif [ -d $mpv_dir ];then
	dir=$mpv_dir
	config_path="/home/$USER/.mpv/config"
else
	echo "Mplayer/mpv config dir not found.!"
	exit
fi

datet=`date +%d/%m/%Y-%H:%M:%S`

usage() {
	echo $banner
	echo -e "\nUsage: $0 --config"
	echo -e "\n\t-v, --version"
	echo -e "\t--config - auto config."
	echo -e "\t--mplayer - for mplayer"
	echo -e "\t--mpv - for mpv"
	echo -e "\nUsage Example:"
	echo -e "\tMplayer: $0 --mplayer" 
	echo -e "\tMPV: $0 --mpv"
	echo -e "\tAuto: $0 --config\n"
	echo -e "\n#BashPlayer2014\n"
	exit
}

basic() {
	echo -e "\t\e[01;32m..::Mplayer-Basic Config::..\e[00m"
	#video driver
	echo "[!] Setting default video driver.. to xv/x11"
	echo -e "#default video driver\nvo=xv,x11" >> $config_path
	echo -n "=> Audio output (Example: alsa, pulse):"
	read ao
	echo -e "#audio output\nao=$ao" >> $config_path
	#fixed-vo
	echo -e "fixed-vo=1" >> $config_path
	#mixer
	echo -n "=> mixer channel: (Example: Master):"
	read mixer
	echo -e "#mixer channel\nmixer-channel=$mixer" >> $config_path
	#full screen
	echo -n "=> start mplayer on Full screen? (yes/no):"
	read fs_answer
	if [[ $fs_answer == "yes" ]];then
		echo -e "#full screen\nfs=yes" >> $config_path
	else
		echo -e "#full screen\nfs=no" >> $config_path
	fi
	#end
	#farmedrop
	echo -n "=> Drop frames to preserve audio/video sync? (yes/no):"
	read dp_answer
	if [[ $dp_answer == "yes" ]];then
		echo -e "#dropframes\nframedrop=yes" >> $config_path
	else
		echo -e "#dropframes\nframedrop=no" >> $config_path
	fi
	#end
	#db
	echo -n "=> Double buffering? (yes/no):"
	read db_answer
	if [[ $db_answer == "yes" ]];then
		echo -e "#db\ndouble=yes" >> $config_path
	else
		echo -e "#db\ndouble=no" >> $config_path
	fi
	#end
	#on top?
	echo -n "=> Keep the player window on top of all other windows? (yes/no):"
	read ot_answer
	if [[ $ot_answer == "yes" ]];then
		echo -e "#on top\nontop=yes" >>$config_path
	else
		echo -e "#on top\nontop=no" >> $config_path
	fi
	#end
}	
backup_config_file() {
	echo -e "\e[01;31m[!] Backing $config_path to config.bak\e[00m"
	cp $config_path $dir/config.bak
    	rm -r $config_path
	echo -e "#Created by bash-player - mplayer_config.sh script " >> $config_path
	echo -e "#http://github.com/levi0x0/bash-player" >> $config_path
	echo -e "#Created: $datet\n" >> $config_path
}

subtitle_config() {
	echo -e "\t\e[01;32m..::Mplayer-Subtitles Config::..\e[00m"
	echo -n "subfont-text-scale (Example: 2):"
	read  subfont_text_scale
	echo -e "#font scale\nsubfont-text-scale=$subfont_text_scale" >> $config_path
	echo -e "Subtitles encoding:"
   	echo -e "\e[01;31m[!] The full list by language is here:\e[00m"
    	echo "https://github.com/levi0x0/bash-player/wiki/Subtitles"
    	echo -n "Enter (Example: windows-1252):"
	read subcp
    	echo -e "#subtitle encoding\nsubcp=$subcp" >> $config_path
	#unicode
	echo -n "Unicode support? (yes/no):"
	read unicode
	if [[ $unicode == "yes" ]];then
		echo -e "#Unicode\nunicode=yes" >> $config_path
	else
		echo -e "#Unicode\nunicode=no" >> $config_path
	fi
	#utf-8
	echo -n "UTF-8 support? (yes/no):"
	read utf8
	if [[ $utf8 == "yes" ]];then
		echo -e "#UTF-8\nutf8=yes" >> $config_path
	else
		echo -e "#UTF-8\nutf8=no" >> $config_path
	fi
}



if [ -z $1 ];then
	usage
	exit
elif [[ $1 == "--mpv" ]];then
        dir=$mpv_dir
        config_path="/home/$USER/.mpv/config"
	backup_config_file
        basic
        subtitle_config	
	echo -e "\n[!] Saved to $config_path"
	echo -e "[!] Backup Saved to $config_path.bak\n"
elif [[ $1 == "--mplayer" ]];then
	dir=$mplayer_dir
        config_path="/home/$USER/.mplayer/config"
	backup_config_file
	basic
	subtitle_config	
	echo -e "\n[!] Saved to $config_path"
	echo -e "[!] Backup Saved to $config_path.bak\n"
elif [[ $1 == "--config" ]];then
	backup_config_file
        basic
        subtitle_config
	echo -e "\n[!] Saved to $config_path"
	echo -e "[!] Backup Saved to $config_path.bak\n"
elif [[ $1 == "-v" ]] || [[ $1 == "--version" ]];then
	echo "Mplayer_config.sh $version - Written by levi0x0"
else
	usage
	exit
fi
