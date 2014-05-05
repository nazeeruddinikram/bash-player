#!/bin/bash
# install.sh
#
# This file is part of the bash-player script 
#
# Install bash-player to Your System
# Author: levi (levi0x0) "http://github.com/levi0x0/bash-player"
# Version: 0.2
# Date: 02-05-2014

#bin dir for bmplayer.sh
bin="/usr/bin/"
#pixmap dir for bash-player.png
pixmaps="/usr/share/pixmaps/"
#desktop dir for bash-player.desktop
desktop="/usr/share/applications"

#version
version="0.2"

#status variables
debug="[DEBUG]"
error="[ERROR]"
exit="[EXIT]"

#banner
banner="Bash-player Installer $version Copyright 2014 (C) levi (levi0x0)"

installbp() {
	echo -e "\t[Bash-Player Installer]"
	if [ $UID != 0 ];then
		echo "$debug Please run as root! we need to move files."
		echo -e "Look at the source! (:\n"
		exit
	else
		echo "$debug We are ready to Go!"
	fi
	#moving bmplayer.sh to /usr/bin
	echo "$debug Moving bmplayer.sh.."
	install -Dm755 bmplayer.sh "${bin}/bmplayer"
	install -Dm755 bash-otube.sh "${bin}/botube"
	#moving the icon tho pixmaps
	echo "$debug Moving bash-player.png.. to $pixmaps"
	install -Dm755 bash-player.svg $pixmaps
	install -Dm755 bash-otube.svg $pixmaps
	#moving desktop 
	echo "$debug Moving bash-player.desktop.. to $desktop"
	install -Dm755  bash-player.desktop $desktop
	install -Dm755  bash-otube.desktop $desktop
    	#moving bmplayer_sh
    	echo "$debug Moving mplayer_config.sh to $bin"
    	install -Dm755 mplayer_config.sh $bin/mplayer_config
	echo -e "\nOK! Bash-player installed.!"
	echo "Use your Application menu to start bash-player"
	echo -e "Or run 'bmplayer/mplayer_config' from the terminal..\n" 
}

uninstallbp() {
	echo -e "\t[Bash-Player uninstaller]"
	if [ $UID != 0 ];then
		echo "$debug Please run as root! we need to remove files."
		echo -e "Look at the source! (:\n"
		exit
	else
		echo "$debug We are ready to Go!"
	fi
	#removing bmplayer.sh to /usr/bin
	echo "$debug removing bmplayer.."
	rm -f "${bin}/bmplayer"
	rm -f "${bin}/botube"
	#removing the icon to pixmaps
	echo "$debug rmoving bash-player.png.."
	rm -f "${pixmaps}/bash-player.svg"
	rm -f "${pixmaps}/bash-otube.svg"
	#removing desktop 
	echo "$debug removing bash-player.desktop.."
	rm -f "${desktop}/bash-player.desktop"
	rm -f "${desktop}/bash-otube.desktop"
    	#removing mplayer_config.sh
    	echo "$debug removing mplayer_config.sh.."
    	rm -f $bin/mplayer_config
	echo -e "\nOK! Bash-player Not installed.!"
}

if [ -z $1 ]; then
	echo $banner
	echo -e "\nUsage: $0 [ install | uninstall ]"
	echo -e "\n\tTo install: $0 install"
	echo -e "\tTo uninstall: $0 uninstall"
	echo -e "\nThat's it! (:"
	exit
elif [[ $1 == "install" ]] || [[ $1 == "i" ]];then
	installbp
elif [[ $1 == "uninstall" ]] || [[ $1 == "u" ]];then 
	uninstallbp
fi
